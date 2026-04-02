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
@Table(name = "return_refund")
public class ReturnRefundEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer returnId;
    
    private Integer orderItemId; // Foreign Key to OrderDetail
    
    private String reason;
    
    @Enumerated(EnumType.STRING)
    private ReturnStatus returnStatus;
    
    private LocalDateTime requestedAt;
    private LocalDateTime processedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Return status enum
    public enum ReturnStatus {
        REQUESTED, APPROVED, REJECTED, REFUNDED
    }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (requestedAt == null) requestedAt = LocalDateTime.now();
        if (returnStatus == null) returnStatus = ReturnStatus.REQUESTED;
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // ============= HELPER METHODS FOR JSTL =============
    public Date getRequestedAtAsDate() {
        return requestedAt != null ? Date.from(requestedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public Date getProcessedAtAsDate() {
        return processedAt != null ? Date.from(processedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public Date getCreatedAtAsDate() {
        return createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public Date getUpdatedAtAsDate() {
        return updatedAt != null ? Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    // ============= FORMATTED STRING METHODS =============
    public String getFormattedRequestedAt() {
        if (requestedAt == null) return "";
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
        return requestedAt.format(formatter);
    }
    
    public String getFormattedProcessedAt() {
        if (processedAt == null) return "";
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
        return processedAt.format(formatter);
    }
    
    // Getters and Setters (existing code)
    public Integer getReturnId() { return returnId; }
    public void setReturnId(Integer returnId) { this.returnId = returnId; }

    public Integer getOrderItemId() { return orderItemId; }
    public void setOrderItemId(Integer orderItemId) { this.orderItemId = orderItemId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public ReturnStatus getReturnStatus() { return returnStatus; }
    public void setReturnStatus(ReturnStatus returnStatus) { this.returnStatus = returnStatus; }

    public LocalDateTime getRequestedAt() { return requestedAt; }
    public void setRequestedAt(LocalDateTime requestedAt) { this.requestedAt = requestedAt; }

    public LocalDateTime getProcessedAt() { return processedAt; }
    public void setProcessedAt(LocalDateTime processedAt) { this.processedAt = processedAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    // Helper methods
    public boolean isPending() {
        return returnStatus == ReturnStatus.REQUESTED;
    }
    
    public boolean isApproved() {
        return returnStatus == ReturnStatus.APPROVED;
    }
    
    public boolean isRejected() {
        return returnStatus == ReturnStatus.REJECTED;
    }
    
    public boolean isRefunded() {
        return returnStatus == ReturnStatus.REFUNDED;
    }
    
    @Override
    public String toString() {
        return "ReturnRefundEntity [returnId=" + returnId + 
               ", orderItemId=" + orderItemId + 
               ", returnStatus=" + returnStatus + "]";
    }
}