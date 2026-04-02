<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.grownited.entity.*" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>
<%@ page import="com.grownited.entity.ProductEntity" %>
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
    <title>
        <c:choose>
            <c:when test="${not empty categoryName}">${categoryName} - </c:when>
            <c:when test="${not empty searchQuery}">Search: ${searchQuery} - </c:when>
        </c:choose>
        EntityKart Products
    </title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Range Slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    
    <style>
        /* Copy all styles from the previous productList.jsp */
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
        
        .products-container {
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
        
        /* Filter Sidebar */
        .filter-sidebar {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .filter-header {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .filter-section {
            margin-bottom: 25px;
        }
        
        .filter-section-title {
            font-weight: 600;
            margin-bottom: 15px;
            font-size: 14px;
        }
        
        .category-filter-item {
            margin-bottom: 10px;
        }
        
        .category-filter-link {
            color: #212121;
            text-decoration: none;
            font-size: 14px;
            display: block;
            padding: 5px 0;
            transition: color 0.3s;
        }
        
        .category-filter-link:hover {
            color: var(--primary-blue);
        }
        
        .category-filter-link.active {
            color: var(--primary-blue);
            font-weight: 600;
        }
        
        .brand-checkbox {
            display: block;
            margin-bottom: 10px;
        }
        
        .brand-checkbox input {
            margin-right: 8px;
        }
        
        .price-range {
            padding: 0 10px;
        }
        
        .price-slider {
            margin: 20px 0;
        }
        
        .price-inputs {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .price-input {
            flex: 1;
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 13px;
        }
        
        .apply-filter-btn {
            width: 100%;
            padding: 10px;
            background: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 15px;
        }
        
        .apply-filter-btn:hover {
            background: #1e5fd8;
        }
        
        /* Products Main */
        .products-main {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .results-count {
            font-size: 14px;
            color: var(--dark-gray);
        }
        
        .sort-section {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .sort-label {
            font-weight: 600;
            font-size: 14px;
        }
        
        .sort-select {
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 14px;
            outline: none;
            cursor: pointer;
        }
        
        .sort-select:focus {
            border-color: var(--primary-blue);
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .product-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
            position: relative;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        
        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--yellow);
            color: #212121;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            z-index: 1;
        }
        
        .wishlist-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 35px;
            height: 35px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.3s;
            z-index: 10;
            border: none;
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
        
        .product-image-container {
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: #f5f5f5;
        }
        
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.05);
        }
        
        .product-details {
            padding: 15px;
        }
        
        .product-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            line-height: 1.4;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            color: #212121;
            text-decoration: none;
        }
        
        .product-brand {
            color: var(--dark-gray);
            font-size: 13px;
            margin-bottom: 8px;
        }
        
        .product-price {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            flex-wrap: wrap;
        }
        
        .current-price {
            font-size: 16px;
            font-weight: 600;
            color: #212121;
        }
        
        .original-price {
            font-size: 13px;
            color: var(--dark-gray);
            text-decoration: line-through;
        }
        
        .discount {
            color: var(--success-green);
            font-weight: 600;
            font-size: 12px;
        }
        
        .stock-info {
            font-size: 12px;
            margin-bottom: 10px;
        }
        
        .in-stock {
            color: var(--success-green);
        }
        
        .low-stock {
            color: var(--primary-orange);
        }
        
        .out-of-stock {
            color: #f44336;
        }
        
        .add-to-cart-btn {
            width: 100%;
            padding: 10px;
            background: var(--primary-orange);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.3s;
        }
        
        .add-to-cart-btn:hover:not(:disabled) {
            background: #e55a17;
        }
        
        .add-to-cart-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
        }
        
        .page-link {
            padding: 8px 15px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            color: #212121;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .page-link:hover {
            background: var(--light-gray);
        }
        
        .page-link.active {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }
        
        .page-link.disabled {
            opacity: 0.5;
            pointer-events: none;
        }
        
        /* No Results */
        .no-results {
            text-align: center;
            padding: 50px;
        }
        
        .no-results i {
            font-size: 80px;
            color: var(--dark-gray);
            margin-bottom: 20px;
        }
        
        .no-results h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .no-results p {
            color: var(--dark-gray);
            margin-bottom: 20px;
        }
        
        /* Loading */
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
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
            
            .filter-sidebar {
                margin-bottom: 20px;
            }
            
            .results-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<!-- Include Header -->
<jsp:include page="userHeader.jsp" />

<div class="loading-spinner" id="loadingSpinner">
    <div class="spinner"></div>
</div>

<div class="toast-container" id="toastContainer"></div>

<div class="products-container">
    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="/" class="text-decoration-none">Home</a>
        <i class="fas fa-chevron-right mx-2" style="font-size: 12px; color: #666;"></i>
        <c:choose>
            <c:when test="${not empty categoryName}">
                <span class="text-muted">${categoryName}</span>
            </c:when>
            <c:when test="${not empty searchQuery}">
                <span class="text-muted">Search Results for "${searchQuery}"</span>
            </c:when>
            <c:otherwise>
                <span class="text-muted">All Products</span>
            </c:otherwise>
        </c:choose>
    </nav>
    
    <div class="row">
        <!-- Filter Sidebar -->
        <div class="col-lg-3">
            <div class="filter-sidebar">
                <div class="filter-header">
                    <i class="fas fa-filter me-2"></i>Filters
                </div>
                
                <!-- Category Filter -->
                <div class="filter-section">
                    <div class="filter-section-title">Categories</div>
                    <div class="category-filter-list">
                        <div class="category-filter-item">
                            <a href="/products" class="category-filter-link ${empty param.category ? 'active' : ''}">
                                All Categories
                            </a>
                        </div>
                        <c:forEach var="cat" items="${categories}">
                            <div class="category-filter-item">
                                <a href="/products?category=${cat.categoryId}" 
                                   class="category-filter-link ${param.category == cat.categoryId ? 'active' : ''}">
                                    ${cat.categoryName}
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Brand Filter -->
                <div class="filter-section">
                    <div class="filter-section-title">Brands</div>
                    <div id="brandFilter">
                        <c:forEach var="brandItem" items="${brands}" varStatus="loop">
                            <c:if test="${loop.index < 5}">
                                <label class="brand-checkbox">
                                    <input type="checkbox" name="brand" value="${brandItem}" 
                                           ${param.brand == brandItem ? 'checked' : ''}>
                                    ${brandItem}
                                </label>
                            </c:if>
                        </c:forEach>
                        <c:if test="${fn:length(brands) > 5}">
                            <a href="#" class="text-primary" style="font-size: 13px;" onclick="showAllBrands()">
                                + ${fn:length(brands) - 5} more
                            </a>
                        </c:if>
                    </div>
                </div>
                
                <!-- Price Range Filter -->
                <div class="filter-section">
                    <div class="filter-section-title">Price Range</div>
                    <div class="price-range">
                        <div class="price-slider" id="priceSlider"></div>
                        <div class="price-inputs">
                            <input type="number" class="price-input" id="minPrice" 
                                   placeholder="Min" value="${param.minPrice != null ? param.minPrice : minProductPrice}">
                            <input type="number" class="price-input" id="maxPrice" 
                                   placeholder="Max" value="${param.maxPrice != null ? param.maxPrice : maxProductPrice}">
                        </div>
                    </div>
                </div>
                
                <!-- Stock Filter -->
                <div class="filter-section">
                    <div class="filter-section-title">Availability</div>
                    <label class="brand-checkbox">
                        <input type="checkbox" id="inStockOnly" ${param.inStock == 'true' ? 'checked' : ''}>
                        In Stock Only
                    </label>
                </div>
                
                <button class="apply-filter-btn" onclick="applyFilters()">
                    <i class="fas fa-check me-2"></i>Apply Filters
                </button>
                
                <button class="apply-filter-btn" style="background: #f44336; margin-top: 10px;" onclick="clearFilters()">
                    <i class="fas fa-times me-2"></i>Clear All
                </button>
            </div>
        </div>
        
        <!-- Products Main -->
        <div class="col-lg-9">
            <div class="products-main">
                <div class="results-header">
                    <div class="results-count">
                        <strong>${totalItems}</strong> products found
                        <c:if test="${not empty searchQuery}">
                            for "<strong>${searchQuery}</strong>"
                        </c:if>
                    </div>
                    
                    <div class="sort-section">
                        <span class="sort-label"><i class="fas fa-sort-amount-down me-2"></i>Sort By:</span>
                        <select class="sort-select" id="sortSelect">
                            <option value="default" ${sort == 'default' ? 'selected' : ''}>Featured</option>
                            <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Newest First</option>
                            <option value="popular" ${sort == 'popular' ? 'selected' : ''}>Popularity</option>
                            <option value="name_asc" ${sort == 'name_asc' ? 'selected' : ''}>Name: A to Z</option>
                            <option value="name_desc" ${sort == 'name_desc' ? 'selected' : ''}>Name: Z to A</option>
                            <option value="price_low" ${sort == 'price_low' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_high" ${sort == 'price_high' ? 'selected' : ''}>Price: High to Low</option>
                        </select>
                    </div>
                </div>
                
                <!-- Products Grid -->
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="no-results">
                            <i class="fas fa-search"></i>
                            <h3>No Products Found</h3>
                            <p>We couldn't find any products matching your criteria.</p>
                            <a href="/products" class="btn btn-primary">View All Products</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="products-grid" id="productsGrid">
                            <c:forEach var="product" items="${products}">
                                <c:set var="discountPercent" value="0"/>
                                <c:if test="${product.mrp > product.price}">
                                    <fmt:parseNumber var="discount" integerOnly="true" 
                                                     value="${(product.mrp - product.price) / product.mrp * 100}"/>
                                    <c:set var="discountPercent" value="${discount}"/>
                                </c:if>
                                
                                <div class="product-card" onclick="viewProduct(${product.productId})">
                                    <c:if test="${discountPercent > 20}">
                                        <div class="product-badge">${discountPercent}% OFF</div>
                                    </c:if>
                                    
                                    <button class="wishlist-btn ${wishlistedIds.contains(product.productId) ? 'active' : ''}" 
                                            onclick="event.stopPropagation(); toggleWishlist(${product.productId}, this)">
                                        <i class="fa${wishlistedIds.contains(product.productId) ? 's' : 'r'} fa-heart"></i>
                                    </button>
                                    
                                    <div class="product-image-container">
                                        <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/200'}" 
                                             class="product-image" alt="${product.productName}">
                                    </div>
                                    
                                    <div class="product-details">
                                        <h6 class="product-title">${product.productName}</h6>
                                        <p class="product-brand">${product.brand != null ? product.brand : 'EntityKart'}</p>
                                        
                                        <div class="product-price">
                                            <span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                                            <c:if test="${product.mrp > product.price}">
                                                <span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0"/></span>
                                                <span class="discount">${discountPercent}% off</span>
                                            </c:if>
                                        </div>
                                        
                                        <div class="stock-info">
                                            <c:choose>
                                                <c:when test="${product.stockQuantity > 10}">
                                                    <span class="in-stock"><i class="fas fa-check-circle"></i> In Stock</span>
                                                </c:when>
                                                <c:when test="${product.stockQuantity > 0}">
                                                    <span class="low-stock"><i class="fas fa-exclamation-circle"></i> Only ${product.stockQuantity} left</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <button class="add-to-cart-btn" onclick="event.stopPropagation(); addToCart(${product.productId})"
                                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                                            <i class="fas fa-cart-plus"></i>
                                            ${product.stockQuantity > 0 ? 'Add to Cart' : 'Out of Stock'}
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="javascript:void(0)" onclick="changePage(${currentPage - 1})" class="page-link">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </c:if>
                                
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                        <a href="javascript:void(0)" onclick="changePage(${i})" 
                                           class="page-link ${i == currentPage ? 'active' : ''}">
                                            ${i}
                                        </a>
                                    </c:if>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <a href="javascript:void(0)" onclick="changePage(${currentPage + 1})" class="page-link">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Include Footer -->
<jsp:include page="userFooter.jsp" />

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    // ========== GLOBAL VARIABLES ==========
    const minProductPrice = ${minProductPrice};
    const maxProductPrice = ${maxProductPrice};
    const currentMinPrice = ${param.minPrice != null ? param.minPrice : minProductPrice};
    const currentMaxPrice = ${param.maxPrice != null ? param.maxPrice : maxProductPrice};
    
    // ========== PRICE SLIDER ==========
    const priceSlider = document.getElementById('priceSlider');
    
    if (priceSlider) {
        noUiSlider.create(priceSlider, {
            start: [currentMinPrice, currentMaxPrice],
            connect: true,
            step: 100,
            range: {
                'min': minProductPrice,
                'max': maxProductPrice
            },
            format: {
                to: function(value) {
                    return Math.round(value);
                },
                from: function(value) {
                    return Number(value);
                }
            }
        });
        
        priceSlider.noUiSlider.on('update', function(values, handle) {
            document.getElementById('minPrice').value = values[0];
            document.getElementById('maxPrice').value = values[1];
        });
    }
    
    // ========== FILTER FUNCTIONS ==========
    function applyFilters() {
        const url = new URL(window.location.href);
        const params = new URLSearchParams(url.search);
        
        // Get selected brands
        const selectedBrands = [];
        document.querySelectorAll('input[name="brand"]:checked').forEach(cb => {
            selectedBrands.push(cb.value);
        });
        
        if (selectedBrands.length > 0) {
            params.set('brand', selectedBrands[0]); // For now, take first brand
        } else {
            params.delete('brand');
        }
        
        // Get price range
        const minPrice = document.getElementById('minPrice').value;
        const maxPrice = document.getElementById('maxPrice').value;
        
        if (minPrice && minPrice > minProductPrice) {
            params.set('minPrice', minPrice);
        } else {
            params.delete('minPrice');
        }
        
        if (maxPrice && maxPrice < maxProductPrice) {
            params.set('maxPrice', maxPrice);
        } else {
            params.delete('maxPrice');
        }
        
        // Get stock filter
        const inStockOnly = document.getElementById('inStockOnly').checked;
        if (inStockOnly) {
            params.set('inStock', 'true');
        } else {
            params.delete('inStock');
        }
        
        // Reset to first page
        params.set('page', '1');
        
        window.location.href = url.pathname + '?' + params.toString();
    }
    
    function clearFilters() {
        window.location.href = '/products';
    }
    
    function showAllBrands() {
        // Implementation to show all brands
        alert('Show all brands functionality - would expand the list');
    }
    
    // ========== SORT FUNCTION ==========
    document.getElementById('sortSelect')?.addEventListener('change', function() {
        const url = new URL(window.location.href);
        const params = new URLSearchParams(url.search);
        
        params.set('sort', this.value);
        params.set('page', '1');
        
        window.location.href = url.pathname + '?' + params.toString();
    });
    
    // ========== PAGINATION ==========
    function changePage(page) {
        const url = new URL(window.location.href);
        const params = new URLSearchParams(url.search);
        
        params.set('page', page);
        
        window.location.href = url.pathname + '?' + params.toString();
    }
    
    // ========== PRODUCT FUNCTIONS ==========
    function viewProduct(productId) {
        window.location.href = '/product/' + productId;
    }
    
    function addToCart(productId) {
        <% if (session.getAttribute("user") != null) { %>
            showLoading();
            
            axios.post('/cart/add', null, { params: { productId: productId, quantity: 1 } })
                .then(response => {
                    hideLoading();
                    if (response.data && response.data.success) {
                        showToast('success', 'Product added to cart!');
                        if (response.data.cartCount !== undefined) {
                            document.getElementById('cartCount').textContent = response.data.cartCount;
                        }
                    }
                })
                .catch(error => {
                    hideLoading();
                    console.error('Error:', error);
                    if (error.response && error.response.status === 401) {
                        showToast('info', 'Please login to add items to cart');
                        setTimeout(() => window.location.href = '/login', 2000);
                    } else {
                        showToast('error', 'Failed to add product to cart');
                    }
                });
        <% } else { %>
            showToast('info', 'Please login to add items to cart');
            setTimeout(() => window.location.href = '/login', 2000);
        <% } %>
    }
    
    function toggleWishlist(productId, element) {
        <% if (session.getAttribute("user") != null) { %>
            const $btn = $(element);
            const wasActive = $btn.hasClass('active');
            
            // Optimistic UI update
            $btn.toggleClass('active');
            $btn.find('i').toggleClass('far fas');
            
            axios.post('/api/wishlist/toggle', null, { params: { productId: productId } })
                .then(response => {
                    const data = response.data;
                    if (!data.success) {
                        // Revert if failed
                        $btn.toggleClass('active', wasActive);
                        $btn.find('i').toggleClass('far fas', !wasActive);
                        showToast('error', data.message || 'Failed to update wishlist');
                    } else {
                        showToast('success', data.inWishlist ? 'Added to wishlist!' : 'Removed from wishlist!');
                    }
                })
                .catch(error => {
                    // Revert on error
                    $btn.toggleClass('active', wasActive);
                    $btn.find('i').toggleClass('far fas', !wasActive);
                    console.error('Error:', error);
                    showToast('error', 'Failed to update wishlist');
                });
        <% } else { %>
            showToast('info', 'Please login to use wishlist');
            setTimeout(() => window.location.href = '/login', 2000);
        <% } %>
    }
    
    // ========== UTILITY FUNCTIONS ==========
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
        
        const toast = `
            <div id="${toastId}" class="toast-notification ${type}">
                <div class="toast-icon"><i class="fas ${icons[type]}"></i></div>
                <div class="toast-content">
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
</script>

</body>
</html>