package com.grownited.entity;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@Entity
@Table(name = "payment")
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paymentId;
    
    private Integer orderId; // Foreign Key to Order
    
    private Double amount;
    
    @Enumerated(EnumType.STRING)
    private PaymentMode paymentMode;
    
    private String transactionRef;
    
    @Enumerated(EnumType.STRING)
    private PaymentGatewayStatus paymentStatus;
    
    private LocalDateTime paymentDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // New fields for gateway details
    private String gatewayTransactionId;
    private String gatewayResponseCode;
    private String gatewayResponseText;
    private String gatewayName; // NEW: name of the payment gateway used
    
    // Enums
    public enum PaymentMode {
        CARD, COD, UPI, NET_BANKING, WALLET, RAZORPAY
    }
    
    public enum PaymentGatewayStatus {
        SUCCESS, FAILED, PENDING
    }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (paymentDate == null) paymentDate = LocalDateTime.now();
        if (paymentStatus == null) paymentStatus = PaymentGatewayStatus.PENDING;
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters (existing and new)
    public Integer getPaymentId() { return paymentId; }
    public void setPaymentId(Integer paymentId) { this.paymentId = paymentId; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public PaymentMode getPaymentMode() { return paymentMode; }
    public void setPaymentMode(PaymentMode paymentMode) { this.paymentMode = paymentMode; }

    public String getTransactionRef() { return transactionRef; }
    public void setTransactionRef(String transactionRef) { this.transactionRef = transactionRef; }

    public PaymentGatewayStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentGatewayStatus paymentStatus) { this.paymentStatus = paymentStatus; }

    public LocalDateTime getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getGatewayTransactionId() { return gatewayTransactionId; }
    public void setGatewayTransactionId(String gatewayTransactionId) { this.gatewayTransactionId = gatewayTransactionId; }

    public String getGatewayResponseCode() { return gatewayResponseCode; }
    public void setGatewayResponseCode(String gatewayResponseCode) { this.gatewayResponseCode = gatewayResponseCode; }

    public String getGatewayResponseText() { return gatewayResponseText; }
    public void setGatewayResponseText(String gatewayResponseText) { this.gatewayResponseText = gatewayResponseText; }

    public String getGatewayName() { return gatewayName; }
    public void setGatewayName(String gatewayName) { this.gatewayName = gatewayName; }
    
    /**
     * Convert LocalDateTime createdAt to java.util.Date for JSP formatting.
     */
    public Date getCreatedAtAsDate() {
        return createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    /**
     * Convert LocalDateTime paymentDate to java.util.Date for JSP formatting.
     */
    public Date getPaymentDateAsDate() {
        return paymentDate != null ? Date.from(paymentDate.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    // If you ever need updatedAt in JSPs, add similar method:
    public Date getUpdatedAtAsDate() {
        return updatedAt != null ? Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    @Override
    public String toString() {
        return "PaymentEntity [paymentId=" + paymentId + ", orderId=" + orderId + 
               ", amount=" + amount + ", paymentStatus=" + paymentStatus + 
               ", gatewayName=" + gatewayName + "]";
    }
}