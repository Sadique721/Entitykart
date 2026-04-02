package com.grownited.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.AddressEntity;
import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.PaymentEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;
import com.grownited.repository.CartRepository;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.PaymentRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.service.MailerService;
import com.grownited.service.PaymentService;
import com.grownited.service.StockService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    private static final Logger log = LoggerFactory.getLogger(PaymentController.class);

    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartRepository cartRepository;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private StockService stockService;
    @Autowired
    private MailerService mailerService;
    @Autowired
    private AddressRepository addressRepository;

    // ==================== CUSTOMER PAYMENT FLOW ====================

    @GetMapping("/payment/{orderId}")
    public String paymentPage(@PathVariable Integer orderId,
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

        // If payment already exists, show details
        Optional<PaymentEntity> existingPayment = paymentRepository.findByOrderId(orderId);
        if (existingPayment.isPresent()) {
            model.addAttribute("payment", existingPayment.get());
            return "paymentDetails";
        }

        // For Razorpay, we pass the key and order details
        model.addAttribute("order", order);
        model.addAttribute("razorpayKey", "rzp_test_SWzPlR2zPWv4CR"); // replace with your key
        return "razorpayPayment";
    }

    @PostMapping("/payment/process")
    public String processPayment(@RequestParam Integer orderId,
                                 @RequestParam String paymentMode,
                                 @RequestParam(required = false) String cardNumber,
                                 @RequestParam(required = false) String cardHolderName,
                                 @RequestParam(required = false) String expiryMonth,
                                 @RequestParam(required = false) String expiryYear,
                                 @RequestParam(required = false) String cvv,
                                 @RequestParam(required = false) String upiId,
                                 @RequestParam(required = false) String transactionRef,
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

        // For CARD payment, use actual gateway (Authorize.Net)
        if ("CARD".equals(paymentMode)) {
            if (!validateCardDetails(cardNumber, expiryMonth, expiryYear, cvv)) {
                redirectAttributes.addFlashAttribute("error", "Invalid card details!");
                return "redirect:/payment/" + orderId;
            }

            Map<String, String> cardDetails = new HashMap<>();
            cardDetails.put("cardNumber", cardNumber);
            cardDetails.put("cardHolderName", cardHolderName);
            cardDetails.put("expiryMonth", expiryMonth);
            cardDetails.put("expiryYear", expiryYear);
            cardDetails.put("cvv", cvv);
            cardDetails.put("email", currentUser.getEmail());

            try {
                PaymentEntity payment = paymentService.processPayment(orderId, order.getTotalAmount(), cardDetails);
                if (payment.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS) {
                    order.setPaymentStatus(OrderEntity.PaymentStatus.PAID);
                    orderRepository.save(order);
                    redirectAttributes.addFlashAttribute("success", "Payment successful!");
                } else {
                    redirectAttributes.addFlashAttribute("error",
                            "Payment failed: " + payment.getGatewayResponseText());
                }
            } catch (Exception e) {
                log.error("Payment processing error: ", e);
                redirectAttributes.addFlashAttribute("error", "Payment processing error: " + e.getMessage());
            }
            return "redirect:/payment/status/" + orderId;
        }

        // For other modes (COD, UPI, etc.) – simulation
        if ("UPI".equals(paymentMode) && !validateUpiId(upiId)) {
            redirectAttributes.addFlashAttribute("error", "Invalid UPI ID!");
            return "redirect:/payment/" + orderId;
        }

        // Simulate payment using the service
        PaymentEntity payment = paymentService.simulatePayment(orderId, order.getTotalAmount(), paymentMode);
        if (payment.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS) {
            order.setPaymentStatus(OrderEntity.PaymentStatus.PAID);
            orderRepository.save(order);
            redirectAttributes.addFlashAttribute("success", "Payment completed successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Payment failed! Please try again.");
        }
        return "redirect:/payment/status/" + orderId;
    }

    @GetMapping("/payment/status/{orderId}")
    public String paymentStatus(@PathVariable Integer orderId,
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

        Optional<PaymentEntity> paymentOpt = paymentRepository.findByOrderId(orderId);
        if (paymentOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Payment not found!");
            return "redirect:/orders";
        }

        model.addAttribute("order", orderOpt.get());
        model.addAttribute("payment", paymentOpt.get());
        return "paymentStatus";
    }

    @GetMapping("/payment/retry/{orderId}")
    public String retryPayment(@PathVariable Integer orderId,
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

        // Delete any previous failed payment record so a new one can be created
        Optional<PaymentEntity> existingPayment = paymentRepository.findByOrderId(orderId);
        if (existingPayment.isPresent() &&
                existingPayment.get().getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.FAILED) {
            paymentRepository.delete(existingPayment.get());
        }

        return "redirect:/payment/" + orderId;
    }

    // ==================== RAZORPAY ENDPOINTS ====================

    @PostMapping("/razorpay/create-order")
    @ResponseBody
    public String createRazorpayOrder(@RequestParam Integer orderId,
                                      HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "{\"error\":\"Please login\"}";
        }
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            return "{\"error\":\"Order not found\"}";
        }
        OrderEntity order = orderOpt.get();
        if (order.getOrderStatus() != OrderEntity.OrderStatus.PENDING_PAYMENT) {
            return "{\"error\":\"Invalid order state\"}";
        }
        JSONObject razorpayOrder = paymentService.createRazorpayOrder(orderId, order.getTotalAmount());
        return razorpayOrder.toString();
    }

    @PostMapping("/razorpay/success")
    @Transactional
    @ResponseBody
    public Map<String, Object> razorpaySuccess(@RequestParam Integer orderId,
                                               @RequestParam String razorpay_payment_id,
                                               @RequestParam String razorpay_order_id,
                                               @RequestParam String razorpay_signature,
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Please login");
            return response;
        }

        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty() || !orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            response.put("success", false);
            response.put("message", "Order not found");
            return response;
        }

        OrderEntity order = orderOpt.get();

        // 1. Verify signature
        boolean verified = paymentService.verifyRazorpaySignature(razorpay_order_id, razorpay_payment_id, razorpay_signature);
        if (!verified) {
            response.put("success", false);
            response.put("message", "Payment verification failed");
            return response;
        }

        // 2. Save payment record
        Double amount = order.getTotalAmount();
        PaymentEntity payment = paymentService.saveRazorpayPayment(orderId, razorpay_payment_id,
                razorpay_order_id, razorpay_signature, amount);

        // 3. Update order status & deduct stock
        order.setOrderStatus(OrderEntity.OrderStatus.PLACED);
        order.setPaymentStatus(OrderEntity.PaymentStatus.PAID);
        orderRepository.save(order);

        // 4. Deduct stock
        List<OrderDetailEntity> orderDetails = orderDetailRepository.findByOrderId(orderId);
        for (OrderDetailEntity detail : orderDetails) {
            stockService.deductStock(detail.getProductId(), detail.getQuantity());
        }

        // 5. Clear cart
        cartRepository.deleteByCustomerId(currentUser.getUserId());

        // 6. Build product names map for email
        Map<Integer, String> productNames = new HashMap<>();
        for (OrderDetailEntity detail : orderDetails) {
            productRepository.findById(detail.getProductId())
                    .ifPresent(product -> productNames.put(detail.getProductId(), product.getProductName()));
        }

        // 7. Send order confirmation email
        try {
            mailerService.sendOrderConfirmationEmail(currentUser, order, orderDetails, productNames);
        } catch (Exception e) {
            log.error("Email failed: {}", e.getMessage());
        }

        response.put("success", true);
        response.put("orderId", orderId);
        return response;
    }

    // ==================== ADMIN PANEL ENDPOINTS ====================

    @GetMapping("/admin/payments")
    public String adminPayments(HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }

        List<PaymentEntity> payments = paymentRepository.findAll();
        List<OrderEntity> orders = orderRepository.findAll();

        long totalPayments = payments.size();
        long successCount = paymentRepository.findByPaymentStatus(PaymentEntity.PaymentGatewayStatus.SUCCESS).size();
        long failedCount = paymentRepository.findByPaymentStatus(PaymentEntity.PaymentGatewayStatus.FAILED).size();
        long pendingCount = paymentRepository.findByPaymentStatus(PaymentEntity.PaymentGatewayStatus.PENDING).size();

        Map<String, Double> revenueByMode = new HashMap<>();
        List<Object[]> revenueData = paymentRepository.getRevenueByPaymentMode();
        for (Object[] data : revenueData) {
            revenueByMode.put(data[0].toString(), (Double) data[1]);
        }

        Double totalRevenue = payments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                .mapToDouble(PaymentEntity::getAmount)
                .sum();

        double successRate = totalPayments > 0 ? (successCount * 100.0 / totalPayments) : 0;

        model.addAttribute("payments", payments);
        model.addAttribute("orders", orders);
        model.addAttribute("totalPayments", totalPayments);
        model.addAttribute("successCount", successCount);
        model.addAttribute("failedCount", failedCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("successRate", successRate);
        model.addAttribute("revenueByMode", revenueByMode);

        return "adminPayments";
    }

    @GetMapping("/admin/payment/details")
    public String adminPaymentDetails(@RequestParam Integer paymentId,
                                      HttpSession session,
                                      Model model,
                                      RedirectAttributes redirectAttributes) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }

        Optional<PaymentEntity> paymentOpt = paymentRepository.findById(paymentId);
        if (paymentOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Payment not found!");
            return "redirect:/admin/payments";
        }

        PaymentEntity payment = paymentOpt.get();
        Optional<OrderEntity> orderOpt = orderRepository.findById(payment.getOrderId());
        OrderEntity order = orderOpt.orElse(null);

        AddressEntity address = null;
        if (order != null && order.getAddressId() != null) {
            address = addressRepository.findById(order.getAddressId()).orElse(null);
        }

        model.addAttribute("payment", payment);
        model.addAttribute("order", order);
        model.addAttribute("address", address);   // <-- new attribute

        return "adminPaymentDetails";
    }
    
    @GetMapping("/admin/payment-summary")
    public String paymentSummary(HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }

        List<PaymentEntity> allPayments = paymentRepository.findAll();

        long totalPayments = allPayments.size();
        long successfulPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                .count();
        long failedPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.FAILED)
                .count();
        long pendingPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.PENDING)
                .count();

        Double totalRevenue = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                .mapToDouble(PaymentEntity::getAmount)
                .sum();

        double successRate = totalPayments > 0 ? (successfulPayments * 100.0 / totalPayments) : 0;

        Map<String, Double> revenueByMode = new HashMap<>();
        List<Object[]> revenueData = paymentRepository.getRevenueByPaymentMode();
        for (Object[] data : revenueData) {
            revenueByMode.put(data[0].toString(), (Double) data[1]);
        }

        model.addAttribute("totalPayments", totalPayments);
        model.addAttribute("successfulPayments", successfulPayments);
        model.addAttribute("failedPayments", failedPayments);
        model.addAttribute("pendingPayments", pendingPayments);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("successRate", successRate);
        model.addAttribute("revenueByMode", revenueByMode);

        return "paymentSummary";
    }

    // ==================== AJAX API ENDPOINTS ====================

    @GetMapping("/api/admin/payments")
    @ResponseBody
    public List<Map<String, Object>> getPaymentsByStatus(@RequestParam(required = false) String status,
                                                         HttpSession session) {
        List<Map<String, Object>> payments = new ArrayList<>();

        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return payments;
        }

        List<PaymentEntity> paymentList;
        if (status == null || status.isEmpty() || "ALL".equals(status)) {
            paymentList = paymentRepository.findAll();
        } else {
            try {
                PaymentEntity.PaymentGatewayStatus paymentStatus = PaymentEntity.PaymentGatewayStatus.valueOf(status);
                paymentList = paymentRepository.findByPaymentStatus(paymentStatus);
            } catch (IllegalArgumentException e) {
                paymentList = paymentRepository.findAll();
            }
        }

        paymentList.sort((a, b) -> {
            if (a.getPaymentDate() == null && b.getPaymentDate() == null) return 0;
            if (a.getPaymentDate() == null) return 1;
            if (b.getPaymentDate() == null) return -1;
            return b.getPaymentDate().compareTo(a.getPaymentDate());
        });

        for (PaymentEntity payment : paymentList) {
            Map<String, Object> map = new HashMap<>();
            map.put("paymentId", payment.getPaymentId());
            map.put("orderId", payment.getOrderId());
            map.put("amount", payment.getAmount());
            map.put("mode", payment.getPaymentMode() != null ? payment.getPaymentMode().toString() : "");
            map.put("status", payment.getPaymentStatus() != null ? payment.getPaymentStatus().toString() : "");
            map.put("transactionRef", payment.getTransactionRef());
            map.put("paymentDate", payment.getPaymentDate() != null ?
                    payment.getPaymentDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : "");
            map.put("createdAt", payment.getCreatedAt() != null ?
                    payment.getCreatedAt().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : "");

            Optional<OrderEntity> orderOpt = orderRepository.findById(payment.getOrderId());
            map.put("customerId", orderOpt.map(OrderEntity::getCustomerId).orElse(null));

            payments.add(map);
        }
        return payments;
    }

    @GetMapping("/api/payment/status/{orderId}")
    @ResponseBody
    public Map<String, Object> getPaymentStatus(@PathVariable Integer orderId,
                                                HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Not authenticated");
            return response;
        }

        Optional<PaymentEntity> paymentOpt = paymentRepository.findByOrderId(orderId);
        if (paymentOpt.isPresent()) {
            PaymentEntity payment = paymentOpt.get();
            response.put("success", true);
            response.put("paymentId", payment.getPaymentId());
            response.put("status", payment.getPaymentStatus());
            response.put("mode", payment.getPaymentMode());
            response.put("amount", payment.getAmount());
            response.put("transactionRef", payment.getTransactionRef());
            response.put("paymentDate", payment.getPaymentDate() != null ?
                    payment.getPaymentDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : null);
        } else {
            response.put("success", false);
            response.put("message", "Payment not found");
        }
        return response;
    }

    @GetMapping("/api/admin/payment-summary")
    @ResponseBody
    public Map<String, Object> getPaymentSummary(HttpSession session) {
        Map<String, Object> summary = new HashMap<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return summary;
        }

        List<PaymentEntity> allPayments = paymentRepository.findAll();
        long totalPayments = allPayments.size();
        long successfulPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                .count();
        long failedPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.FAILED)
                .count();
        long pendingPayments = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.PENDING)
                .count();

        Double totalRevenue = allPayments.stream()
                .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                .mapToDouble(PaymentEntity::getAmount)
                .sum();

        Map<String, Double> revenueByMode = new HashMap<>();
        for (PaymentEntity.PaymentMode mode : PaymentEntity.PaymentMode.values()) {
            double modeRevenue = allPayments.stream()
                    .filter(p -> p.getPaymentStatus() == PaymentEntity.PaymentGatewayStatus.SUCCESS)
                    .filter(p -> p.getPaymentMode() == mode)
                    .mapToDouble(PaymentEntity::getAmount)
                    .sum();
            if (modeRevenue > 0) revenueByMode.put(mode.toString(), modeRevenue);
        }

        List<Map<String, Object>> dailyRevenue = new ArrayList<>();
        LocalDateTime endDate = LocalDateTime.now();
        LocalDateTime startDate = endDate.minusDays(6);
        try {
            List<Object[]> dailyData = paymentRepository.getDailyRevenue(startDate, endDate);
            for (Object[] data : dailyData) {
                Map<String, Object> day = new HashMap<>();
                day.put("date", data[0].toString());
                day.put("revenue", data[1]);
                dailyRevenue.add(day);
            }
        } catch (Exception ignored) {
        }

        summary.put("totalPayments", totalPayments);
        summary.put("successfulPayments", successfulPayments);
        summary.put("failedPayments", failedPayments);
        summary.put("pendingPayments", pendingPayments);
        summary.put("totalRevenue", totalRevenue);
        summary.put("successRate", totalPayments > 0 ? (successfulPayments * 100.0 / totalPayments) : 0);
        summary.put("revenueByMode", revenueByMode);
        summary.put("dailyRevenue", dailyRevenue);

        return summary;
    }

    @GetMapping("/api/admin/recent-payments")
    @ResponseBody
    public List<Map<String, Object>> getRecentPayments(HttpSession session) {
        List<Map<String, Object>> payments = new ArrayList<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return payments;
        }

        Pageable pageable = PageRequest.of(0, 10, Sort.by("paymentDate").descending());
        List<PaymentEntity> recentPayments = paymentRepository.findAll(pageable).getContent();

        for (PaymentEntity payment : recentPayments) {
            Map<String, Object> map = new HashMap<>();
            map.put("paymentId", payment.getPaymentId());
            map.put("orderId", payment.getOrderId());
            map.put("amount", payment.getAmount());
            map.put("mode", payment.getPaymentMode() != null ? payment.getPaymentMode().toString() : "");
            map.put("status", payment.getPaymentStatus() != null ? payment.getPaymentStatus().toString() : "");
            map.put("transactionRef", payment.getTransactionRef());
            map.put("date", payment.getPaymentDate() != null ?
                    payment.getPaymentDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy")) : "");
            map.put("paymentDateTime", payment.getPaymentDate() != null ?
                    payment.getPaymentDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : "");

            Optional<OrderEntity> orderOpt = orderRepository.findById(payment.getOrderId());
            orderOpt.ifPresent(order -> {
                map.put("customerId", order.getCustomerId());
                map.put("orderStatus", order.getOrderStatus());
            });

            payments.add(map);
        }
        return payments;
    }

    @PostMapping("/api/admin/payment/update-status")
    @ResponseBody
    public Map<String, Object> updatePaymentStatus(@RequestParam Integer paymentId,
                                                   @RequestParam String status,
                                                   HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.put("success", false);
            response.put("message", "Unauthorized");
            return response;
        }

        Optional<PaymentEntity> paymentOpt = paymentRepository.findById(paymentId);
        if (paymentOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Payment not found");
            return response;
        }

        PaymentEntity payment = paymentOpt.get();
        try {
            PaymentEntity.PaymentGatewayStatus newStatus = PaymentEntity.PaymentGatewayStatus.valueOf(status);
            payment.setPaymentStatus(newStatus);
            if (newStatus == PaymentEntity.PaymentGatewayStatus.SUCCESS) {
                payment.setPaymentDate(LocalDateTime.now());
                orderRepository.findById(payment.getOrderId()).ifPresent(order -> {
                    order.setPaymentStatus(OrderEntity.PaymentStatus.PAID);
                    orderRepository.save(order);
                });
            }
            paymentRepository.save(payment);
            response.put("success", true);
            response.put("message", "Payment status updated successfully");
        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", "Invalid status");
        }
        return response;
    }

    // ==================== HELPER METHODS ====================

    private boolean validateCardDetails(String cardNumber, String expiryMonth,
                                        String expiryYear, String cvv) {
        if (cardNumber == null || cardNumber.replaceAll("\\s", "").length() != 16) return false;
        if (cvv == null || cvv.length() != 3) return false;
        // Optional: validate expiry date not in past
        return true;
    }

    private boolean validateUpiId(String upiId) {
        return upiId != null && upiId.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+$");
    }
}