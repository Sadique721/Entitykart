<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.grownited.entity.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>EntityKart Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
    <style>
        /* Your existing styles remain EXACTLY the same - only added mobile optimizations */
        :root {
            --primary-blue: #2874f0;
            --primary-orange: #fb641b;
            --light-gray: #f1f3f6;
            --dark-gray: #878787;
            --success-green: #26a541;
            --yellow: #ff9f00;
            --border-color: #e0e0e0;
        }
        body { background-color: var(--light-gray); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .products-container { max-width: 1400px; margin: 30px auto; padding: 0 20px; }
        .breadcrumb { background: white; padding: 10px 20px; border-radius: 4px; margin-bottom: 20px; }
        /* Filter Sidebar - Desktop */
        .filter-sidebar { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .filter-header { font-size: 18px; font-weight: 600; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid var(--border-color); }
        .filter-section { margin-bottom: 25px; }
        .filter-section-title { font-weight: 600; margin-bottom: 15px; font-size: 14px; }
        .category-filter-item { margin-bottom: 10px; }
        .category-filter-link { color: #212121; text-decoration: none; font-size: 14px; display: block; padding: 5px 0; transition: color 0.3s; }
        .category-filter-link:hover, .category-filter-link.active { color: var(--primary-blue); }
        .brand-checkbox { display: block; margin-bottom: 10px; }
        .brand-checkbox input { margin-right: 8px; }
        .price-range { padding: 0 10px; }
        .price-slider { margin: 20px 0; }
        .price-inputs { display: flex; gap: 10px; margin-top: 15px; }
        .price-input { flex: 1; padding: 8px; border: 1px solid var(--border-color); border-radius: 4px; font-size: 13px; }
        .apply-filter-btn { width: 100%; padding: 10px; background: var(--primary-blue); color: white; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; margin-top: 15px; }
        .apply-filter-btn:hover { background: #1e5fd8; }
        /* Products Main */
        .products-main { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .results-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--border-color); flex-wrap: wrap; gap: 15px; }
        .results-count { font-size: 14px; color: var(--dark-gray); }
        .sort-section { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        .sort-label { font-weight: 600; font-size: 14px; }
        .sort-select { padding: 8px 12px; border: 1px solid var(--border-color); border-radius: 4px; font-size: 14px; outline: none; cursor: pointer; }
        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .product-card { background: white; border: 1px solid var(--border-color); border-radius: 8px; overflow: hidden; transition: all 0.3s; cursor: pointer; position: relative; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.1); }
        .product-badge { position: absolute; top: 10px; left: 10px; background: var(--yellow); color: #212121; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; z-index: 1; }
        .wishlist-btn { position: absolute; top: 10px; right: 10px; width: 35px; height: 35px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s; z-index: 10; border: none; color: #999; }
        .wishlist-btn:hover, .wishlist-btn.active { background: #fff5f5; color: #f44336; }
        .product-image-container { width: 100%; height: 200px; overflow: hidden; background: #f5f5f5; }
        .product-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
        .product-card:hover .product-image { transform: scale(1.05); }
        .product-details { padding: 15px; }
        .product-title { font-size: 14px; font-weight: 500; margin-bottom: 8px; line-height: 1.4; height: 40px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; color: #212121; }
        .product-brand { color: var(--dark-gray); font-size: 13px; margin-bottom: 8px; }
        .product-price { display: flex; align-items: center; gap: 8px; margin-bottom: 8px; flex-wrap: wrap; }
        .current-price { font-size: 16px; font-weight: 600; color: #212121; }
        .original-price { font-size: 13px; color: var(--dark-gray); text-decoration: line-through; }
        .discount { color: var(--success-green); font-weight: 600; font-size: 12px; }
        .stock-info { font-size: 12px; margin-bottom: 10px; }
        .in-stock { color: var(--success-green); }
        .low-stock { color: var(--primary-orange); }
        .out-of-stock { color: #f44336; }
        .add-to-cart-btn { width: 100%; padding: 10px; background: var(--primary-orange); color: white; border: none; border-radius: 4px; font-weight: 600; font-size: 13px; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 8px; transition: background 0.3s; }
        .add-to-cart-btn:hover:not(:disabled) { background: #e55a17; }
        .add-to-cart-btn:disabled { opacity: 0.5; cursor: not-allowed; }
        .pagination { display: flex; justify-content: center; gap: 10px; margin-top: 30px; }
        .page-link { padding: 8px 15px; border: 1px solid var(--border-color); border-radius: 4px; color: #212121; text-decoration: none; transition: all 0.3s; }
        .page-link:hover { background: var(--light-gray); }
        .page-link.active { background: var(--primary-blue); color: white; border-color: var(--primary-blue); }
        .no-results { text-align: center; padding: 50px; }
        .loading-spinner { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(255,255,255,0.8); display: none; justify-content: center; align-items: center; z-index: 9999; }
        .spinner { width: 50px; height: 50px; border: 5px solid #f3f3f3; border-top: 5px solid var(--primary-blue); border-radius: 50%; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .toast-container { position: fixed; top: 20px; right: 20px; z-index: 9999; }
        .toast-notification { background: white; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); padding: 16px 24px; margin-bottom: 10px; display: flex; align-items: center; gap: 12px; animation: slideInRight 0.3s ease; max-width: 350px; border-left: 4px solid; }
        .toast-notification.success { border-left-color: var(--success-green); }
        .toast-notification.error { border-left-color: #f44336; }
        .toast-notification.info { border-left-color: var(--primary-blue); }
        @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        /* Mobile filter button */
        .filter-toggle-btn { display: none; margin-bottom: 15px; width: 100%; }
        @media (max-width: 991px) {
            .filter-toggle-btn { display: block; }
            .filter-sidebar.desktop-filter { display: none; }
        }
        @media (min-width: 992px) {
            .offcanvas { display: none !important; }
        }
        .offcanvas { max-width: 85%; }
        .offcanvas .filter-sidebar { box-shadow: none; padding: 0; }
        @media (max-width: 576px) {
            .products-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 12px; }
            .product-title { font-size: 12px; }
            .current-price { font-size: 14px; }
        }
    </style>
</head>
<body>
<jsp:include page="userHeader.jsp" />
<div class="loading-spinner" id="loadingSpinner"><div class="spinner"></div></div>
<div class="toast-container" id="toastContainer"></div>
<div class="products-container">
    <nav class="breadcrumb">
        <a href="/" class="text-decoration-none">Home</a> <i class="fas fa-chevron-right mx-2"></i>
        <c:choose><c:when test="${not empty categoryName}"><span class="text-muted">${categoryName}</span></c:when>
        <c:when test="${not empty searchQuery}"><span class="text-muted">Search Results for "${searchQuery}"</span></c:when>
        <c:otherwise><span class="text-muted">All Products</span></c:otherwise></c:choose>
    </nav>

    <!-- Mobile Filter Toggle Button -->
    <button class="btn btn-primary filter-toggle-btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#filterOffcanvas">
        <i class="fas fa-filter me-2"></i> Filter & Sort
    </button>

    <div class="row">
        <!-- Desktop Filter Sidebar (visible on large screens) -->
        <div class="col-lg-3 desktop-filter d-none d-lg-block">
            <div class="filter-sidebar">
                <div class="filter-header"><i class="fas fa-filter me-2"></i>Filters</div>
                <div class="filter-section"><div class="filter-section-title">Categories</div>
                    <div class="category-filter-list">
                        <div class="category-filter-item"><a href="/products" class="category-filter-link ${empty param.category ? 'active' : ''}">All Categories</a></div>
                        <c:forEach var="cat" items="${categories}"><div class="category-filter-item"><a href="/products?category=${cat.categoryId}" class="category-filter-link ${param.category == cat.categoryId ? 'active' : ''}">${cat.categoryName}</a></div></c:forEach>
                    </div>
                </div>
                <div class="filter-section"><div class="filter-section-title">Brands</div>
                    <div id="brandFilter"><c:forEach var="brandItem" items="${brands}" varStatus="loop"><c:if test="${loop.index < 5}"><label class="brand-checkbox"><input type="checkbox" name="brand" value="${brandItem}" ${param.brand == brandItem ? 'checked' : ''}> ${brandItem}</label></c:if></c:forEach>
                    <c:if test="${fn:length(brands) > 5}"><a href="#" class="text-primary" style="font-size: 13px;" onclick="showAllBrands()">+ ${fn:length(brands) - 5} more</a></c:if></div>
                </div>
                <div class="filter-section"><div class="filter-section-title">Price Range</div>
                    <div class="price-range"><div class="price-slider" id="priceSlider"></div>
                    <div class="price-inputs"><input type="number" class="price-input" id="minPrice" placeholder="Min" value="${param.minPrice != null ? param.minPrice : minProductPrice}">
                    <input type="number" class="price-input" id="maxPrice" placeholder="Max" value="${param.maxPrice != null ? param.maxPrice : maxProductPrice}"></div></div>
                </div>
                <div class="filter-section"><div class="filter-section-title">Availability</div><label class="brand-checkbox"><input type="checkbox" id="inStockOnly" ${param.inStock == 'true' ? 'checked' : ''}> In Stock Only</label></div>
                <button class="apply-filter-btn" onclick="applyFilters()"><i class="fas fa-check me-2"></i>Apply Filters</button>
                <button class="apply-filter-btn" style="background: #f44336; margin-top: 10px;" onclick="clearFilters()"><i class="fas fa-times me-2"></i>Clear All</button>
            </div>
        </div>

        <!-- Offcanvas for Mobile Filters -->
        <div class="offcanvas offcanvas-start" tabindex="-1" id="filterOffcanvas" aria-labelledby="filterOffcanvasLabel">
            <div class="offcanvas-header"><h5 class="offcanvas-title" id="filterOffcanvasLabel">Filters</h5><button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button></div>
            <div class="offcanvas-body">
                <div class="filter-sidebar">
                    <div class="filter-section"><div class="filter-section-title">Categories</div>
                        <div class="category-filter-list">
                            <div class="category-filter-item"><a href="/products" class="category-filter-link" onclick="closeOffcanvas()">All Categories</a></div>
                            <c:forEach var="cat" items="${categories}"><div class="category-filter-item"><a href="/products?category=${cat.categoryId}" class="category-filter-link" onclick="closeOffcanvas()">${cat.categoryName}</a></div></c:forEach>
                        </div>
                    </div>
                    <div class="filter-section"><div class="filter-section-title">Brands</div>
                        <div id="brandFilterMobile"><c:forEach var="brandItem" items="${brands}"><label class="brand-checkbox"><input type="checkbox" name="brandMobile" value="${brandItem}" ${param.brand == brandItem ? 'checked' : ''}> ${brandItem}</label></c:forEach></div>
                    </div>
                    <div class="filter-section"><div class="filter-section-title">Price Range</div>
                        <div class="price-range"><div class="price-slider-mobile" id="priceSliderMobile"></div>
                        <div class="price-inputs"><input type="number" class="price-input" id="minPriceMobile" placeholder="Min"><input type="number" class="price-input" id="maxPriceMobile" placeholder="Max"></div></div>
                    </div>
                    <div class="filter-section"><div class="filter-section-title">Availability</div><label class="brand-checkbox"><input type="checkbox" id="inStockOnlyMobile"> In Stock Only</label></div>
                    <button class="apply-filter-btn" onclick="applyFiltersMobile()"><i class="fas fa-check me-2"></i>Apply Filters</button>
                    <button class="apply-filter-btn" style="background: #f44336; margin-top: 10px;" onclick="clearFiltersMobile()"><i class="fas fa-times me-2"></i>Clear All</button>
                </div>
            </div>
        </div>

        <!-- Products Main -->
        <div class="col-lg-9">
            <div class="products-main">
                <div class="results-header">
                    <div class="results-count"><strong>${totalItems}</strong> products found <c:if test="${not empty searchQuery}"> for "<strong>${searchQuery}</strong>"</c:if></div>
                    <div class="sort-section"><span class="sort-label"><i class="fas fa-sort-amount-down me-2"></i>Sort By:</span>
                        <select class="sort-select" id="sortSelect">
                            <option value="default" ${sort == 'default' ? 'selected' : ''}>Featured</option>
                            <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Newest First</option>
                            <option value="popular" ${sort == 'popular' ? 'selected' : ''}>Popularity</option>
                            <option value="price_low" ${sort == 'price_low' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_high" ${sort == 'price_high' ? 'selected' : ''}>Price: High to Low</option>
                        </select>
                    </div>
                </div>
                <c:choose><c:when test="${empty products}"><div class="no-results"><i class="fas fa-search"></i><h3>No Products Found</h3><p>Try different filters.</p><a href="/products" class="btn btn-primary">View All Products</a></div></c:when>
                <c:otherwise><div class="products-grid" id="productsGrid"><c:forEach var="product" items="${products}"><c:set var="discountPercent" value="0"/><c:if test="${product.mrp > product.price}"><fmt:parseNumber var="discount" integerOnly="true" value="${(product.mrp - product.price) / product.mrp * 100}"/><c:set var="discountPercent" value="${discount}"/></c:if>
                    <div class="product-card" onclick="viewProduct(${product.productId})"><c:if test="${discountPercent > 20}"><div class="product-badge">${discountPercent}% OFF</div></c:if>
                        <button class="wishlist-btn ${wishlistedIds.contains(product.productId) ? 'active' : ''}" onclick="event.stopPropagation(); toggleWishlist(${product.productId}, this)"><i class="fa${wishlistedIds.contains(product.productId) ? 's' : 'r'} fa-heart"></i></button>
                        <div class="product-image-container"><img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/200'}" class="product-image" alt="${product.productName}"></div>
                        <div class="product-details"><h6 class="product-title">${product.productName}</h6><p class="product-brand">${product.brand != null ? product.brand : 'EntityKart'}</p>
                        <div class="product-price"><span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0"/></span><c:if test="${product.mrp > product.price}"><span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0"/></span><span class="discount">${discountPercent}% off</span></c:if></div>
                        <div class="stock-info"><c:choose><c:when test="${product.stockQuantity > 10}"><span class="in-stock"><i class="fas fa-check-circle"></i> In Stock</span></c:when><c:when test="${product.stockQuantity > 0}"><span class="low-stock"><i class="fas fa-exclamation-circle"></i> Only ${product.stockQuantity} left</span></c:when><c:otherwise><span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span></c:otherwise></c:choose></div>
                        <button class="add-to-cart-btn" onclick="event.stopPropagation(); addToCart(${product.productId})" ${product.stockQuantity <= 0 ? 'disabled' : ''}><i class="fas fa-cart-plus"></i> ${product.stockQuantity > 0 ? 'Add to Cart' : 'Out of Stock'}</button>
                    </div></div></c:forEach></div>
                    <c:if test="${totalPages > 1}"><div class="pagination"><c:if test="${currentPage > 1}"><a href="javascript:void(0)" onclick="changePage(${currentPage - 1})" class="page-link"><i class="fas fa-chevron-left"></i></a></c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i"><c:if test="${i >= currentPage - 2 && i <= currentPage + 2}"><a href="javascript:void(0)" onclick="changePage(${i})" class="page-link ${i == currentPage ? 'active' : ''}">${i}</a></c:if></c:forEach>
                    <c:if test="${currentPage < totalPages}"><a href="javascript:void(0)" onclick="changePage(${currentPage + 1})" class="page-link"><i class="fas fa-chevron-right"></i></a></c:if></div></c:if>
                </c:otherwise></c:choose>
            </div>
        </div>
    </div>
</div>
<jsp:include page="userFooter.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    // Global variables from JSP
    const minProductPrice = ${minProductPrice};
    const maxProductPrice = ${maxProductPrice};
    const currentMinPrice = ${param.minPrice != null ? param.minPrice : minProductPrice};
    const currentMaxPrice = ${param.maxPrice != null ? param.maxPrice : maxProductPrice};
    const isLoggedIn = <%= session.getAttribute("user") != null %>;

    // Desktop slider
    const priceSlider = document.getElementById('priceSlider');
    if(priceSlider) {
        noUiSlider.create(priceSlider, {
            start: [currentMinPrice, currentMaxPrice],
            connect: true,
            step: 100,
            range: { 'min': minProductPrice, 'max': maxProductPrice },
            format: { to: v => Math.round(v), from: v => Number(v) }
        });
        priceSlider.noUiSlider.on('update', function(values) {
            document.getElementById('minPrice').value = values[0];
            document.getElementById('maxPrice').value = values[1];
        });
    }

    // Mobile slider
    const priceSliderMobile = document.getElementById('priceSliderMobile');
    if(priceSliderMobile) {
        noUiSlider.create(priceSliderMobile, {
            start: [currentMinPrice, currentMaxPrice],
            connect: true,
            step: 100,
            range: { 'min': minProductPrice, 'max': maxProductPrice },
            format: { to: v => Math.round(v), from: v => Number(v) }
        });
        priceSliderMobile.noUiSlider.on('update', function(values) {
            document.getElementById('minPriceMobile').value = values[0];
            document.getElementById('maxPriceMobile').value = values[1];
        });
    }

    function applyFilters() { buildUrlAndRedirect(false); }
    function applyFiltersMobile() { buildUrlAndRedirect(true); }
    function buildUrlAndRedirect(isMobile) {
        const url = new URL(window.location.href);
        const params = new URLSearchParams(url.search);
        let selectedBrands = [];
        if(isMobile) {
            document.querySelectorAll('#brandFilterMobile input:checked').forEach(cb => selectedBrands.push(cb.value));
        } else {
            document.querySelectorAll('input[name="brand"]:checked').forEach(cb => selectedBrands.push(cb.value));
        }
        if(selectedBrands.length > 0) params.set('brand', selectedBrands[0]);
        else params.delete('brand');
        let minPrice = isMobile ? document.getElementById('minPriceMobile').value : document.getElementById('minPrice').value;
        let maxPrice = isMobile ? document.getElementById('maxPriceMobile').value : document.getElementById('maxPrice').value;
        if(minPrice && minPrice > minProductPrice) params.set('minPrice', minPrice);
        else params.delete('minPrice');
        if(maxPrice && maxPrice < maxProductPrice) params.set('maxPrice', maxPrice);
        else params.delete('maxPrice');
        let inStock = isMobile ? document.getElementById('inStockOnlyMobile').checked : document.getElementById('inStockOnly').checked;
        if(inStock) params.set('inStock', 'true');
        else params.delete('inStock');
        params.set('page', '1');
        window.location.href = url.pathname + '?' + params.toString();
    }
    function clearFilters() { window.location.href = '/products'; }
    function clearFiltersMobile() { window.location.href = '/products'; }
    function showAllBrands() { alert('All brands would be shown here'); }

    // Sort event
    var sortSelect = document.getElementById('sortSelect');
    if(sortSelect) {
        sortSelect.addEventListener('change', function() {
            const url = new URL(window.location.href);
            url.searchParams.set('sort', this.value);
            url.searchParams.set('page','1');
            window.location.href = url.pathname + '?' + url.searchParams.toString();
        });
    }

    function changePage(page) {
        const url = new URL(window.location.href);
        url.searchParams.set('page', page);
        window.location.href = url.pathname + '?' + url.searchParams.toString();
    }
    function viewProduct(productId) { window.location.href = '/product/' + productId; }

    // Add to cart
    function addToCart(productId) {
        if(isLoggedIn) {
            showLoading();
            axios.post('/cart/add', null, { params: { productId: productId, quantity: 1 } })
                .then(function(res) {
                    hideLoading();
                    showToast('success','Added to cart!');
                    updateCartCount();
                })
                .catch(function(err) {
                    hideLoading();
                    showToast('error','Failed to add to cart');
                });
        } else {
            showToast('info','Please login');
            setTimeout(function() { window.location.href = '/login'; }, 2000);
        }
    }

    // Toggle wishlist
    function toggleWishlist(productId, element) {
        if(isLoggedIn) {
            var $btn = $(element);
            var wasActive = $btn.hasClass('active');
            $btn.toggleClass('active');
            $btn.find('i').toggleClass('far fas');
            axios.post('/api/wishlist/toggle', null, { params: { productId: productId } })
                .then(function(res) {
                    if(!res.data.success) {
                        $btn.toggleClass('active', wasActive);
                        $btn.find('i').toggleClass('far fas', !wasActive);
                        showToast('error', res.data.message);
                    } else {
                        showToast('success', res.data.inWishlist ? 'Added to wishlist!' : 'Removed from wishlist!');
                    }
                })
                .catch(function() {
                    $btn.toggleClass('active', wasActive);
                    $btn.find('i').toggleClass('far fas', !wasActive);
                    showToast('error','Failed to update wishlist');
                });
        } else {
            showToast('info','Please login');
            setTimeout(function() { window.location.href = '/login'; }, 2000);
        }
    }

    function updateCartCount() {
        if(isLoggedIn) {
            axios.get('/cart/count').then(function(res) {
                var c = document.getElementById('cartCount');
                if(c) c.textContent = res.data.count || 0;
            }).catch(function() {});
        }
    }

    function showLoading() { document.getElementById('loadingSpinner').style.display = 'flex'; }
    function hideLoading() { document.getElementById('loadingSpinner').style.display = 'none'; }
    function showToast(type, message) {
        var id = 'toast-'+Date.now();
        var icon = '';
        if(type === 'success') icon = 'fa-check-circle';
        else if(type === 'error') icon = 'fa-exclamation-circle';
        else icon = 'fa-info-circle';
        var toast = '<div id="'+id+'" class="toast-notification '+type+'"><i class="fas '+icon+'"></i><div>'+message+'</div></div>';
        document.getElementById('toastContainer').insertAdjacentHTML('beforeend', toast);
        setTimeout(function() {
            var el = document.getElementById(id);
            if(el) el.remove();
        }, 3000);
    }
    function closeOffcanvas() {
        var offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('filterOffcanvas'));
        if(offcanvas) offcanvas.hide();
    }
</script>
</body>
</html>