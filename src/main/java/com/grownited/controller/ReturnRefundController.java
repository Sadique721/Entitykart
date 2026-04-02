package com.grownited.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.ReturnRefundEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.ReturnRefundRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReturnRefundController {

    @Autowired
    private ReturnRefundRepository returnRefundRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    // ==================== CUSTOMER SIDE ====================
    
    // Show return request form
    @GetMapping("/return/request/{orderItemId}")
    public String showReturnForm(@PathVariable Integer orderItemId,
                                  HttpSession session,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(orderItemId);
        if (detailOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order item not found!");
            return "redirect:/orders";
        }
        
        OrderDetailEntity detail = detailOpt.get();
        
        // Verify ownership
        Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized access!");
            return "redirect:/orders";
        }
        
        OrderEntity order = orderOpt.get();
        
        // Check if order can be returned
        if (!order.canBeReturned()) {
            redirectAttributes.addFlashAttribute("error", 
                "Item cannot be returned. Order is in " + order.getOrderStatus() + " status!");
            return "redirect:/order/details?orderId=" + order.getOrderId();
        }
        
        // Check if return already requested
        if (returnRefundRepository.existsByOrderItemId(orderItemId)) {
            redirectAttributes.addFlashAttribute("error", "Return already requested for this item!");
            return "redirect:/order/details?orderId=" + order.getOrderId();
        }
        
        // Get product details
        Optional<ProductEntity> productOpt = productRepository.findById(detail.getProductId());
        
        model.addAttribute("orderItem", detail);
        model.addAttribute("order", order);
        model.addAttribute("product", productOpt.orElse(null));
        
        return "returnForm";
    }
    
    // Submit return request
    @PostMapping("/return/submit")
    public String submitReturn(@RequestParam Integer orderItemId,
                               @RequestParam String reason,
                               @RequestParam(required = false) String comments,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(orderItemId);
        if (detailOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order item not found!");
            return "redirect:/orders";
        }
        
        OrderDetailEntity detail = detailOpt.get();
        
        // Verify ownership
        Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized access!");
            return "redirect:/orders";
        }
        
        OrderEntity order = orderOpt.get();
        
        // Check if order can be returned
        if (!order.canBeReturned()) {
            redirectAttributes.addFlashAttribute("error", 
                "Item cannot be returned. Order is in " + order.getOrderStatus() + " status!");
            return "redirect:/order/details?orderId=" + order.getOrderId();
        }
        
        // Check if return already requested
        if (returnRefundRepository.existsByOrderItemId(orderItemId)) {
            redirectAttributes.addFlashAttribute("error", "Return already requested for this item!");
            return "redirect:/order/details?orderId=" + order.getOrderId();
        }
        
        // Create return request
        ReturnRefundEntity returnRequest = new ReturnRefundEntity();
        returnRequest.setOrderItemId(orderItemId);
        returnRequest.setReason(reason + (comments != null ? " - " + comments : ""));
        returnRequest.setReturnStatus(ReturnRefundEntity.ReturnStatus.REQUESTED);
        returnRefundRepository.save(returnRequest);
        
        redirectAttributes.addFlashAttribute("success", "Return request submitted successfully! We will process it within 2-3 business days.");
        
        return "redirect:/order/details?orderId=" + order.getOrderId();
    }
    
    // View my return requests
    @GetMapping("/my-returns")
    public String myReturns(HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        List<ReturnRefundEntity> returns = returnRefundRepository.findByCustomerId(currentUser.getUserId());
        
        // Enrich with order and product details
        List<Map<String, Object>> returnList = new ArrayList<>();
        for (ReturnRefundEntity returnReq : returns) {
            Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(returnReq.getOrderItemId());
            if (detailOpt.isPresent()) {
                OrderDetailEntity detail = detailOpt.get();
                Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
                Optional<ProductEntity> productOpt = productRepository.findById(detail.getProductId());
                
                Map<String, Object> map = new HashMap<>();
                map.put("returnReq", returnReq);
                map.put("orderItem", detail);
                map.put("order", orderOpt.orElse(null));
                map.put("product", productOpt.orElse(null));
                returnList.add(map);
            }
        }
        
        model.addAttribute("returns", returnList);
        
        return "myReturns";
    }
    
    // Cancel return request
    @GetMapping("/return/cancel/{returnId}")
    public String cancelReturn(@PathVariable Integer returnId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ReturnRefundEntity> returnOpt = returnRefundRepository.findById(returnId);
        if (returnOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Return request not found!");
            return "redirect:/my-returns";
        }
        
        ReturnRefundEntity returnReq = returnOpt.get();
        
        // Verify ownership through order item
        Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(returnReq.getOrderItemId());
        if (detailOpt.isPresent()) {
            Optional<OrderEntity> orderOpt = orderRepository.findById(detailOpt.get().getOrderId());
            if (orderOpt.isPresent() && !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access!");
                return "redirect:/my-returns";
            }
        }
        
        // Only allow cancellation if still requested
        if (returnReq.isPending()) {
            returnRefundRepository.delete(returnReq);
            redirectAttributes.addFlashAttribute("success", "Return request cancelled successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cannot cancel return request that is already " + returnReq.getReturnStatus());
        }
        
        return "redirect:/my-returns";
    }
    
    // ==================== ADMIN SIDE ====================
    
    // Admin: View all return requests
    @GetMapping("/admin/returns")
    public String adminReturns(@RequestParam(required = false, defaultValue = "ALL") String status,
                               @RequestParam(required = false, defaultValue = "0") int page,
                               HttpSession session,
                               Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Pageable pageable = PageRequest.of(page, 10, Sort.by("requestedAt").descending());
        Page<ReturnRefundEntity> returnsPage;
        
        if (!"ALL".equals(status)) {
            ReturnRefundEntity.ReturnStatus returnStatus = ReturnRefundEntity.ReturnStatus.valueOf(status);
            returnsPage = returnRefundRepository.findByReturnStatusOrderByRequestedAtAsc(returnStatus, pageable);
        } else {
            returnsPage = returnRefundRepository.findAll(pageable);
        }
        
        // Enrich with details
        List<Map<String, Object>> returnList = new ArrayList<>();
        for (ReturnRefundEntity returnReq : returnsPage.getContent()) {
            Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(returnReq.getOrderItemId());
            if (detailOpt.isPresent()) {
                OrderDetailEntity detail = detailOpt.get();
                Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
                Optional<ProductEntity> productOpt = productRepository.findById(detail.getProductId());
                
                Map<String, Object> map = new HashMap<>();
                map.put("returnReq", returnReq);
                map.put("orderItem", detail);
                map.put("order", orderOpt.orElse(null));
                map.put("product", productOpt.orElse(null));
                returnList.add(map);
            }
        }
        
        // Get statistics
        List<Object[]> stats = returnRefundRepository.getReturnStatistics();
        Map<String, Long> statistics = new HashMap<>();
        for (Object[] stat : stats) {
            statistics.put(stat[0].toString(), (Long) stat[1]);
        }
        
        model.addAttribute("returns", returnList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", returnsPage.getTotalPages());
        model.addAttribute("totalElements", returnsPage.getTotalElements());
        model.addAttribute("currentStatus", status);
        model.addAttribute("statistics", statistics);
        
        return "adminReturns";
    }
    
    // Admin: View return details
    @GetMapping("/admin/return/details")
    public String adminReturnDetails(@RequestParam Integer returnId,
                                     HttpSession session,
                                     Model model,
                                     RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Optional<ReturnRefundEntity> returnOpt = returnRefundRepository.findById(returnId);
        if (returnOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Return request not found!");
            return "redirect:/admin/returns";
        }
        
        ReturnRefundEntity returnReq = returnOpt.get();
        
        Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(returnReq.getOrderItemId());
        if (detailOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order item not found!");
            return "redirect:/admin/returns";
        }
        
        OrderDetailEntity detail = detailOpt.get();
        Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
        Optional<ProductEntity> productOpt = productRepository.findById(detail.getProductId());
        
        model.addAttribute("return", returnReq);
        model.addAttribute("orderItem", detail);
        model.addAttribute("order", orderOpt.orElse(null));
        model.addAttribute("product", productOpt.orElse(null));
        
        return "adminReturnDetails";
    }
    
    // Admin: Process return request
    @PostMapping("/admin/return/process")
    public String processReturn(@RequestParam Integer returnId,
                                @RequestParam String action,
                                @RequestParam(required = false) String adminComments,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Optional<ReturnRefundEntity> returnOpt = returnRefundRepository.findById(returnId);
        if (returnOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Return request not found!");
            return "redirect:/admin/returns";
        }
        
        ReturnRefundEntity returnReq = returnOpt.get();
        
        if ("APPROVE".equals(action)) {
            returnReq.setReturnStatus(ReturnRefundEntity.ReturnStatus.APPROVED);
            
            // Get order detail and restore stock
            Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(returnReq.getOrderItemId());
            if (detailOpt.isPresent()) {
                OrderDetailEntity detail = detailOpt.get();
                Optional<ProductEntity> productOpt = productRepository.findById(detail.getProductId());
                if (productOpt.isPresent()) {
                    ProductEntity product = productOpt.get();
                    product.setStockQuantity(product.getStockQuantity() + detail.getQuantity());
                    productRepository.save(product);
                }
                
                // Update order status if all items are returned
                Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
                if (orderOpt.isPresent()) {
                    OrderEntity order = orderOpt.get();
                    // Check if all items in order are returned
                    List<OrderDetailEntity> orderDetails = orderDetailRepository.findByOrderId(order.getOrderId());
                    boolean allReturned = true;
                    for (OrderDetailEntity od : orderDetails) {
                        if (!returnRefundRepository.existsByOrderItemId(od.getOrderItemId()) ||
                            returnRefundRepository.findByOrderItemId(od.getOrderItemId()).get().getReturnStatus() != ReturnRefundEntity.ReturnStatus.APPROVED) {
                            allReturned = false;
                            break;
                        }
                    }
                    if (allReturned) {
                        order.setOrderStatus(OrderEntity.OrderStatus.RETURNED);
                        orderRepository.save(order);
                    }
                }
            }
            redirectAttributes.addFlashAttribute("success", "Return request approved successfully!");
            
        } else if ("REJECT".equals(action)) {
            returnReq.setReturnStatus(ReturnRefundEntity.ReturnStatus.REJECTED);
            redirectAttributes.addFlashAttribute("success", "Return request rejected!");
            
        } else if ("REFUND".equals(action)) {
            returnReq.setReturnStatus(ReturnRefundEntity.ReturnStatus.REFUNDED);
            redirectAttributes.addFlashAttribute("success", "Refund processed successfully!");
        }
        
        returnReq.setProcessedAt(LocalDateTime.now());
        returnRefundRepository.save(returnReq);
        
        return "redirect:/admin/return/details?returnId=" + returnId;
    }
    
    // Admin: Bulk process returns (FIXED - Added null check and required=false)
    @PostMapping("/admin/return/bulk-process")
    public String bulkProcessReturns(@RequestParam(required = false) List<Integer> returnIds,
                                     @RequestParam String action,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        // Check if no IDs selected
        if (returnIds == null || returnIds.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select at least one return request to process.");
            return "redirect:/admin/returns";
        }
        
        int successCount = 0;
        for (Integer returnId : returnIds) {
            Optional<ReturnRefundEntity> returnOpt = returnRefundRepository.findById(returnId);
            if (returnOpt.isPresent()) {
                ReturnRefundEntity returnReq = returnOpt.get();
                
                if ("APPROVE".equals(action) && returnReq.isPending()) {
                    returnReq.setReturnStatus(ReturnRefundEntity.ReturnStatus.APPROVED);
                    returnReq.setProcessedAt(LocalDateTime.now());
                    returnRefundRepository.save(returnReq);
                    successCount++;
                } else if ("REJECT".equals(action) && returnReq.isPending()) {
                    returnReq.setReturnStatus(ReturnRefundEntity.ReturnStatus.REJECTED);
                    returnReq.setProcessedAt(LocalDateTime.now());
                    returnRefundRepository.save(returnReq);
                    successCount++;
                }
            }
        }
        
        redirectAttributes.addFlashAttribute("success", successCount + " return requests processed successfully!");
        
        return "redirect:/admin/returns";
    }
    
    // ==================== AJAX ENDPOINTS ====================
    
    // Get return status (AJAX)
    @GetMapping("/api/return/status/{orderItemId}")
    @ResponseBody
    public Map<String, Object> getReturnStatus(@PathVariable Integer orderItemId,
                                               HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Not authenticated");
            return response;
        }
        
        Optional<ReturnRefundEntity> returnOpt = returnRefundRepository.findByOrderItemId(orderItemId);
        if (returnOpt.isPresent()) {
            ReturnRefundEntity returnReq = returnOpt.get();
            response.put("success", true);
            response.put("returnId", returnReq.getReturnId());
            response.put("status", returnReq.getReturnStatus());
            response.put("reason", returnReq.getReason());
            response.put("requestedAt", returnReq.getRequestedAt().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            response.put("processedAt", returnReq.getProcessedAt() != null ? 
                returnReq.getProcessedAt().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : null);
        } else {
            response.put("success", false);
            response.put("message", "No return request found");
        }
        
        return response;
    }
    
    // Get return statistics (AJAX)
    @GetMapping("/api/admin/return-stats")
    @ResponseBody
    public Map<String, Object> getReturnStatistics(HttpSession session) {
        
        Map<String, Object> stats = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return stats;
        }
        
        List<Object[]> statistics = returnRefundRepository.getReturnStatistics();
        for (Object[] stat : statistics) {
            stats.put(stat[0].toString().toLowerCase() + "Count", stat[1]);
        }
        
        stats.put("totalReturns", returnRefundRepository.count());
        stats.put("pendingReturns", returnRefundRepository.countByReturnStatus(ReturnRefundEntity.ReturnStatus.REQUESTED));
        
        return stats;
    }
    
    // Check if return eligible (AJAX)
    @GetMapping("/api/return/check-eligibility/{orderItemId}")
    @ResponseBody
    public Map<String, Object> checkReturnEligibility(@PathVariable Integer orderItemId,
                                                      HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("eligible", false);
            response.put("message", "Please login to check eligibility");
            return response;
        }
        
        Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(orderItemId);
        if (detailOpt.isEmpty()) {
            response.put("eligible", false);
            response.put("message", "Order item not found");
            return response;
        }
        
        OrderDetailEntity detail = detailOpt.get();
        
        // Verify ownership
        Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            response.put("eligible", false);
            response.put("message", "Unauthorized access");
            return response;
        }
        
        OrderEntity order = orderOpt.get();
        
        // Check eligibility
        if (!order.canBeReturned()) {
            response.put("eligible", false);
            response.put("message", "Item cannot be returned. Order is in " + order.getOrderStatus() + " status");
        } else if (returnRefundRepository.existsByOrderItemId(orderItemId)) {
            response.put("eligible", false);
            response.put("message", "Return already requested for this item");
        } else {
            response.put("eligible", true);
            response.put("message", "Item is eligible for return");
            response.put("orderDate", order.getOrderDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy")));
            response.put("daysSinceDelivery", 
                java.time.Duration.between(order.getOrderDate(), LocalDateTime.now()).toDays());
        }
        
        return response;
    }
}