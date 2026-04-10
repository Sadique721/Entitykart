package com.grownited.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.AddressEntity;
import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.OrderEntity.OrderStatus;
import com.grownited.entity.OrderEntity.PaymentStatus;
import com.grownited.entity.PaymentEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.PaymentRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailerService;
import com.grownited.service.StockService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class OrderController {

    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private AddressRepository addressRepository;
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
	private MailerService mailerService;
    
    @Autowired
	private StockService stockService;
    
    // Also add Logger for error logging
    private static final Logger log = LoggerFactory.getLogger(OrderController.class);
    
    
 // ==================== CUSTOMER SIDE ====================

 // View my orders
 @GetMapping("/orders")
 public String myOrders(HttpSession session, Model model) {
     UserEntity currentUser = (UserEntity) session.getAttribute("user");
     if (currentUser == null) {
         return "redirect:/login";
     }

     // Get all orders for the current user
     List<OrderEntity> orders = orderRepository.findByCustomerIdOrderByOrderDateDesc(currentUser.getUserId());

     // Build a map: orderId -> list of order items with product details
     Map<Integer, List<Map<String, Object>>> orderDetailsMap = new HashMap<>();

     for (OrderEntity order : orders) {
         // Fetch order details with product info
         List<Object[]> details = orderDetailRepository.findOrderDetailsWithProductInfo(order.getOrderId());
         List<Map<String, Object>> itemList = new ArrayList<>();

         for (Object[] row : details) {
             OrderDetailEntity detail = (OrderDetailEntity) row[0];
             String productName = (String) row[1];
             String productImage = (String) row[2];

             Map<String, Object> item = new HashMap<>();
             item.put("productId", detail.getProductId());
             item.put("productName", productName);
             item.put("productImage", productImage);
             item.put("quantity", detail.getQuantity());
             item.put("price", detail.getPrice());
             item.put("subtotal", detail.getSubtotal());

             itemList.add(item);
         }
         orderDetailsMap.put(order.getOrderId(), itemList);
     }

     model.addAttribute("orders", orders);
     model.addAttribute("orderDetailsMap", orderDetailsMap);

     return "myOrders";
 }
    
    // View order details - COMPLETE IMPLEMENTATION
    @GetMapping("/order/details")
    public String orderDetails(@RequestParam Integer orderId,
                               HttpSession session,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        
        // CRITICAL: Verify order belongs to current user
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Order not found or you don't have permission to view it!");
            return "redirect:/orders";
        }
        
        OrderEntity order = orderOpt.get();
        Optional<AddressEntity> addressOpt = addressRepository.findById(order.getAddressId());
        Optional<PaymentEntity> paymentOpt = paymentRepository.findByOrderId(orderId);
        
        // Get order details with product info
        List<Object[]> orderDetails = orderDetailRepository.findOrderDetailsWithProductInfo(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("address", addressOpt.orElse(null));
        model.addAttribute("payment", paymentOpt.orElse(null));
        model.addAttribute("orderDetails", orderDetails);
        
        return "orderDetails";
    }
    
    // Order confirmation page
    @GetMapping("/order/confirmation")
    public String orderConfirmation(@RequestParam Integer orderId,
                                    HttpSession session,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Order not found!");
            return "redirect:/orders";
        }
        
        OrderEntity order = orderOpt.get();
        Optional<AddressEntity> addressOpt = addressRepository.findById(order.getAddressId());
        Optional<PaymentEntity> paymentOpt = paymentRepository.findByOrderId(orderId);
        
        // Get order details with product info
        List<Object[]> orderDetails = orderDetailRepository.findOrderDetailsWithProductInfo(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("address", addressOpt.orElse(null));
        model.addAttribute("payment", paymentOpt.orElse(null));
        model.addAttribute("orderDetails", orderDetails);
        
        return "orderConfirmation";
    }
    
    // Cancel order
    @GetMapping("/order/cancel")
    @Transactional  // Add transactional for atomicity
    public String cancelOrder(@RequestParam Integer orderId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Order not found!");
            return "redirect:/orders";
        }
        
        OrderEntity order = orderOpt.get();
        
        if (!order.canBeCancelled()) {
            redirectAttributes.addFlashAttribute("error", 
                "Order cannot be cancelled in " + order.getOrderStatus() + " status!");
            return "redirect:/order/details?orderId=" + orderId;
        }
        
        // Restore stock for each item in the order
        List<OrderDetailEntity> orderDetails = orderDetailRepository.findByOrderId(orderId);
        for (OrderDetailEntity detail : orderDetails) {
            stockService.restoreStock(detail.getProductId(), detail.getQuantity());
        }
        
        OrderStatus oldStatus = order.getOrderStatus();
        order.setOrderStatus(OrderStatus.CANCELLED);
        
        // Send cancellation email
        try {
        	mailerService.sendOrderStatusUpdateEmail(currentUser, order, oldStatus.toString(), "CANCELLED");
        } catch (Exception e) {
            log.error("Failed to send cancellation email for order {}: {}", orderId, e.getMessage());
        }
        
        session.setAttribute("successMessage", "Order cancelled successfully!");
        return "redirect:/orders";
    }
    
    // ==================== ADMIN SIDE ====================
    
    // Admin: View all orders
    @GetMapping("/admin/orders")
    public String adminOrders(HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        // Get all orders
        List<OrderEntity> orders = orderRepository.findAll();
        model.addAttribute("orders", orders);
        
        // Get order statistics
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalOrders", orderRepository.count());
        
        long placedOrders = orderRepository.countByOrderStatus(OrderStatus.PLACED);
        long confirmedOrders = orderRepository.countByOrderStatus(OrderStatus.CONFIRMED);
        stats.put("pendingOrders", placedOrders + confirmedOrders);
        stats.put("deliveredOrders", orderRepository.countByOrderStatus(OrderStatus.DELIVERED));
        
        Double totalRevenue = orderRepository.getTotalRevenue();
        stats.put("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
        
        model.addAttribute("stats", stats);
        
        // Get customer names for each order
        Map<Integer, String> customerNames = new HashMap<>();
        Map<Integer, Integer> itemCounts = new HashMap<>();
        
        for (OrderEntity order : orders) {
            // Get customer name
            Optional<UserEntity> customerOpt = userRepository.findById(order.getCustomerId());
            if (customerOpt.isPresent()) {
                UserEntity customer = customerOpt.get();
                String customerName = customer.getName() != null ? customer.getName() : 
                                      (customer.getName() + " " + customer.getName());
                customerNames.put(order.getOrderId(), customerName);
            } else {
                customerNames.put(order.getOrderId(), "Customer #" + order.getCustomerId());
            }
            
            // Get item count for order
            List<OrderDetailEntity> details = orderDetailRepository.findByOrderId(order.getOrderId());
            int totalItems = details.stream().mapToInt(OrderDetailEntity::getQuantity).sum();
            itemCounts.put(order.getOrderId(), totalItems);
        }
        
        model.addAttribute("customerNames", customerNames);
        model.addAttribute("itemCounts", itemCounts);
        
        return "adminOrders";
    }
    
    // Admin: View order details
    @GetMapping("/admin/order/details")
    public String adminOrderDetails(@RequestParam Integer orderId,
                                    HttpSession session,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order not found!");
            return "redirect:/admin/orders";
        }
        
        OrderEntity order = orderOpt.get();
        Optional<AddressEntity> addressOpt = addressRepository.findById(order.getAddressId());
        Optional<UserEntity> customerOpt = userRepository.findById(order.getCustomerId());
        Optional<PaymentEntity> paymentOpt = paymentRepository.findByOrderId(orderId);
        
        // Get order details with product info
        List<Object[]> orderDetails = orderDetailRepository.findOrderDetailsWithProductInfo(orderId);
        
        // Calculate total items
        int totalItems = 0;
        for (Object[] item : orderDetails) {
            OrderDetailEntity detail = (OrderDetailEntity) item[0];
            totalItems += detail.getQuantity();
        }
        
        model.addAttribute("order", order);
        model.addAttribute("address", addressOpt.orElse(null));
        
        if (customerOpt.isPresent()) {
            UserEntity customer = customerOpt.get();
            String customerName = customer.getName() != null ? customer.getName() : 
                                 (customer.getName() + " " + customer.getName());
            model.addAttribute("customerName", customerName);
            model.addAttribute("customer", customer);
        }
        
        model.addAttribute("payment", paymentOpt.orElse(null));
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("totalItems", totalItems);
        
        return "adminOrderDetails";
    }
    
    // Admin: Update order status
    @PostMapping("/admin/order/update-status")
    @Transactional
    public String updateOrderStatus(@RequestParam Integer orderId,
                                    @RequestParam String orderStatus,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order not found!");
            return "redirect:/admin/orders";
        }
        
        OrderEntity order = orderOpt.get();
        OrderStatus oldStatus = order.getOrderStatus();
        OrderStatus newStatus = OrderStatus.valueOf(orderStatus);
        
        // If cancelling, restore stock
        if (newStatus == OrderStatus.CANCELLED && oldStatus != OrderStatus.CANCELLED) {
            List<OrderDetailEntity> orderDetails = orderDetailRepository.findByOrderId(orderId);
            for (OrderDetailEntity detail : orderDetails) {
                stockService.restoreStock(detail.getProductId(), detail.getQuantity());
            }
        }
        
        // Handle payment status update if order is delivered
        if (newStatus == OrderStatus.DELIVERED) {
            order.updatePaymentStatus(PaymentStatus.PAID);
        }
        
        order.setOrderStatus(newStatus);
        orderRepository.save(order);
        
        // Send email notification to customer
        try {
            Optional<UserEntity> customerOpt = userRepository.findById(order.getCustomerId());
            if (customerOpt.isPresent()) {
                mailerService.sendOrderStatusUpdateEmail(customerOpt.get(), order, oldStatus.toString(), newStatus.toString());
            }
        } catch (Exception e) {
            log.error("Failed to send status update email for order {}: {}", orderId, e.getMessage());
        }
        
        redirectAttributes.addFlashAttribute("success", "Order status updated successfully!");
        return "redirect:/admin/order/details?orderId=" + orderId;
    }
    
    // Admin: Dashboard stats
    @GetMapping("/admin/order-stats")
    @ResponseBody
    public Map<String, Object> getOrderStats(HttpSession session) {
        
        Map<String, Object> stats = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return stats;
        }
        
        stats.put("totalOrders", orderRepository.count());
        stats.put("placedOrders", orderRepository.countByOrderStatus(OrderStatus.PLACED));
        stats.put("confirmedOrders", orderRepository.countByOrderStatus(OrderStatus.CONFIRMED));
        stats.put("shippedOrders", orderRepository.countByOrderStatus(OrderStatus.SHIPPED));
        stats.put("deliveredOrders", orderRepository.countByOrderStatus(OrderStatus.DELIVERED));
        stats.put("cancelledOrders", orderRepository.countByOrderStatus(OrderStatus.CANCELLED));
        stats.put("returnedOrders", orderRepository.countByOrderStatus(OrderStatus.RETURNED));
        
        Double totalRevenue = orderRepository.getTotalRevenue();
        stats.put("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
        
        return stats;
    }
    
    // Admin: Get orders by status for AJAX tabs
    @GetMapping("/api/admin/orders")
    @ResponseBody
    public List<Map<String, Object>> getOrdersByStatus(@RequestParam(required = false) String status, HttpSession session) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return java.util.Collections.emptyList();
        }
        
        List<OrderEntity> orders;
        if (status == null || status.isEmpty() || "ALL".equals(status)) {
            orders = orderRepository.findAll();
        } else {
            try {
                OrderStatus orderStatus = OrderStatus.valueOf(status);
                orders = orderRepository.findByOrderStatus(orderStatus);
            } catch (IllegalArgumentException e) {
                orders = orderRepository.findAll();
            }
        }
        
        // Transform orders to include customer names and item counts
        return orders.stream().map(order -> {
            Map<String, Object> map = new HashMap<>();
            map.put("orderId", order.getOrderId());
            map.put("customerId", order.getCustomerId());
            
            // Get customer name
            Optional<UserEntity> customerOpt = userRepository.findById(order.getCustomerId());
            if (customerOpt.isPresent()) {
                UserEntity customer = customerOpt.get();
                String customerName = customer.getName() != null ? customer.getName() : 
                                     (customer.getName() + " " + customer.getName());
                map.put("customerName", customerName);
            } else {
                map.put("customerName", "Customer #" + order.getCustomerId());
            }
            
            map.put("orderDate", order.getOrderDateAsDate());
            map.put("totalAmount", order.getTotalAmount());
            map.put("orderStatus", order.getOrderStatus());
            map.put("paymentStatus", order.getPaymentStatus());
            
            // Get item count
            List<OrderDetailEntity> details = orderDetailRepository.findByOrderId(order.getOrderId());
            int totalItems = details.stream().mapToInt(OrderDetailEntity::getQuantity).sum();
            map.put("itemCount", totalItems);
            
            return map;
        }).collect(Collectors.toList());
    }
}