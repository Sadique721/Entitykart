package com.grownited.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productId;
    private Integer userId;
    private Integer categoryId;
    private String subCategoryId;
    private String productName;
    private String description;
    private String brand;
    private Float price;
    private Integer mrp;
    private Integer stockQuantity;
    private String sku;
    private String status;
    private LocalDate createdAt;
    private String mainImageURL;
    
    // Add discountPercent field (missing from your entity)
    private Float discountPercent;  // Added this field

    // Getters and Setters
    public Integer getProductId() {
        return productId;
    }
    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getUserId() {
        return userId;
    }
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getSubCategoryId() {
        return subCategoryId;
    }
    public void setSubCategoryId(String subCategoryId) {
        this.subCategoryId = subCategoryId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getBrand() {
        return brand;
    }
    public void setBrand(String brand) {
        this.brand = brand;
    }

    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getMrp() {
        return mrp;
    }
    public void setMrp(Integer mrp) {
        this.mrp = mrp;
    }

    public Integer getStockQuantity() {
        return stockQuantity;
    }
    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getSku() {
        return sku;
    }
    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public String getMainImageURL() {
        return mainImageURL;
    }

    public void setMainImageURL(String mainImageURL) {
        this.mainImageURL = mainImageURL;
    }

    // Properly implemented getDiscountPercent method
    public Float getDiscountPercent() {
        return discountPercent;
    }

    // Setter for discountPercent
    public void setDiscountPercent(Float discountPercent) {
        this.discountPercent = discountPercent;
    }

    // Helper method to calculate discounted price
    public Float getDiscountedPrice() {
        if (discountPercent != null && discountPercent > 0) {
            return price * (1 - discountPercent / 100);
        }
        return price;
    }

    // Helper method to check if product is in stock
    public boolean isInStock() {
        return stockQuantity != null && stockQuantity > 0;
    }

    // Helper method to calculate discount amount
    public Float getDiscountAmount() {
        if (discountPercent != null && discountPercent > 0) {
            return price * discountPercent / 100;
        }
        return 0f;
    }

    // Helper method to get formatted price (could be used in JSP)
    public String getFormattedPrice() {
        return String.format("%.2f", price);
    }

    // Helper method to check if product has discount
    public boolean hasDiscount() {
        return discountPercent != null && discountPercent > 0;
    }

    @Override
    public String toString() {
        return "ProductEntity [productId=" + productId + ", productName=" + productName + 
               ", price=" + price + ", discountPercent=" + discountPercent + "]";
    }
}