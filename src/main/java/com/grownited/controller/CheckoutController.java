package com.grownited.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.AddressEntity;
import com.grownited.entity.CartEntity;
import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.PaymentEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;
import com.grownited.repository.CartRepository;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.PaymentRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailerService;
import com.grownited.service.PaymentService;
import com.grownited.service.StockService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CheckoutController {

    @Autowired
    private CartRepository cartRepository;
    
    @Autowired
    private AddressRepository addressRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private PaymentService paymentService;
    
    @Autowired
    private StockService stockService;
    
    @Autowired
    private MailerService mailerService;

    @Autowired
    private UserRepository userRepository;
    
    private static final Logger log = LoggerFactory.getLogger(CheckoutController.class);
    
    // ==================== CHECKOUT PAGE ====================
    
    @GetMapping("/checkout")
    public String checkoutPage(@RequestParam(required = false) Integer productId,
                               @RequestParam(required = false, defaultValue = "1") Integer quantity,
                               HttpSession session, 
                               Model model,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        List<AddressEntity> addresses = addressRepository.findByUserId(currentUser.getUserId());
        if (addresses.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please add a delivery address before checkout!");
            return "redirect:/address";
        }
        
        Double subtotal = 0.0;
        Integer itemCount = 0;
        
        if (productId != null) {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/listProduct";
            }
            
            ProductEntity product = productOpt.get();
            if (product.getStockQuantity() < quantity) {
                redirectAttributes.addFlashAttribute("error", 
                    "Insufficient stock! Available: " + product.getStockQuantity());
                return "redirect:/viewProduct?productId=" + productId;
            }
            
            subtotal = product.getPrice().doubleValue() * quantity;
            itemCount = 1;
            
            model.addAttribute("directBuy", true);
            model.addAttribute("productId", productId);
            model.addAttribute("quantity", quantity);
            model.addAttribute("product", product);
        } else {
            List<CartEntity> cartItems = cartRepository.findByCustomerId(currentUser.getUserId());
            if (cartItems.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Your cart is empty!");
                return "redirect:/cart";
            }
            
            for (CartEntity item : cartItems) {
                Optional<ProductEntity> productOpt = productRepository.findById(item.getProductId());
                if (productOpt.isEmpty() || productOpt.get().getStockQuantity() < item.getQuantity()) {
                    redirectAttributes.addFlashAttribute("error", 
                        "Some items in your cart are out of stock. Please review your cart.");
                    return "redirect:/cart";
                }
                subtotal += item.getPrice() * item.getQuantity();
            }
            itemCount = cartItems.size();
            model.addAttribute("cartItems", cartItems);
        }
        
        Double shipping = 40.0;
        Double tax = subtotal * 0.18;
        Double total = subtotal + shipping + tax;
        
        model.addAttribute("addresses", addresses);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shipping", shipping);
        model.addAttribute("tax", tax);
        model.addAttribute("total", total);
        model.addAttribute("itemCount", itemCount);
        
        return "checkout";
    }
    
    // ==================== PLACE ORDER ====================
    
    @PostMapping("/order/place")
    @Transactional
    public String placeOrder(@RequestParam Integer addressId,
                             @RequestParam String paymentMode,
                             @RequestParam(required = false) Integer productId,
                             @RequestParam(required = false, defaultValue = "1") Integer quantity,
                             @RequestParam(required = false) String cardNumber,
                             @RequestParam(required = false) String cardHolderName,
                             @RequestParam(required = false) String expiryMonth,
                             @RequestParam(required = false) String expiryYear,
                             @RequestParam(required = false) String cvv,
                             @RequestParam(required = false) String upiId,
                             @RequestParam(required = false) String bankName,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Validate address
        Optional<AddressEntity> addressOpt = addressRepository.findById(addressId);
        if (addressOpt.isEmpty() || !addressOpt.get().getUserId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Invalid shipping address!");
            return "redirect:/checkout";
        }

        // ===== 1. Prepare order items (but do not deduct stock yet) =====
        List<CartEntity> cartItems = null;
        ProductEntity directProduct = null;
        int directQuantity = 0;
        
        if (productId != null) {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/listProduct";
            }
            directProduct = productOpt.get();
            directQuantity = quantity;
            if (directProduct.getStockQuantity() < directQuantity) {
                redirectAttributes.addFlashAttribute("error", 
                    "Insufficient stock for " + directProduct.getProductName() + "! Available: " + directProduct.getStockQuantity());
                return "redirect:/viewProduct?productId=" + productId;
            }
        } else {
            cartItems = cartRepository.findByCustomerId(currentUser.getUserId());
            if (cartItems.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Your cart is empty!");
                return "redirect:/cart";
            }
            for (CartEntity item : cartItems) {
                Optional<ProductEntity> prodOpt = productRepository.findById(item.getProductId());
                if (prodOpt.isEmpty() || prodOpt.get().getStockQuantity() < item.getQuantity()) {
                    redirectAttributes.addFlashAttribute("error", 
                        "Some items in your cart are out of stock. Please review your cart.");
                    return "redirect:/cart";
                }
            }
        }

        // ===== 2. Calculate total amount =====
        Double subtotal = 0.0;
        if (directProduct != null) {
            subtotal = directProduct.getPrice().doubleValue() * directQuantity;
        } else {
            for (CartEntity item : cartItems) {
                subtotal += item.getPrice() * item.getQuantity();
            }
        }
        Double totalAmount = subtotal + 40.0 + (subtotal * 0.18);

        // ===== 3. Create order with status PENDING_PAYMENT =====
        OrderEntity order = new OrderEntity();
        order.setCustomerId(currentUser.getUserId());
        order.setAddressId(addressId);
        order.setTotalAmount(totalAmount);
        order.setOrderStatus(OrderEntity.OrderStatus.PENDING_PAYMENT);
        order.setPaymentStatus(OrderEntity.PaymentStatus.UNPAID);
        orderRepository.save(order);

        // ===== 4. Create order details =====
        if (directProduct != null) {
            createOrderDetail(order.getOrderId(), directProduct.getProductId(), directQuantity, directProduct.getPrice().doubleValue());
        } else {
            for (CartEntity item : cartItems) {
                createOrderDetail(order.getOrderId(), item.getProductId(), item.getQuantity(), item.getPrice());
            }
        }

        // ===== 5. Process payment =====
        boolean paymentSuccess = false;
        PaymentEntity payment = null;

        if ("CARD".equals(paymentMode)) {
            Map<String, String> cardDetails = new HashMap<>();
            cardDetails.put("cardNumber", cardNumber);
            cardDetails.put("cardHolderName", cardHolderName);
            cardDetails.put("expiryMonth", expiryMonth);
            cardDetails.put("expiryYear", expiryYear);
            cardDetails.put("cvv", cvv);
            cardDetails.put("email", currentUser.getEmail());

            try {
                payment = paymentService.processPayment(order.getOrderId(), totalAmount, cardDetails);
                paymentSuccess = payment.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS;
            } catch (Exception e) {
                paymentSuccess = false;
                log.error("Payment processing error: {}", e.getMessage());
            }
        } else {
            paymentSuccess = simulatePaymentProcessing(paymentMode);
            payment = new PaymentEntity();
            payment.setOrderId(order.getOrderId());
            payment.setAmount(totalAmount);
            try {
                payment.setPaymentMode(PaymentEntity.PaymentMode.valueOf(paymentMode));
            } catch (IllegalArgumentException e) {
                payment.setPaymentMode(PaymentEntity.PaymentMode.COD);
            }
            payment.setTransactionRef("TXN" + System.currentTimeMillis());
            payment.setPaymentStatus(paymentSuccess ? PaymentEntity.PaymentGatewayStatus.SUCCESS : PaymentEntity.PaymentGatewayStatus.FAILED);
            if (paymentSuccess) {
                payment.setPaymentDate(LocalDateTime.now());
            }
            paymentRepository.save(payment);
        }

        // ===== 6. If payment successful, complete order =====
        if (paymentSuccess) {
            // Deduct stock
            if (directProduct != null) {
                stockService.deductStock(directProduct.getProductId(), directQuantity);
            } else {
                for (CartEntity item : cartItems) {
                    stockService.deductStock(item.getProductId(), item.getQuantity());
                }
            }
            
            // Update order
            order.setOrderStatus(OrderEntity.OrderStatus.PLACED);
            order.setPaymentStatus(OrderEntity.PaymentStatus.PAID);
            orderRepository.save(order);
            
            // Clear cart
            if (cartItems != null) {
                cartRepository.deleteByCustomerId(currentUser.getUserId());
            }
            
            // ========== SEND ORDER CONFIRMATION EMAIL (ENHANCED) ==========
            try {
                UserEntity customer = userRepository.findById(currentUser.getUserId()).orElse(null);
                if (customer != null) {
                    List<OrderDetailEntity> orderDetails = orderDetailRepository.findByOrderId(order.getOrderId());
                    
                    Map<Integer, String> productNames = new HashMap<>();
                    for (OrderDetailEntity detail : orderDetails) {
                        productRepository.findById(detail.getProductId())
                            .ifPresent(product -> productNames.put(detail.getProductId(), product.getProductName()));
                    }
                    
                    AddressEntity address = addressRepository.findById(addressId).orElse(null);
                    PaymentEntity paymentEntity = paymentRepository.findByOrderId(order.getOrderId()).orElse(null);
                    
                    mailerService.sendOrderConfirmationEmail(customer, order, orderDetails, productNames, address, paymentEntity);
                    
                    log.info("Order confirmation email sent successfully for order #{}", order.getOrderId());
                }
            } catch (Exception e) {
                log.error("Failed to send order confirmation email for order #{}: {}", order.getOrderId(), e.getMessage());
            }
            // ==============================================================
            
            redirectAttributes.addFlashAttribute("success", "Order placed successfully! Order ID: #" + order.getOrderId());
            return "redirect:/order/confirmation?orderId=" + order.getOrderId();
        } else {
            // Payment failed – cancel the order
            order.setOrderStatus(OrderEntity.OrderStatus.CANCELLED);
            orderRepository.save(order);
            redirectAttributes.addFlashAttribute("error", "Payment failed! Please try again.");
            return "redirect:/checkout";
        }
    }
    
    // ==================== HELPER METHODS ====================
    
    private void createOrderDetail(Integer orderId, Integer productId, Integer quantity, Double price) {
        OrderDetailEntity detail = new OrderDetailEntity();
        detail.setOrderId(orderId);
        detail.setProductId(productId);
        detail.setQuantity(quantity);
        detail.setPrice(price);
        orderDetailRepository.save(detail);
    }
    
    private boolean simulatePaymentProcessing(String paymentMode) {
        // 95% success rate for simulation
        return Math.random() < 0.95;
    }
    
    // ==================== CART COUNT AJAX ====================
    
    @GetMapping("/cart/count")
    @ResponseBody
    public Map<String, Object> getCartCount(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser != null) {
            Long count = cartRepository.countByCustomerId(currentUser.getUserId());
            response.put("count", count);
        } else {
            response.put("count", 0);
        }
        return response;
    }
}