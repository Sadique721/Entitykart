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
@Table(name = "orders")
public class OrderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderId;
    
    private Integer customerId; // Foreign Key to User
    
    private Integer addressId; // Foreign Key to Address
    
    private Double totalAmount;
    
    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;
    
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus;
    
    private LocalDateTime orderDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Order status enum
    public enum OrderStatus {
        PENDING_PAYMENT, PLACED, CONFIRMED, SHIPPED, DELIVERED, CANCELLED, RETURNED
    }
    
 // Add this method to OrderEntity.java
    public void updatePaymentStatus(PaymentStatus status) {
        this.paymentStatus = status;
        this.updatedAt = LocalDateTime.now();
    }
    
    // Payment status enum
    public enum PaymentStatus {
        PAID, UNPAID, REFUNDED
    }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (orderDate == null) {
            orderDate = LocalDateTime.now();
        }
        if (orderStatus == null) {
            orderStatus = OrderStatus.PLACED;
        }
        if (paymentStatus == null) {
            paymentStatus = PaymentStatus.UNPAID;
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Helper method to check if order can be cancelled
    public boolean canBeCancelled() {
        return orderStatus == OrderStatus.PLACED || orderStatus == OrderStatus.CONFIRMED;
    }
    
    // Helper method to check if order can be returned
    public boolean canBeReturned() {
        return orderStatus == OrderStatus.DELIVERED;
    }
    
    @Override
    public String toString() {
        return "OrderEntity [orderId=" + orderId + ", customerId=" + customerId + 
               ", orderStatus=" + orderStatus + ", totalAmount=" + totalAmount + "]";
    }
    
 // Add this method to convert LocalDateTime to Date for JSTL
    public java.util.Date getOrderDateAsDate() {
    	return orderDate != null ? Date.from(orderDate.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    public java.util.Date getCreatedAtAsDate() {
    	return createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    public java.util.Date getUpdatedAtAsDate() {
    	return updatedAt != null ? Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
}