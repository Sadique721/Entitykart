package com.grownited.entity;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "review_rating")
public class ReviewRatingEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer reviewId;
    
    private Integer productId; // Foreign Key to Product
    
    private Integer customerId; // Foreign Key to User
    
    private Integer rating; // 1-5
    
    private String comment;
    
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getReviewId() { return reviewId; }
    public void setReviewId(Integer reviewId) { this.reviewId = reviewId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { 
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        this.rating = rating; 
    }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    // IMPORTANT: Helper method to convert LocalDateTime to Date for JSTL formatting
    public Date getCreatedAtAsDate() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }
    
    // Helper methods for formatted output
    public String getFormattedDate() {
        if (createdAt == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy").format(createdAt);
    }
    
    public String getFormattedDateTime() {
        if (createdAt == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a").format(createdAt);
    }
    
    @Override
    public String toString() {
        return "ReviewRatingEntity [reviewId=" + reviewId + 
               ", productId=" + productId + 
               ", customerId=" + customerId + 
               ", rating=" + rating + "]";
    }
}