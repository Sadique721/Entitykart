<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.grownited.entity.*" %>
<%@ page import="com.grownited.entity.ProductEntity" %>
<%@ page import="com.grownited.entity.ProductImageEntity" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - EntityKart</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Lightbox CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/css/lightbox.min.css">
    
    <style>
        :root {
            --primary-blue: #2874f0;
            --primary-orange: #fb641b;
            --light-gray: #f1f3f6;
            --dark-gray: #878787;
            --success-green: #26a541;
            --yellow: #ff9f00;
            --border-color: #e0e0e0;
        }
        
        body {
            background-color: var(--light-gray);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .product-container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .breadcrumb {
            background: white;
            padding: 10px 20px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .product-main {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .product-gallery {
            position: relative;
        }
        
        .main-image-container {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
            cursor: zoom-in;
        }
        
        .main-image {
            max-width: 100%;
            max-height: 400px;
            object-fit: contain;
        }
        
        .thumbnail-list {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            padding: 10px 0;
        }
        
        .thumbnail-item {
            width: 80px;
            height: 80px;
            border: 2px solid transparent;
            border-radius: 4px;
            cursor: pointer;
            padding: 5px;
            transition: all 0.3s;
            flex-shrink: 0;
        }
        
        .thumbnail-item:hover {
            border-color: var(--primary-blue);
        }
        
        .thumbnail-item.active {
            border-color: var(--primary-blue);
        }
        
        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .product-info {
            padding-left: 30px;
        }
        
        .product-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #212121;
        }
        
        .product-brand {
            color: var(--primary-blue);
            font-size: 16px;
            margin-bottom: 15px;
            display: inline-block;
            padding: 5px 15px;
            background: #f0f7ff;
            border-radius: 20px;
        }
        
        .product-rating-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px 0;
            border-top: 1px solid var(--border-color);
            border-bottom: 1px solid var(--border-color);
        }
        
        .rating-badge {
            background: var(--success-green);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .rating-count {
            color: var(--dark-gray);
        }
        
        .price-section {
            margin-bottom: 20px;
        }
        
        .current-price {
            font-size: 32px;
            font-weight: 700;
            color: #212121;
        }
        
        .original-price {
            font-size: 18px;
            color: var(--dark-gray);
            text-decoration: line-through;
            margin-left: 10px;
        }
        
        .discount-badge {
            background: var(--success-green);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: 600;
            margin-left: 10px;
            font-size: 16px;
        }
        
        .stock-status {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 4px;
            background: #f9f9f9;
        }
        
        .in-stock {
            color: var(--success-green);
            font-weight: 600;
        }
        
        .low-stock {
            color: var(--primary-orange);
            font-weight: 600;
        }
        
        .out-of-stock {
            color: #f44336;
            font-weight: 600;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .quantity-btn {
            width: 40px;
            height: 40px;
            border: 1px solid var(--border-color);
            background: white;
            border-radius: 4px;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .quantity-btn:hover:not(:disabled) {
            background: var(--primary-blue);
            color: white;
        }
        
        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 16px;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .add-to-cart-btn {
            flex: 1;
            padding: 15px;
            background: var(--primary-orange);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background 0.3s;
        }
        
        .add-to-cart-btn:hover:not(:disabled) {
            background: #e55a17;
        }
        
        .add-to-cart-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .buy-now-btn {
            flex: 1;
            padding: 15px;
            background: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background 0.3s;
        }
        
        .buy-now-btn:hover:not(:disabled) {
            background: #1e5fd8;
        }
        
        .buy-now-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .wishlist-btn {
            width: 50px;
            height: 50px;
            border: 1px solid var(--border-color);
            background: white;
            border-radius: 4px;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s;
            color: #999;
        }
        
        .wishlist-btn:hover {
            background: #fff5f5;
            color: #f44336;
        }
        
        .wishlist-btn.active {
            background: #fff5f5;
            color: #f44336;
        }
        
        .delivery-checker {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .delivery-checker h4 {
            font-size: 16px;
            margin-bottom: 15px;
        }
        
        .delivery-input-group {
            display: flex;
            gap: 10px;
        }
        
        .delivery-input {
            flex: 1;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 14px;
        }
        
        .delivery-check-btn {
            padding: 10px 20px;
            background: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
        }
        
        .delivery-check-btn:hover {
            background: #1e5fd8;
        }
        
        .delivery-result {
            margin-top: 10px;
            padding: 10px;
            border-radius: 4px;
            display: none;
        }
        
        .delivery-result.available {
            background: #e8f5e8;
            color: var(--success-green);
        }
        
        .delivery-result.not-available {
            background: #ffebee;
            color: #f44336;
        }
        
        .product-description {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .product-description h3 {
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .product-specs {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .product-specs h3 {
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .specs-table {
            width: 100%;
        }
        
        .specs-table tr {
            border-bottom: 1px solid var(--border-color);
        }
        
        .specs-table td {
            padding: 10px;
        }
        
        .specs-table td:first-child {
            font-weight: 600;
            width: 200px;
            background: #f9f9f9;
        }
        
        .related-products {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .related-products h3 {
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .related-card {
            border: 1px solid var(--border-color);
            border-radius: 4px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .related-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .related-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        
        .related-info {
            padding: 10px;
        }
        
        .related-name {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .related-price {
            font-size: 16px;
            font-weight: 600;
            color: #212121;
        }
        
        .recently-viewed {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .recently-viewed h3 {
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .share-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        
        .share-title {
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .share-icons {
            display: flex;
            gap: 15px;
        }
        
        .share-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .share-icon:hover {
            transform: scale(1.1);
        }
        
        .share-icon.facebook { background: #3b5998; }
        .share-icon.twitter { background: #1da1f2; }
        .share-icon.whatsapp { background: #25d366; }
        .share-icon.pinterest { background: #bd081c; }
        
        .loading-spinner {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        
        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-blue);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast-notification {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            padding: 16px 24px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideInRight 0.3s ease;
            max-width: 350px;
        }
        
        .toast-notification.success {
            border-left: 4px solid var(--success-green);
        }
        
        .toast-notification.error {
            border-left: 4px solid #f44336;
        }
        
        .toast-notification.info {
            border-left: 4px solid var(--primary-blue);
        }
        
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @media (max-width: 768px) {
            .product-info {
                padding-left: 0;
                margin-top: 30px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .specs-table td:first-child {
                width: 120px;
            }
        }
    </style>
</head>
<body>

<%
    // Get current user from session
    UserEntity currentUser = (UserEntity) session.getAttribute("user");
    String contextPath = request.getContextPath();
%>

<!-- Include Header -->
<jsp:include page="header.jsp" />

<div class="loading-spinner" id="loadingSpinner">
    <div class="spinner"></div>
</div>

<div class="toast-container" id="toastContainer"></div>

<div class="product-container">
    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a>
        <i class="fas fa-chevron-right mx-2" style="font-size: 12px; color: #666;"></i>
        <a href="${pageContext.request.contextPath}/products?category=${product.categoryId}" class="text-decoration-none">${categoryName}</a>
        <i class="fas fa-chevron-right mx-2" style="font-size: 12px; color: #666;"></i>
        <span class="text-muted">${product.productName}</span>
    </nav>
    
    <!-- Product Main Section -->
    <div class="product-main">
        <div class="row">
            <!-- Product Gallery -->
            <div class="col-md-6">
                <div class="product-gallery">
                    <div class="main-image-container" onclick="openLightbox()">
                        <img src="${product.mainImageURL != null ? product.mainImageURL : pageContext.request.contextPath}/images/placeholder.jpg" 
                             class="main-image" id="mainProductImage" 
                             alt="${product.productName}"
                             onerror="this.src='https://via.placeholder.com/400'">
                    </div>
                    
                    <div class="thumbnail-list">
                        <c:forEach var="image" items="${productImages}">
                            <div class="thumbnail-item ${image.isPrimary ? 'active' : ''}" 
                                 onclick="changeMainImage('${image.imageURL}', this)">
                                <img src="${image.imageURL}" alt="Product thumbnail"
                                     onerror="this.src='https://via.placeholder.com/80'">
                            </div>
                        </c:forEach>
                        <c:if test="${empty productImages}">
                            <div class="thumbnail-item active">
                                <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/80'}" 
                                     alt="Product thumbnail">
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- Product Info -->
            <div class="col-md-6">
                <div class="product-info">
                    <h1 class="product-title">${product.productName}</h1>
                    
                    <c:if test="${not empty product.brand}">
                        <span class="product-brand">
                            <i class="fas fa-tag me-2"></i>${product.brand}
                        </span>
                    </c:if>
                    
                    <div class="product-rating-section">
                        <div class="rating-badge">
                            ${avgRating != null ? avgRating : '4.2'} <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-count">${totalReviews != null ? totalReviews : '128'} Ratings & Reviews</span>
                    </div>
                    
                    <div class="price-section">
                        <span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                        <c:if test="${product.mrp > product.price}">
                            <span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0"/></span>
                            <span class="discount-badge">${product.discountPercent}% off</span>
                        </c:if>
                    </div>
                    
                    <div class="stock-status">
                        <c:choose>
                            <c:when test="${product.stockQuantity > 10}">
                                <span class="in-stock">
                                    <i class="fas fa-check-circle me-2"></i>In Stock (${product.stockQuantity} available)
                                </span>
                            </c:when>
                            <c:when test="${product.stockQuantity > 0}">
                                <span class="low-stock">
                                    <i class="fas fa-exclamation-circle me-2"></i>Hurry! Only ${product.stockQuantity} left in stock
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="out-of-stock">
                                    <i class="fas fa-times-circle me-2"></i>Out of Stock
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Quantity Selector -->
                    <div class="quantity-selector">
                        <span style="font-weight: 600;">Quantity:</span>
                        <button class="quantity-btn" onclick="updateQuantity(-1)" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-minus"></i>
                        </button>
                        <input type="number" class="quantity-input" id="quantity" value="1" min="1" 
                               max="${product.stockQuantity}" readonly>
                        <button class="quantity-btn" onclick="updateQuantity(1)" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-plus"></i>
                        </button>
                        <span class="text-muted ms-2">${product.stockQuantity} available</span>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="add-to-cart-btn" onclick="addToCart()" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="buy-now-btn" onclick="buyNow()" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-bolt"></i>
                            Buy Now
                        </button>
                        <button class="wishlist-btn ${inWishlist ? 'active' : ''}" 
                                onclick="toggleWishlist()">
                            <i class="fa${inWishlist ? 's' : 'r'} fa-heart"></i>
                        </button>
                    </div>
                    
                    <!-- Delivery Checker -->
                    <div class="delivery-checker">
                        <h4><i class="fas fa-truck me-2"></i>Check Delivery</h4>
                        <div class="delivery-input-group">
                            <input type="text" class="delivery-input" id="pincode" 
                                   placeholder="Enter Pincode" maxlength="6" pattern="[0-9]{6}">
                            <button class="delivery-check-btn" onclick="checkDelivery()">Check</button>
                        </div>
                        <div class="delivery-result" id="deliveryResult"></div>
                    </div>
                    
                    <!-- Share Section -->
                    <div class="share-section">
                        <div class="share-title">Share this product:</div>
                        <div class="share-icons">
                            <div class="share-icon facebook" onclick="shareOnFacebook()">
                                <i class="fab fa-facebook-f"></i>
                            </div>
                            <div class="share-icon twitter" onclick="shareOnTwitter()">
                                <i class="fab fa-twitter"></i>
                            </div>
                            <div class="share-icon whatsapp" onclick="shareOnWhatsApp()">
                                <i class="fab fa-whatsapp"></i>
                            </div>
                            <div class="share-icon pinterest" onclick="shareOnPinterest()">
                                <i class="fab fa-pinterest-p"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Product Description -->
    <div class="product-description">
        <h3>Product Description</h3>
        <div class="description-content">
            <c:choose>
                <c:when test="${not empty product.description}">
                    ${product.description}
                </c:when>
                <c:otherwise>
                    <p class="text-muted">No description available for this product.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Product Specifications -->
    <div class="product-specs">
        <h3>Specifications</h3>
        <table class="specs-table">
            <tr>
                <td>Brand</td>
                <td>${product.brand != null ? product.brand : 'EntityKart'}</td>
            </tr>
            <tr>
                <td>Category</td>
                <td>${categoryName}</td>
            </tr>
            <tr>
                <td>Sub-Category</td>
                <td>${subCategoryName != null ? subCategoryName : 'N/A'}</td>
            </tr>
            <tr>
                <td>SKU</td>
                <td>${product.sku != null ? product.sku : 'N/A'}</td>
            </tr>
            <tr>
                <td>Availability</td>
                <td>
                    <c:choose>
                        <c:when test="${product.stockQuantity > 0}">
                            In Stock (${product.stockQuantity} units)
                        </c:when>
                        <c:otherwise>
                            Out of Stock
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Added on</td>
                <td><fmt:formatDate value="${product.createdAt}" pattern="dd MMM yyyy"/></td>
            </tr>
        </table>
    </div>
    
    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <div class="related-products">
            <h3>Related Products</h3>
            <div class="related-grid">
                <c:forEach var="related" items="${relatedProducts}">
                    <div class="related-card" onclick="viewProduct(${related.productId})">
                        <img src="${related.mainImageURL != null ? related.mainImageURL : 'https://via.placeholder.com/200'}" 
                             class="related-image" alt="${related.productName}"
                             onerror="this.src='https://via.placeholder.com/200'">
                        <div class="related-info">
                            <div class="related-name">${related.productName}</div>
                            <div class="related-price">₹<fmt:formatNumber value="${related.price}" pattern="#,##0"/></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
    
    <!-- Recently Viewed -->
    <c:if test="${not empty recentlyViewed}">
        <div class="recently-viewed">
            <h3>Recently Viewed</h3>
            <div class="related-grid">
                <c:forEach var="recent" items="${recentlyViewed}">
                    <div class="related-card" onclick="viewProduct(${recent.productId})">
                        <img src="${recent.mainImageURL != null ? recent.mainImageURL : 'https://via.placeholder.com/200'}" 
                             class="related-image" alt="${recent.productName}"
                             onerror="this.src='https://via.placeholder.com/200'">
                        <div class="related-info">
                            <div class="related-name">${recent.productName}</div>
                            <div class="related-price">₹<fmt:formatNumber value="${recent.price}" pattern="#,##0"/></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

<!-- Lightbox Container -->
<div style="display: none;">
    <c:forEach var="image" items="${productImages}">
        <a href="${image.imageURL}" data-lightbox="product-gallery" data-title="${product.productName}"></a>
    </c:forEach>
    <c:if test="${empty productImages}">
        <a href="${product.mainImageURL}" data-lightbox="product-gallery" data-title="${product.productName}"></a>
    </c:if>
</div>

<!-- Include Footer -->
<jsp:include page="footer.jsp" />

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/js/lightbox.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    // Global Variables
    let currentQuantity = 1;
    const productId = ${product.productId};
    const maxQuantity = ${product.stockQuantity};
    let inWishlist = ${inWishlist ? 'true' : 'false'};
    const contextPath = '${pageContext.request.contextPath}';
    
    // Image Gallery Functions
    function changeMainImage(imageUrl, element) {
        document.getElementById('mainProductImage').src = imageUrl;
        document.querySelectorAll('.thumbnail-item').forEach(item => {
            item.classList.remove('active');
        });
        element.classList.add('active');
    }
    
    function openLightbox() {
        const lightboxLink = document.querySelector('[data-lightbox="product-gallery"]');
        if (lightboxLink) {
            lightboxLink.click();
        }
    }
    
    // Quantity Functions
    function updateQuantity(change) {
        const input = document.getElementById('quantity');
        let newValue = parseInt(input.value) + change;
        
        if (newValue >= 1 && newValue <= maxQuantity) {
            input.value = newValue;
            currentQuantity = newValue;
        }
    }
    
    // Cart Functions - FIXED: Using correct GET endpoint
    function addToCart() {
        <% if (currentUser != null) { %>
            showLoading();
            
            // Using GET as per CartController
            window.location.href = contextPath + '/cart/add?productId=' + productId + '&quantity=' + currentQuantity;
            
            // Note: Since this is a redirect, we'll show a success message and the page will reload
            setTimeout(() => {
                hideLoading();
                showToast('success', 'Product added to cart successfully!');
                updateCartCount();
            }, 500);
        <% } else { %>
            showToast('info', 'Please login to add items to cart');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Buy Now Function - FIXED: Using correct checkout endpoint
    function buyNow() {
        <% if (currentUser != null) { %>
            window.location.href = contextPath + '/checkout?productId=' + productId + '&quantity=' + currentQuantity;
        <% } else { %>
            showToast('info', 'Please login to place order');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Update Cart Count
    function updateCartCount() {
        <% if (currentUser != null) { %>
            axios.get(contextPath + '/cart/count')
                .then(response => {
                    const cartElement = document.getElementById('cartCount');
                    if (cartElement) cartElement.textContent = response.data.count || 0;
                })
                .catch(error => console.log('Failed to update cart count'));
        <% } %>
    }
    
    // Wishlist Functions - FIXED: Using toggle endpoint
    function toggleWishlist() {
        <% if (currentUser != null) { %>
            const btn = document.querySelector('.wishlist-btn');
            const wasActive = btn.classList.contains('active');
            
            // Optimistic UI update
            btn.classList.toggle('active');
            const icon = btn.querySelector('i');
            icon.classList.toggle('fas');
            icon.classList.toggle('far');
            
            axios.post(contextPath + '/api/wishlist/toggle', null, { 
                params: { productId: productId } 
            })
            .then(response => {
                const data = response.data;
                if (data.success) {
                    inWishlist = data.inWishlist;
                    showToast('success', inWishlist ? 'Added to wishlist!' : 'Removed from wishlist!');
                    
                    // Update wishlist count
                    if (data.count !== undefined) {
                        const wishlistCount = document.getElementById('wishlistCount');
                        if (wishlistCount) {
                            wishlistCount.textContent = data.count;
                            wishlistCount.style.display = data.count > 0 ? 'flex' : 'none';
                        }
                    }
                } else {
                    // Revert if failed
                    btn.classList.toggle('active', wasActive);
                    icon.classList.toggle('fas', wasActive);
                    icon.classList.toggle('far', !wasActive);
                    showToast('error', data.message || 'Failed to update wishlist');
                }
            })
            .catch(error => {
                // Revert on error
                btn.classList.toggle('active', wasActive);
                icon.classList.toggle('fas', wasActive);
                icon.classList.toggle('far', !wasActive);
                console.error('Error:', error);
                showToast('error', 'Failed to update wishlist');
            });
        <% } else { %>
            showToast('info', 'Please login to use wishlist');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Delivery Checker
    function checkDelivery() {
        const pincode = document.getElementById('pincode').value.trim();
        const resultDiv = document.getElementById('deliveryResult');
        
        if (!pincode || !/^\d{6}$/.test(pincode)) {
            resultDiv.className = 'delivery-result not-available';
            resultDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Please enter a valid 6-digit pincode';
            resultDiv.style.display = 'block';
            return;
        }
        
        showLoading();
        
        axios.get(contextPath + '/check-delivery', { params: { pincode: pincode } })
            .then(response => {
                hideLoading();
                const data = response.data;
                
                if (data.available) {
                    resultDiv.className = 'delivery-result available';
                    resultDiv.innerHTML = '<i class="fas fa-check-circle me-2"></i>' + data.message;
                } else {
                    resultDiv.className = 'delivery-result not-available';
                    resultDiv.innerHTML = '<i class="fas fa-times-circle me-2"></i>' + data.message;
                }
                resultDiv.style.display = 'block';
            })
            .catch(error => {
                hideLoading();
                console.error('Error:', error);
                resultDiv.className = 'delivery-result not-available';
                resultDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Error checking delivery';
                resultDiv.style.display = 'block';
            });
    }
    
    // Share Functions
    function shareOnFacebook() {
        const url = encodeURIComponent(window.location.href);
        const title = encodeURIComponent('${product.productName}');
        window.open('https://www.facebook.com/sharer/sharer.php?u=' + url + '&quote=' + title, '_blank');
    }
    
    function shareOnTwitter() {
        const url = encodeURIComponent(window.location.href);
        const text = encodeURIComponent('Check out ${product.productName} on EntityKart');
        window.open('https://twitter.com/intent/tweet?text=' + text + '&url=' + url, '_blank');
    }
    
    function shareOnWhatsApp() {
        const text = encodeURIComponent('Check out ${product.productName} on EntityKart: ' + window.location.href);
        window.open('https://wa.me/?text=' + text, '_blank');
    }
    
    function shareOnPinterest() {
        const url = encodeURIComponent(window.location.href);
        const media = encodeURIComponent('${product.mainImageURL}');
        const description = encodeURIComponent('${product.productName}');
        window.open('https://pinterest.com/pin/create/button/?url=' + url + '&media=' + media + '&description=' + description, '_blank');
    }
    
    // Navigation
    function viewProduct(productId) {
        window.location.href = contextPath + '/product/' + productId;
    }
    
    // Utility Functions
    function showLoading() {
        document.getElementById('loadingSpinner').style.display = 'flex';
    }
    
    function hideLoading() {
        document.getElementById('loadingSpinner').style.display = 'none';
    }
    
    function showToast(type, message) {
        const toastId = 'toast-' + Date.now();
        const icons = {
            success: 'fa-check-circle',
            error: 'fa-exclamation-circle',
            info: 'fa-info-circle'
        };
        const titles = {
            success: 'Success',
            error: 'Error',
            info: 'Info'
        };
        
        const toast = `
            <div id="${toastId}" class="toast-notification ${type}">
                <div class="toast-icon"><i class="fas ${icons[type]}"></i></div>
                <div class="toast-content">
                    <div class="toast-title">${titles[type]}</div>
                    <div class="toast-message">${message}</div>
                </div>
            </div>
        `;
        
        document.getElementById('toastContainer').insertAdjacentHTML('beforeend', toast);
        
        setTimeout(() => {
            const element = document.getElementById(toastId);
            if (element) {
                element.style.animation = 'slideOutRight 0.3s ease forwards';
                setTimeout(() => element.remove(), 300);
            }
        }, 3000);
    }
    
    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
        // Lightbox options
        if (typeof lightbox !== 'undefined') {
            lightbox.option({
                'resizeDuration': 200,
                'wrapAround': true,
                'albumLabel': 'Image %1 of %2'
            });
        }
        
        // Update cart count on load
        updateCartCount();
    });
</script>

</body>
</html>