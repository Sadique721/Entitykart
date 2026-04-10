package com.grownited.service;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.entity.AddressEntity;
import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.PaymentEntity;
import com.grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
    private static final DateTimeFormatter DATE_ONLY_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy");

    // ==================== USER REGISTRATION EMAIL ====================
    
    public void sendWelcomeMail(UserEntity user) {
        String subject = "🎉 Welcome to EntityKart! Your Account is Ready";
        String htmlBody = buildWelcomeEmailHtml(user);
        sendHtmlMail(user.getEmail(), subject, htmlBody);
    }
    
    private String buildWelcomeEmailHtml(UserEntity user) {
        String profilePicUrl = user.getProfilePicURL() != null ? user.getProfilePicURL() : 
            "https://ui-avatars.com/api/?background=2874f0&color=fff&bold=true&size=90&name=" + 
            (user.getName() != null ? user.getName().replace(" ", "+") : "User");
        
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>\n");
        sb.append("<html>\n");
        sb.append("<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>\n");
        sb.append("<title>Welcome to EntityKart</title>\n");
        sb.append("<style>\n");
        sb.append("*{margin:0;padding:0;box-sizing:border-box}\n");
        sb.append("body{font-family:'Segoe UI',Roboto,Arial,sans-serif;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);padding:20px}\n");
        sb.append(".email-container{max-width:600px;margin:0 auto;background:white;border-radius:24px;overflow:hidden;box-shadow:0 25px 50px -12px rgba(0,0,0,0.25)}\n");
        sb.append(".hero-section{background:linear-gradient(145deg,#2874f0 0%,#1e5fd8 100%);padding:48px 40px 40px;text-align:center;position:relative;overflow:hidden}\n");
        sb.append(".hero-section::before{content:'';position:absolute;top:-50%;left:-50%;width:200%;height:200%;background:radial-gradient(circle,rgba(255,255,255,0.1) 1%,transparent 1%);background-size:20px 20px;opacity:0.3}\n");
        sb.append(".profile-img{width:96px;height:96px;border-radius:50%;margin:0 auto 24px;border:3px solid white;box-shadow:0 8px 20px rgba(0,0,0,0.2);position:relative;z-index:1;overflow:hidden}\n");
        sb.append(".profile-img img{width:100%;height:100%;object-fit:cover}\n");
        sb.append(".hero-section h1{color:white;font-size:36px;font-weight:700;position:relative;z-index:1}\n");
        sb.append(".hero-section p{color:rgba(255,255,255,0.9);font-size:18px;position:relative;z-index:1}\n");
        sb.append(".main-content{padding:48px 40px;background:white}\n");
        sb.append(".credentials-card{background:linear-gradient(135deg,#f8fafc 0%,#eef2f6 100%);border-radius:20px;padding:30px;margin:32px 0;border-left:6px solid #2874f0}\n");
        sb.append(".credentials-card h3{margin:0 0 20px;color:#1a202c;font-size:18px;display:flex;align-items:center;gap:8px}\n");
        sb.append(".credentials-card h3 span{background:#2874f0;color:white;width:32px;height:32px;display:inline-flex;align-items:center;justify-content:center;border-radius:50%}\n");
        sb.append(".credential-row{display:flex;padding:12px 0;border-bottom:1px solid #e2e8f0}\n");
        sb.append(".credential-label{width:140px;font-weight:500;color:#4a5568}\n");
        sb.append(".credential-value{flex:1;color:#2874f0;font-weight:600}\n");
        sb.append(".security-tip{margin:20px 0 0;color:#e53e3e;font-size:14px;background:#fff5f5;padding:12px;border-radius:12px;border-left:3px solid #e53e3e}\n");
        sb.append(".btn-login{display:inline-block;background:linear-gradient(145deg,#2874f0 0%,#1a4fbf 100%);color:white;text-decoration:none;padding:18px 42px;border-radius:60px;font-weight:600;font-size:18px;margin:20px 0;text-align:center}\n");
        sb.append(".features-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin:40px 0 0}\n");
        sb.append(".feature-item{text-align:center;background:#f1f8fe;border-radius:16px;padding:20px 12px}\n");
        sb.append(".feature-icon{font-size:28px;display:block;margin-bottom:8px}\n");
        sb.append(".feature-item p{color:#2d3748;font-weight:600;font-size:14px}\n");
        sb.append(".footer{background:#f8fafc;padding:32px 40px;text-align:center;border-top:1px solid #e2e8f0}\n");
        sb.append(".footer p{color:#718096;font-size:14px;margin:5px 0}\n");
        sb.append("@media (max-width:600px){.credential-row{flex-direction:column;gap:5px}.credential-label{width:100%}.features-grid{grid-template-columns:1fr}}\n");
        sb.append("</style>\n");
        sb.append("</head>\n");
        sb.append("<body>\n");
        sb.append("<div class='email-container'>\n");
        sb.append("<div class='hero-section'>\n");
        sb.append("<div class='profile-img'><img src='" + profilePicUrl + "' alt='Profile'></div>\n");
        sb.append("<h1>Welcome, " + escapeHtml(user.getName()) + "!</h1>\n");
        sb.append("<p>Your EntityKart journey begins now</p>\n");
        sb.append("</div>\n");
        sb.append("<div class='main-content'>\n");
        sb.append("<p style='margin:0 0 24px;color:#2d3748;font-size:18px'>Dear <strong style='color:#2874f0'>" + escapeHtml(user.getName()) + "</strong>,</p>\n");
        sb.append("<p style='margin:0 0 24px;color:#4a5568;font-size:16px;line-height:1.7'>Thank you for joining <strong>EntityKart</strong>. Your account has been successfully created. Below are your login credentials – please keep them safe and change your password after your first login.</p>\n");
        sb.append("<div class='credentials-card'>\n");
        sb.append("<h3><span>✓</span> Your Account Credentials</h3>\n");
        sb.append("<div class='credential-row'><div class='credential-label'>User ID</div><div class='credential-value'>" + user.getUserId() + "</div></div>\n");
        sb.append("<div class='credential-row'><div class='credential-label'>Email Address</div><div class='credential-value'>" + escapeHtml(user.getEmail()) + "</div></div>\n");
        sb.append("<div class='credential-row'><div class='credential-label'>Contact Number</div><div class='credential-value'>" + (user.getContactNum() != null ? user.getContactNum() : "Not provided") + "</div></div>\n");
        sb.append("<div class='credential-row'><div class='credential-label'>Account Role</div><div class='credential-value'>" + user.getRole() + "</div></div>\n");
        sb.append("<div class='security-tip'><strong>🔒 Security tip:</strong> Never share your password with anyone. EntityKart will never ask for your password via email or phone.</div>\n");
        sb.append("</div>\n");
        sb.append("<div style='text-align:center;margin:32px 0'><a href='http://localhost:8080/login' class='btn-login'>🚀 Login to Your Account</a></div>\n");
        sb.append("<div class='features-grid'>\n");
        sb.append("<div class='feature-item'><span class='feature-icon'>🚚</span><p>Free delivery<br>on orders ₹499+</p></div>\n");
        sb.append("<div class='feature-item'><span class='feature-icon'>🔒</span><p>100% Secure<br>Payments</p></div>\n");
        sb.append("<div class='feature-item'><span class='feature-icon'>↩️</span><p>Easy Returns<br>30-Day Policy</p></div>\n");
        sb.append("</div>\n");
        sb.append("<p style='margin:32px 0 0;color:#2d3748;font-size:16px'>Happy shopping!<br><strong style='color:#2874f0'>The EntityKart Team</strong></p>\n");
        sb.append("</div>\n");
        sb.append("<div class='footer'><p>© 2026 EntityKart. All rights reserved.</p><p>This email was sent to " + escapeHtml(user.getEmail()) + ". If you didn't create an account, please ignore this email.</p></div>\n");
        sb.append("</div>\n");
        sb.append("</body>\n");
        sb.append("</html>");
        
        return sb.toString();
    }

    // ==================== OTP EMAIL ====================
    
    public void sendOtpMail(UserEntity user, String otp) {
        String subject = "🔐 Password Reset OTP - EntityKart";
        String htmlBody = buildOtpEmailHtml(user, otp);
        sendHtmlMail(user.getEmail(), subject, htmlBody);
    }
    
    private String buildOtpEmailHtml(UserEntity user, String otp) {
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>\n");
        sb.append("<html>\n");
        sb.append("<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>\n");
        sb.append("<title>Password Reset OTP</title>\n");
        sb.append("<style>\n");
        sb.append("*{margin:0;padding:0;box-sizing:border-box}\n");
        sb.append("body{font-family:'Segoe UI',Roboto,Arial,sans-serif;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);padding:20px}\n");
        sb.append(".email-container{max-width:500px;margin:0 auto;background:white;border-radius:20px;overflow:hidden;box-shadow:0 25px 50px -12px rgba(0,0,0,0.25)}\n");
        sb.append(".header{background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);padding:30px;text-align:center;color:white}\n");
        sb.append(".header h1{font-size:28px;margin-bottom:5px}\n");
        sb.append(".otp-box{background:#f8fafc;margin:30px;padding:30px;text-align:center;border-radius:16px}\n");
        sb.append(".otp-code{font-size:36px;font-family:monospace;letter-spacing:8px;background:white;padding:15px;border-radius:12px;font-weight:700;color:#2874f0;border:2px dashed #e2e8f0;margin:20px 0}\n");
        sb.append(".expiry-info{color:#e53e3e;font-size:14px;margin-top:15px}\n");
        sb.append(".btn-reset{display:inline-block;background:#2874f0;color:white;text-decoration:none;padding:12px 25px;border-radius:8px;font-weight:600;margin:20px 0}\n");
        sb.append(".footer{background:#f8fafc;padding:20px;text-align:center;border-top:1px solid #e2e8f0;font-size:12px;color:#718096}\n");
        sb.append("</style>\n");
        sb.append("</head>\n");
        sb.append("<body>\n");
        sb.append("<div class='email-container'>\n");
        sb.append("<div class='header'><h1>🔐 Password Reset Request</h1><p>We received a request to reset your password</p></div>\n");
        sb.append("<div class='otp-box'>\n");
        sb.append("<p>Hello <strong>" + escapeHtml(user.getName()) + "</strong>,</p>\n");
        sb.append("<p>Use the following OTP to reset your password:</p>\n");
        sb.append("<div class='otp-code'>" + otp + "</div>\n");
        sb.append("<p>This OTP is valid for <strong>10</strong> minutes.</p>\n");
        sb.append("<div class='expiry-info'>⚠️ For security reasons, do not share this OTP with anyone.</div>\n");
        sb.append("<a href='http://localhost:8080/verify-otp?email=" + user.getEmail() + "' class='btn-reset'>Verify OTP</a>\n");
        sb.append("</div>\n");
        sb.append("<div class='footer'><p>© 2026 EntityKart. All rights reserved.</p></div>\n");
        sb.append("</div>\n");
        sb.append("</body>\n");
        sb.append("</html>");
        
        return sb.toString();
    }

    // ==================== ORDER CONFIRMATION EMAIL ====================
    
    public void sendOrderConfirmationEmail(UserEntity user, OrderEntity order,
                                           List<OrderDetailEntity> orderDetails,
                                           Map<Integer, String> productNames,
                                           AddressEntity address,
                                           PaymentEntity payment) {
        String subject = "✅ Order Confirmed! #" + order.getOrderId() + " - EntityKart";
        String htmlBody = buildOrderConfirmationHtml(user, order, orderDetails, productNames, address, payment);
        sendHtmlMail(user.getEmail(), subject, htmlBody);
    }
    
    private String buildOrderConfirmationHtml(UserEntity user, OrderEntity order,
                                              List<OrderDetailEntity> orderDetails,
                                              Map<Integer, String> productNames,
                                              AddressEntity address,
                                              PaymentEntity payment) {
        
        double subtotal = orderDetails.stream().mapToDouble(d -> d.getPrice() * d.getQuantity()).sum();
        double shipping = 40.0;
        double tax = subtotal * 0.18;
        
        StringBuilder itemsHtml = new StringBuilder();
        for (OrderDetailEntity detail : orderDetails) {
            String productName = productNames.getOrDefault(detail.getProductId(), "Product #" + detail.getProductId());
            itemsHtml.append("<tr>");
            itemsHtml.append("<td style='padding:12px;border-bottom:1px solid #e2e8f0'>").append(escapeHtml(productName)).append("</td>");
            itemsHtml.append("<td style='padding:12px;border-bottom:1px solid #e2e8f0;text-align:center'>").append(detail.getQuantity()).append("</td>");
            itemsHtml.append("<td style='padding:12px;border-bottom:1px solid #e2e8f0;text-align:right'>₹").append(String.format("%.2f", detail.getPrice())).append("</td>");
            itemsHtml.append("<td style='padding:12px;border-bottom:1px solid #e2e8f0;text-align:right'>₹").append(String.format("%.2f", detail.getSubtotal())).append("</td>");
            itemsHtml.append("</tr>\n");
        }
        
        String addressHtml = "";
        if (address != null) {
            addressHtml = "<div class='delivery-info' style='background:#e8f5e9;border-radius:12px;padding:15px;margin:20px 0;display:flex;align-items:center;gap:15px'>" +
                "<span style='font-size:24px'>📍</span>" +
                "<div>" +
                "<strong>Delivery Address</strong><br>" +
                escapeHtml(address.getFullName()) + ", " + escapeHtml(address.getMobileNo()) + "<br>" +
                escapeHtml(address.getAddressLine1()) + "<br>" +
                escapeHtml(address.getCity()) + ", " + escapeHtml(address.getState()) + " - " + address.getPincode() +
                "</div>" +
                "</div>";
        }
        
        String paymentHtml = "";
        if (payment != null && payment.getPaymentMode() != null) {
            paymentHtml = "<div class='payment-info' style='background:#f0f7ff;border-radius:12px;padding:15px;margin:20px 0'>" +
                "<strong>💳 Payment Method:</strong> " + payment.getPaymentMode() + "<br>" +
                "<strong>📝 Transaction ID:</strong> " + (payment.getTransactionRef() != null ? payment.getTransactionRef() : "N/A") +
                "</div>";
        }
        
        String statusClass = "placed";
        if (order.getOrderStatus() != null) {
            String status = order.getOrderStatus().toString();
            if (status.equals("DELIVERED")) statusClass = "delivered";
            else if (status.equals("CANCELLED")) statusClass = "cancelled";
            else if (status.equals("SHIPPED")) statusClass = "shipped";
            else statusClass = "placed";
        }
        
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>\n");
        sb.append("<html>\n");
        sb.append("<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>\n");
        sb.append("<title>Order Confirmation</title>\n");
        sb.append("<style>\n");
        sb.append("*{margin:0;padding:0;box-sizing:border-box}\n");
        sb.append("body{font-family:'Segoe UI',Roboto,Arial,sans-serif;background:#f1f3f6;padding:20px}\n");
        sb.append(".email-container{max-width:700px;margin:0 auto;background:white;border-radius:16px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,0.1)}\n");
        sb.append(".header{background:linear-gradient(135deg,#2874f0 0%,#1e5fd8 100%);padding:30px;text-align:center;color:white}\n");
        sb.append(".header h1{font-size:28px;margin-bottom:5px}\n");
        sb.append(".order-badge{display:inline-block;background:rgba(255,255,255,0.2);padding:5px 15px;border-radius:20px;margin-top:15px;font-size:14px}\n");
        sb.append(".content{padding:30px}\n");
        sb.append(".order-summary{background:#f8fafc;border-radius:12px;padding:20px;margin:20px 0}\n");
        sb.append(".order-info{display:flex;flex-wrap:wrap;gap:20px;margin-bottom:20px}\n");
        sb.append(".order-info-item{flex:1;min-width:150px}\n");
        sb.append(".order-info-item .label{font-size:12px;color:#718096;text-transform:uppercase}\n");
        sb.append(".order-info-item .value{font-size:16px;font-weight:600;color:#2d3748;margin-top:5px}\n");
        sb.append(".status-badge{display:inline-block;padding:4px 12px;border-radius:20px;font-size:12px;font-weight:600}\n");
        sb.append(".status-placed{background:#fff3e0;color:#ff9f00}\n");
        sb.append(".status-shipped{background:#e0f2fe;color:#17a2b8}\n");
        sb.append(".status-delivered{background:#e8f5e9;color:#28a745}\n");
        sb.append(".products-table{width:100%;border-collapse:collapse;margin:20px 0}\n");
        sb.append(".products-table th{text-align:left;padding:12px;background:#f1f3f6;font-weight:600}\n");
        sb.append(".products-table td{padding:12px;border-bottom:1px solid #e2e8f0}\n");
        sb.append(".price-summary{background:#f8fafc;border-radius:12px;padding:20px;margin-top:20px}\n");
        sb.append(".price-row{display:flex;justify-content:space-between;padding:8px 0}\n");
        sb.append(".price-row.total{border-top:2px solid #e2e8f0;margin-top:10px;padding-top:15px;font-weight:700;font-size:18px;color:#2874f0}\n");
        sb.append(".track-btn{display:inline-block;background:#2874f0;color:white;text-decoration:none;padding:12px 25px;border-radius:8px;font-weight:600;margin:20px 0;text-align:center}\n");
        sb.append(".footer{background:#f8fafc;padding:25px;text-align:center;border-top:1px solid #e2e8f0}\n");
        sb.append(".footer p{color:#718096;font-size:12px;margin:5px 0}\n");
        sb.append("@media (max-width:600px){.order-info{flex-direction:column;gap:10px}}\n");
        sb.append("</style>\n");
        sb.append("</head>\n");
        sb.append("<body>\n");
        sb.append("<div class='email-container'>\n");
        sb.append("<div class='header'><h1>✅ Order Confirmed!</h1><p>Thank you for shopping with EntityKart</p><div class='order-badge'>Order #" + order.getOrderId() + "</div></div>\n");
        sb.append("<div class='content'>\n");
        sb.append("<div><h2>Hello, " + escapeHtml(user.getName()) + "!</h2><p>Your order has been placed successfully and is being processed.</p></div>\n");
        sb.append("<div class='order-summary'>\n");
        sb.append("<div class='order-info'>\n");
        sb.append("<div class='order-info-item'><div class='label'>ORDER PLACED</div><div class='value'>" + (order.getOrderDate() != null ? order.getOrderDate().format(DATE_FORMATTER) : "Today") + "</div></div>\n");
        sb.append("<div class='order-info-item'><div class='label'>TOTAL AMOUNT</div><div class='value'>₹" + String.format("%.2f", order.getTotalAmount()) + "</div></div>\n");
        sb.append("<div class='order-info-item'><div class='label'>ORDER STATUS</div><div class='value'><span class='status-badge status-" + statusClass + "'>" + (order.getOrderStatus() != null ? order.getOrderStatus().toString() : "PLACED") + "</span></div></div>\n");
        sb.append("</div>\n");
        sb.append("</div>\n");
        sb.append("<h3 style='margin:20px 0 10px'>🛍️ Items Ordered</h3>\n");
        sb.append("<table class='products-table'>\n");
        sb.append("<thead><tr><th>Product</th><th style='text-align:center'>Qty</th><th style='text-align:right'>Price</th><th style='text-align:right'>Total</th></tr></thead>\n");
        sb.append("<tbody>").append(itemsHtml.toString()).append("</tbody>\n");
        sb.append("</table>\n");
        sb.append("<div class='price-summary'>\n");
        sb.append("<div class='price-row'><span>Subtotal</span><span>₹").append(String.format("%.2f", subtotal)).append("</span></div>\n");
        sb.append("<div class='price-row'><span>Shipping</span><span>₹").append(String.format("%.2f", shipping)).append("</span></div>\n");
        sb.append("<div class='price-row'><span>Tax (18% GST)</span><span>₹").append(String.format("%.2f", tax)).append("</span></div>\n");
        sb.append("<div class='price-row total'><span>Total Amount</span><span>₹").append(String.format("%.2f", order.getTotalAmount())).append("</span></div>\n");
        sb.append("</div>\n");
        sb.append(addressHtml);
        sb.append(paymentHtml);
        sb.append("<div style='text-align:center'><a href='http://localhost:8080/order/details?orderId=").append(order.getOrderId()).append("' class='track-btn'>📦 Track Your Order</a></div>\n");
        sb.append("</div>\n");
        sb.append("<div class='footer'><p>© 2026 EntityKart. All rights reserved.</p></div>\n");
        sb.append("</div>\n");
        sb.append("</body>\n");
        sb.append("</html>");
        
        return sb.toString();
    }

    // ==================== ORDER STATUS UPDATE EMAIL ====================
    
    public void sendOrderStatusUpdateEmail(UserEntity user, OrderEntity order, String oldStatus, String newStatus) {
        String subject = "📦 Order #" + order.getOrderId() + " Status Updated to " + newStatus + " - EntityKart";
        
        String statusColor = getStatusColor(newStatus);
        String statusIcon = getStatusIcon(newStatus);
        
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>\n");
        sb.append("<html>\n");
        sb.append("<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>\n");
        sb.append("<title>Order Status Update</title>\n");
        sb.append("<style>\n");
        sb.append("*{margin:0;padding:0;box-sizing:border-box}\n");
        sb.append("body{font-family:'Segoe UI',Roboto,Arial,sans-serif;background:#f1f3f6;padding:20px}\n");
        sb.append(".email-container{max-width:600px;margin:0 auto;background:white;border-radius:16px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,0.1)}\n");
        sb.append(".header{padding:30px;text-align:center;color:white;background:").append(statusColor).append("}\n");
        sb.append(".status-icon{font-size:48px;margin-bottom:15px}\n");
        sb.append(".status-card{background:white;border-radius:12px;padding:25px;margin:20px;text-align:center}\n");
        sb.append(".status-value{font-size:24px;font-weight:700;margin:10px 0;color:").append(statusColor).append("}\n");
        sb.append(".track-btn{display:block;background:#2874f0;color:white;text-decoration:none;padding:12px;border-radius:8px;text-align:center;margin:20px;font-weight:600}\n");
        sb.append(".footer{background:#f8fafc;padding:20px;text-align:center;border-top:1px solid #e2e8f0;font-size:12px;color:#718096}\n");
        sb.append("</style>\n");
        sb.append("</head>\n");
        sb.append("<body>\n");
        sb.append("<div class='email-container'>\n");
        sb.append("<div class='header'><div class='status-icon'>").append(statusIcon).append("</div><h1>Order Status Update</h1><p>Order #").append(order.getOrderId()).append("</p></div>\n");
        sb.append("<div class='status-card'>\n");
        sb.append("<div class='status-value'>").append(newStatus).append("</div>\n");
        sb.append("<p>Your order status has been updated from <strong>").append(oldStatus).append("</strong> to <strong>").append(newStatus).append("</strong></p>\n");
        sb.append("</div>\n");
        sb.append("<a href='http://localhost:8080/order/details?orderId=").append(order.getOrderId()).append("' class='track-btn'>📦 View Order Details</a>\n");
        sb.append("<div class='footer'><p>© 2026 EntityKart. All rights reserved.</p></div>\n");
        sb.append("</div>\n");
        sb.append("</body>\n");
        sb.append("</html>");
        
        sendHtmlMail(user.getEmail(), subject, sb.toString());
    }
    
    private String getStatusIcon(String status) {
        if (status == null) return "📦";
        switch(status.toUpperCase()) {
            case "PLACED": return "📋";
            case "CONFIRMED": return "✅";
            case "SHIPPED": return "🚚";
            case "DELIVERED": return "🏠";
            case "CANCELLED": return "❌";
            default: return "📦";
        }
    }
    
    private String getStatusColor(String status) {
        if (status == null) return "#6c757d";
        switch(status.toUpperCase()) {
            case "PLACED": return "#ff9f00";
            case "CONFIRMED": return "#2874f0";
            case "SHIPPED": return "#17a2b8";
            case "DELIVERED": return "#28a745";
            case "CANCELLED": return "#dc3545";
            default: return "#6c757d";
        }
    }

    // ==================== ADMIN REPORT EMAIL ====================
    
    public void sendReportWithAttachments(String to, String reportType, byte[] excelData, byte[] wordData) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject("📊 EntityKart Admin Report: " + reportType.toUpperCase());
            
            StringBuilder sb = new StringBuilder();
            sb.append("<!DOCTYPE html>\n");
            sb.append("<html>\n");
            sb.append("<head><meta charset='UTF-8'><title>Admin Report</title>\n");
            sb.append("<style>\n");
            sb.append("body{font-family:'Segoe UI',sans-serif;background:#f5f7fa;padding:20px}\n");
            sb.append(".container{max-width:600px;margin:0 auto;background:white;border-radius:12px;padding:30px}\n");
            sb.append(".header{background:linear-gradient(135deg,#2874f0,#1e5fd8);color:white;padding:20px;text-align:center;border-radius:8px 8px 0 0}\n");
            sb.append(".report-info{background:#f8f9fa;padding:15px;border-radius:8px;margin:20px 0}\n");
            sb.append("</style>\n");
            sb.append("</head>\n");
            sb.append("<body>\n");
            sb.append("<div class='container'>\n");
            sb.append("<div class='header'><h2>📈 EntityKart Report</h2><p>").append(reportType.toUpperCase()).append(" Report</p></div>\n");
            sb.append("<div class='report-info'>\n");
            sb.append("<p><strong>Report Type:</strong> ").append(reportType).append("</p>\n");
            sb.append("<p><strong>Generated:</strong> ").append(java.time.LocalDateTime.now().format(DATE_FORMATTER)).append("</p>\n");
            sb.append("</div>\n");
            sb.append("<p>Dear Admin,</p>\n");
            sb.append("<p>Please find the attached ").append(reportType).append(" reports.</p>\n");
            sb.append("<hr>\n");
            sb.append("<p>Best Regards,<br><strong>EntityKart Team</strong></p>\n");
            sb.append("</div>\n");
            sb.append("</body>\n");
            sb.append("</html>");
            
            helper.setText(sb.toString(), true);

            InputStreamSource excelSource = new ByteArrayResource(excelData) {
                @Override
                public InputStream getInputStream() {
                    return new ByteArrayInputStream(excelData);
                }
            };
            helper.addAttachment(reportType + "_report.xlsx", excelSource);

            InputStreamSource wordSource = new ByteArrayResource(wordData) {
                @Override
                public InputStream getInputStream() {
                    return new ByteArrayInputStream(wordData);
                }
            };
            helper.addAttachment(reportType + "_report.doc", wordSource);

            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // ==================== PASSWORD CHANGE CONFIRMATION EMAIL ====================

    public void sendPasswordChangeConfirmationEmail(UserEntity user) {
        String subject = "🔐 Password Changed Successfully - EntityKart";
        String htmlBody = buildPasswordChangeConfirmationHtml(user);
        sendHtmlMail(user.getEmail(), subject, htmlBody);
    }

    private String buildPasswordChangeConfirmationHtml(UserEntity user) {
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>\n");
        sb.append("<html>\n");
        sb.append("<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>\n");
        sb.append("<title>Password Changed</title>\n");
        sb.append("<style>\n");
        sb.append("*{margin:0;padding:0;box-sizing:border-box}\n");
        sb.append("body{font-family:'Segoe UI',Roboto,Arial,sans-serif;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);padding:20px}\n");
        sb.append(".email-container{max-width:500px;margin:0 auto;background:white;border-radius:20px;overflow:hidden;box-shadow:0 25px 50px -12px rgba(0,0,0,0.25)}\n");
        sb.append(".header{background:linear-gradient(135deg,#28a745 0%,#1e7e34 100%);padding:30px;text-align:center;color:white}\n");
        sb.append(".header h1{font-size:28px;margin-bottom:5px}\n");
        sb.append(".content{padding:30px;text-align:center}\n");
        sb.append(".success-icon{font-size:64px;color:#28a745;margin-bottom:20px}\n");
        sb.append(".security-note{background:#fff3cd;padding:15px;border-radius:10px;margin:20px 0;color:#856404;font-size:14px}\n");
        sb.append(".btn-login{display:inline-block;background:#28a745;color:white;text-decoration:none;padding:12px 25px;border-radius:8px;font-weight:600;margin:20px 0}\n");
        sb.append(".footer{background:#f8fafc;padding:20px;text-align:center;border-top:1px solid #e2e8f0;font-size:12px;color:#718096}\n");
        sb.append("</style>\n");
        sb.append("</head>\n");
        sb.append("<body>\n");
        sb.append("<div class='email-container'>\n");
        sb.append("<div class='header'><h1>🔐 Password Changed!</h1><p>Your account security is important to us</p></div>\n");
        sb.append("<div class='content'>\n");
        sb.append("<div class='success-icon'>✓</div>\n");
        sb.append("<h3>Hello, ").append(escapeHtml(user.getName())).append("!</h3>\n");
        sb.append("<p>Your password has been successfully changed.</p>\n");
        sb.append("<div class='security-note'>\n");
        sb.append("<strong>⚠️ Didn't request this change?</strong><br>\n");
        sb.append("If you did not change your password, please contact our support team immediately.\n");
        sb.append("</div>\n");
        sb.append("<a href='http://localhost:8080/login' class='btn-login'>Login to Your Account</a>\n");
        sb.append("</div>\n");
        sb.append("<div class='footer'><p>© 2026 EntityKart. All rights reserved.</p></div>\n");
        sb.append("</div>\n");
        sb.append("</body>\n");
        sb.append("</html>");
        return sb.toString();
    }

    // ==================== UTILITY METHODS ====================
    
    private void sendHtmlMail(String to, String subject, String htmlBody) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}