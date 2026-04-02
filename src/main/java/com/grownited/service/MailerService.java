package com.grownited.service;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

    @Autowired private JavaMailSender mailSender;

    @Value("${spring.mail.username}") private String fromEmail;

    public void sendWelcomeMail(UserEntity user) {
        String subject = "Welcome to EntityKart!";
        String body = "<h3>Hello " + user.getName() + ",</h3>"
                + "<p>Thank you for registering with EntityKart. Your account is now active.</p>"
                + "<p>Happy Shopping!</p>";
        sendHtmlMail(user.getEmail(), subject, body);
    }

    public void sendOtpMail(UserEntity user, String otp) {
        String subject = "Password Reset OTP";
        String body = "<h3>Hello " + user.getName() + ",</h3>"
                + "<p>Your OTP for password reset is: <b>" + otp + "</b></p>"
                + "<p>This OTP is valid for 10 minutes.</p>";
        sendHtmlMail(user.getEmail(), subject, body);
    }

    public void sendReportWithAttachments(String to, String reportType, byte[] excelData, byte[] wordData) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject("EntityKart Admin Report: " + reportType);
            helper.setText("<p>Dear Admin,</p>"
                    + "<p>Please find the attached " + reportType + " reports in Excel and Word formats.</p>"
                    + "<p>Regards,<br/>EntityKart Team</p>", true);

            // Attach Excel file
            InputStreamSource excelSource = new ByteArrayResource(excelData) {
                @Override
                public InputStream getInputStream() {
                    return new ByteArrayInputStream(excelData);
                }
            };
            helper.addAttachment(reportType + "_report.xlsx", excelSource);

            // Attach Word file
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

    private void sendHtmlMail(String to, String subject, String htmlBody) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 // File: com/grownited/service/MailerService.java
 // Add these methods to the existing class


public void sendOrderConfirmationEmail(UserEntity user, OrderEntity order,
                                       List<OrderDetailEntity> orderDetails,
                                       Map<Integer, String> productNames) {
    	String subject = "Order Confirmation - #" + order.getOrderId();
    	StringBuilder body = new StringBuilder();
body.append("<h2>Thank you for your order, ").append(user.getName()).append("!</h2>")
.append("<p>Your order <strong>#").append(order.getOrderId()).append("</strong> has been placed successfully.</p>")
.append("<h3>Order Summary</h3>")
.append("<table border='1'...>")
.append("<tr><th>Product</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
for (OrderDetailEntity detail : orderDetails) {
String productName = productNames.getOrDefault(detail.getProductId(), "Product #" + detail.getProductId());
body.append("<tr>")
.append("<td>").append(productName).append("</td>")
.append("<td>").append(detail.getQuantity()).append("</td>")
.append("<td>₹").append(detail.getPrice()).append("</td>")
.append("<td>₹").append(detail.getSubtotal()).append("</td>")
.append("</tr>");
}
body.append("</table>")
.append("<p><strong>Total Amount:</strong> ₹").append(order.getTotalAmount()).append("</p>")
.append("<p>Thank you for shopping with EntityKart!</p>");
sendHtmlMail(user.getEmail(), subject, body.toString());
}

 public void sendOrderStatusUpdateEmail(UserEntity user, OrderEntity order, String oldStatus, String newStatus) {
     String subject = "Order #" + order.getOrderId() + " status updated to " + newStatus;
     String body = "<h3>Hello " + user.getName() + ",</h3>"
                 + "<p>Your order <strong>#" + order.getOrderId() + "</strong> status has changed from "
                 + "<strong>" + oldStatus + "</strong> to <strong>" + newStatus + "</strong>.</p>"
                 + "<p>Click <a href='http://localhost:8080/order/details?orderId=" + order.getOrderId() + "'>here</a> to view details.</p>"
                 + "<p>Thank you,<br/>EntityKart Team</p>";
     sendHtmlMail(user.getEmail(), subject, body);
 }
}