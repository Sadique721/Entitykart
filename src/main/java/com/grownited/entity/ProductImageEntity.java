package com.grownited.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "product_image")
public class ProductImageEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productImageId;      // Primary Key
    
    private Integer productId;            // Foreign Key to Product
    
    private String imageURL;              // Cloudinary image URL
    
    private Boolean isPrimary;             // true = main image, false = gallery image
    
    private Integer displayOrder;          // For sorting images (1,2,3...)
    
    private LocalDateTime createdAt;       // When image was added
    
    private LocalDateTime updatedAt;       // Last update time

    // Automatically set timestamps when entity is created
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isPrimary == null) {
            isPrimary = false;            // Default to not primary
        }
        if (displayOrder == null) {
            displayOrder = 0;              // Default order
        }
    }

    // Automatically update timestamp when entity is updated
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // ==================== GETTERS AND SETTERS ====================

    public Integer getProductImageId() {
        return productImageId;
    }

    public void setProductImageId(Integer productImageId) {
        this.productImageId = productImageId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Boolean getIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(Boolean isPrimary) {
        this.isPrimary = isPrimary;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
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

    // Helper method to check if this is primary image
    public boolean isPrimary() {
        return Boolean.TRUE.equals(isPrimary);
    }

    @Override
    public String toString() {
        return "ProductImageEntity [productImageId=" + productImageId + 
               ", productId=" + productId + 
               ", isPrimary=" + isPrimary + 
               ", displayOrder=" + displayOrder + "]";
    }
    
 // Add these helper methods
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy"));
    }

    public String getFormattedCreatedAtWithTime() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a"));
    }
    
}