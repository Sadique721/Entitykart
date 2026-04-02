package com.grownited.entity;

import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "wishlist")
public class WishlistEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer wishlistId;
    
    private Integer customerId; // Foreign Key to User
    
    private Integer productId; // Foreign Key to Product
    
    private LocalDateTime addedAt;
    
    @PrePersist
    protected void onCreate() {
        if (addedAt == null) addedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getWishlistId() { return wishlistId; }
    public void setWishlistId(Integer wishlistId) { this.wishlistId = wishlistId; }

    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public LocalDateTime getAddedAt() { return addedAt; }
    public void setAddedAt(LocalDateTime addedAt) { this.addedAt = addedAt; }
    
    // Helper methods
    public String getFormattedDate() {
        if (addedAt == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy").format(addedAt);
    }
    
    public String getFormattedDateTime() {
        if (addedAt == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a").format(addedAt);
    }
    
    @Override
    public String toString() {
        return "WishlistEntity [wishlistId=" + wishlistId + 
               ", customerId=" + customerId + 
               ", productId=" + productId + "]";
    }
}