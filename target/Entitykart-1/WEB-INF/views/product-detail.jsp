<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - EntityKart</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Lightbox CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/css/lightbox.min.css">
    
    <style>
        /* All your existing styles remain exactly the same */
        :root {
            --primary-blue: #2874f0;
            --primary-orange: #fb641b;
            --light-gray: #f1f3f6;
            --dark-gray: #878787;
            --white: #ffffff;
            --success-green: #26a541;
            --yellow: #ff9f00;
            --pink: #ff3f6c;
        }
        
        body {
            background-color: #f1f3f6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Breadcrumb */
        .breadcrumb-container {
            background: white;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .breadcrumb {
            margin: 0;
            background: none;
            font-size: 14px;
        }

        .breadcrumb a {
            color: var(--dark-gray);
            text-decoration: none;
        }

        .breadcrumb a:hover {
            color: var(--primary-blue);
        }

        /* Product Gallery */
        .product-gallery {
            background: white;
            padding: 20px;
            border-radius: 4px;
        }

        .main-image {
            width: 100%;
            height: 400px;
            object-fit: contain;
            cursor: zoom-in;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
        }

        .thumbnail-container {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            overflow-x: auto;
            padding: 5px;
        }

        .thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 4px;
        }

        .thumbnail.active {
            border-color: var(--primary-blue);
        }

        /* Product Info */
        .product-info {
            background: white;
            padding: 20px;
            border-radius: 4px;
        }

        .product-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 10px 0;
        }

        .rating-badge {
            background: var(--success-green);
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            font-weight: 600;
        }

        .rating-stars {
            color: var(--yellow);
        }

        .price-section {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
        }

        .current-price {
            font-size: 32px;
            font-weight: 600;
            color: #212121;
        }

        .original-price {
            font-size: 18px;
            color: var(--dark-gray);
            text-decoration: line-through;
            margin-left: 15px;
        }

        .discount {
            font-size: 20px;
            color: var(--success-green);
            margin-left: 15px;
        }

        .offers-section {
            background: #f0f7ff;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
        }

        .offer-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .offer-item i {
            color: var(--primary-blue);
        }

        /* Quantity Selector */
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 20px 0;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 4px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quantity-btn:hover:not(:disabled) {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }

        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        /* Delivery Section */
        .delivery-section {
            background: white;
            padding: 20px;
            border-radius: 4px;
            margin-top: 20px;
        }

        .pincode-input {
            width: 200px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .check-btn {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin: 20px 0;
        }

        .btn-add-to-cart {
            flex: 2;
            background: var(--primary-orange);
            color: white;
            border: none;
            padding: 15px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-add-to-cart:hover:not(:disabled) {
            background: #e55a17;
        }

        .btn-add-to-cart:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-buy-now {
            flex: 1;
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 15px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-buy-now:hover:not(:disabled) {
            background: #1e5fd8;
        }

        .btn-buy-now:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-wishlist {
            width: 50px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            color: #212121;
            transition: all 0.3s;
        }

        .btn-wishlist.active {
            background: var(--pink);
            color: white;
            border-color: var(--pink);
        }

        /* Product Details Tabs */
        .product-tabs {
            background: white;
            margin-top: 30px;
            border-radius: 4px;
            padding: 20px;
        }

        .nav-tabs .nav-link {
            color: #212121;
            font-weight: 500;
        }

        .nav-tabs .nav-link.active {
            color: var(--primary-blue);
            border-bottom: 2px solid var(--primary-blue);
        }

        /* Reviews Section */
        .review-card {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .review-rating {
            color: var(--yellow);
        }

        .review-date {
            color: var(--dark-gray);
            font-size: 12px;
        }

        /* Similar Products */
        .similar-products {
            margin-top: 30px;
        }

        .similar-card {
            background: white;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .similar-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .similar-card img {
            width: 100%;
            height: 150px;
            object-fit: contain;
        }

        /* Recently Viewed */
        .recently-viewed {
            background: white;
            margin-top: 30px;
            padding: 20px;
            border-radius: 4px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-image {
                height: 300px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-wishlist {
                width: 100%;
                height: 50px;
            }
        }
    </style>
</head>
<body>
    <!-- Header (same as index.jsp) -->
    <jsp:include page="userHeader.jsp" />

    <!-- Breadcrumb -->
    <div class="breadcrumb-container">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                    <li class="breadcrumb-item"><a href="/products">Products</a></li>
                    <c:if test="${not empty categoryName}">
                        <li class="breadcrumb-item"><a href="/products?category=${product.categoryId}">${categoryName}</a></li>
                    </c:if>
                    <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container mt-4">
        <div class="row">
            <!-- Product Gallery -->
            <div class="col-md-5">
                <div class="product-gallery">
                    <a href="${product.mainImageURL}" data-lightbox="product-gallery" data-title="${product.productName}">
                        <img src="${product.mainImageURL}" id="mainProductImage" class="main-image" alt="${product.productName}">
                    </a>
                    
                    <div class="thumbnail-container">
                        <c:forEach var="image" items="${productImages}">
                            <img src="${image.imageURL}" class="thumbnail ${image.primary ? 'active' : ''}" 
                                 onclick="changeMainImage('${image.imageURL}')" alt="Product thumbnail">
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-md-7">
                <div class="product-info">
                    <h1 class="product-title">${product.productName}</h1>
                    
                    <!-- Brand -->
                    <p class="text-muted">
                        Brand: <strong>${product.brand}</strong>
                    </p>

                    <!-- Rating -->
                    <div class="product-rating">
                        <span class="rating-badge">${avgRating} ★</span>
                        <span class="rating-stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:set var="avgRatingNum" value="${empty avgRating ? 0 : (avgRating.getClass().name eq 'java.lang.String' ? Double.parseDouble(avgRating) : avgRating)}" />
                                <c:if test="${i <= avgRatingNum}">
                                    <i class="fas fa-star"></i>
                                </c:if>
                                <c:if test="${i > avgRatingNum && (i - avgRatingNum) > 0.5}">
                                    <i class="far fa-star"></i>
                                </c:if>
                                <c:if test="${i > avgRatingNum && (i - avgRatingNum) <= 0.5 && (i - avgRatingNum) > 0}">
                                    <i class="fas fa-star-half-alt"></i>
                                </c:if>
                            </c:forEach>
                        </span>
                        <span class="text-muted">${totalReviews} Ratings & Reviews</span>
                    </div>

                    <!-- Price -->
                    <div class="price-section">
                        <span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                        <c:if test="${product.mrp > product.price}">
                            <span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0.00"/></span>
                            <span class="discount">
                                <c:set var="discountPercent" value="${(product.mrp - product.price) / product.mrp * 100}" />
                                <fmt:formatNumber value="${discountPercent}" pattern="#0"/>% off
                            </span>
                        </c:if>
                    </div>

                    <!-- Quantity Selector - FIXED: Added quantity input with id="quantity" -->
                    <div class="quantity-selector">
                        <span class="fw-bold me-3">Quantity:</span>
                        <button class="quantity-btn" onclick="updateQuantity(-1)" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>-</button>
                        <input type="number" class="quantity-input" id="quantity" 
                               value="1" min="1" max="${product.stockQuantity}" 
                               ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                        <button class="quantity-btn" onclick="updateQuantity(1)" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>+</button>
                        <span class="ms-3 text-muted">${product.stockQuantity} items available</span>
                    </div>

                    <!-- Offers -->
                    <div class="offers-section">
                        <h5><i class="fas fa-tag me-2"></i>Available Offers</h5>
                        <div class="offer-item">
                            <i class="fas fa-bolt"></i>
                            <span>Bank Offer: 10% instant discount on HDFC Bank Credit Card</span>
                        </div>
                        <div class="offer-item">
                            <i class="fas fa-bolt"></i>
                            <span>No Cost EMI on credit card purchases</span>
                        </div>
                        <div class="offer-item">
                            <i class="fas fa-bolt"></i>
                            <span>Get ₹100 cashback on UPI payments</span>
                        </div>
                    </div>

                    <!-- Delivery -->
                    <div class="delivery-section">
                        <h5><i class="fas fa-truck me-2"></i>Delivery Options</h5>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <input type="text" class="pincode-input" id="pincode" placeholder="Enter pincode" maxlength="6">
                                <button class="check-btn ms-2" onclick="checkDelivery()">Check</button>
                            </div>
                            <div class="col-md-6">
                                <div id="deliveryMessage">
                                    <span class="text-muted">Enter pincode to check availability</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <p><i class="fas fa-check-circle text-success me-2"></i>Free Delivery</p>
                            <p><i class="fas fa-undo me-2 text-primary"></i>30 Days Return Policy</p>
                            <p><i class="fas fa-shield-alt me-2 text-warning"></i>1 Year Warranty</p>
                        </div>
                    </div>

                    <!-- Stock Status -->
                    <div class="mt-3">
                        <c:choose>
                            <c:when test="${product.stockQuantity > 10}">
                                <span class="text-success"><i class="fas fa-check-circle"></i> In Stock (${product.stockQuantity}+)</span>
                            </c:when>
                            <c:when test="${product.stockQuantity > 0 && product.stockQuantity <= 10}">
                                <span class="text-warning"><i class="fas fa-exclamation-triangle"></i> Only ${product.stockQuantity} left in stock</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger"><i class="fas fa-times-circle"></i> Out of Stock</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="btn-add-to-cart" onclick="addToCart()" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-cart-plus me-2"></i>Add to Cart
                        </button>
                        <button class="btn-buy-now" onclick="buyNow()" 
                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-bolt me-2"></i>Buy Now
                        </button>
                        <button class="btn-wishlist ${inWishlist ? 'active' : ''}" 
                                onclick="toggleWishlist(${product.productId}, this)">
                            <i class="fa${inWishlist ? 's' : 'r'} fa-heart"></i>
                        </button>
                    </div>

                    <!-- Highlights -->
                    <div class="mt-3">
                        <h6><i class="fas fa-check-circle text-success me-2"></i>Highlights</h6>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-check me-2 text-success"></i>Brand Warranty</li>
                            <li><i class="fas fa-check me-2 text-success"></i>Secure Payment</li>
                            <li><i class="fas fa-check me-2 text-success"></i>Easy Returns</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Details Tabs -->
        <div class="product-tabs">
            <ul class="nav nav-tabs" id="productTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="description-tab" data-bs-toggle="tab" 
                            data-bs-target="#description" type="button" role="tab">
                        <i class="fas fa-info-circle me-2"></i>Description
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="specifications-tab" data-bs-toggle="tab" 
                            data-bs-target="#specifications" type="button" role="tab">
                        <i class="fas fa-list me-2"></i>Specifications
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" 
                            data-bs-target="#reviews" type="button" role="tab">
                        <i class="fas fa-star me-2"></i>Reviews (${totalReviews})
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="faq-tab" data-bs-toggle="tab" 
                            data-bs-target="#faq" type="button" role="tab">
                        <i class="fas fa-question-circle me-2"></i>FAQs
                    </button>
                </li>
            </ul>

            <div class="tab-content mt-3">
                <!-- Description Tab -->
                <div class="tab-pane fade show active" id="description" role="tabpanel">
                    <h5>Product Description</h5>
                    <p>${product.description}</p>
                </div>

                <!-- Specifications Tab -->
                <div class="tab-pane fade" id="specifications" role="tabpanel">
                    <h5>Specifications</h5>
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 200px;">Brand</th>
                            <td>${product.brand}</td>
                        </tr>
                        <tr>
                            <th>Model</th>
                            <td>${product.sku}</td>
                        </tr>
                        <tr>
                            <th>Category</th>
                            <td>${categoryName}</td>
                        </tr>
                        <tr>
                            <th>Sub Category</th>
                            <td>${subCategoryName}</td>
                        </tr>
                        <tr>
                            <th>Stock Available</th>
                            <td>${product.stockQuantity}</td>
                        </tr>
                    </table>
                </div>

                <!-- Reviews Tab -->
                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="text-center">
                                <h1 class="display-4 text-warning">${avgRating}</h1>
                                <div class="mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:if test="${i <= avgRatingNum}">
                                            <i class="fas fa-star text-warning fa-2x"></i>
                                        </c:if>
                                        <c:if test="${i > avgRatingNum && (i - avgRatingNum) > 0.5}">
                                            <i class="far fa-star text-warning fa-2x"></i>
                                        </c:if>
                                        <c:if test="${i > avgRatingNum && (i - avgRatingNum) <= 0.5 && (i - avgRatingNum) > 0}">
                                            <i class="fas fa-star-half-alt text-warning fa-2x"></i>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <p class="lead">${totalReviews} Reviews</p>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <c:forEach var="entry" items="${ratingDistribution}">
                                <div class="row align-items-center mb-2">
                                    <div class="col-md-2">${entry.key} ★</div>
                                    <div class="col-md-8">
                                        <div class="progress">
                                            <div class="progress-bar bg-warning" role="progressbar" 
                                                 style="width: ${totalReviews > 0 ? (entry.value * 100 / totalReviews) : 0}%"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-2">${entry.value}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <hr>

                    <!-- Customer Reviews -->
                    <div class="reviews-list mt-4">
                        <c:forEach var="review" items="${reviews}">
                            <div class="review-card">
                                <div class="d-flex justify-content-between">
                                    <h6>${review.customerName}</h6>
                                    <span class="review-date">${review.formattedDate}</span>
                                </div>
                                <div class="review-rating mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:if test="${i <= review.rating}">
                                            <i class="fas fa-star"></i>
                                        </c:if>
                                        <c:if test="${i > review.rating}">
                                            <i class="far fa-star"></i>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <p>${review.comment}</p>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Write Review Button -->
                    <c:if test="${not empty sessionScope.user}">
                        <div class="text-center mt-4">
                            <a href="/review/write/${product.productId}" class="btn btn-primary">
                                <i class="fas fa-pen me-2"></i>Write a Review
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- FAQ Tab -->
                <div class="tab-pane fade" id="faq" role="tabpanel">
                    <div class="accordion" id="faqAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#faq1">
                                    Is this product genuine?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    Yes, all products on EntityKart are 100% genuine and come with brand warranty.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#faq2">
                                    What is the return policy?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    You can return the product within 30 days of delivery for a full refund.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Frequently Bought Together -->
        <c:if test="${not empty frequentlyBought}">
            <div class="similar-products">
                <h3 class="mb-3">Frequently Bought Together</h3>
                <div class="row">
                    <c:forEach var="freqProduct" items="${frequentlyBought}">
                        <div class="col-md-3">
                            <div class="similar-card" onclick="window.location='/product/${freqProduct.productId}'">
                                <img src="${freqProduct.mainImageURL}" alt="${freqProduct.productName}">
                                <h6 class="mt-2">${freqProduct.productName}</h6>
                                <span class="product-price">₹<fmt:formatNumber value="${freqProduct.price}" pattern="#,##0"/></span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Similar Products -->
        <c:if test="${not empty relatedProducts}">
            <div class="similar-products">
                <h3 class="mb-3">Similar Products</h3>
                <div class="row">
                    <c:forEach var="similarProduct" items="${relatedProducts}">
                        <div class="col-md-3">
                            <div class="similar-card" onclick="window.location='/product/${similarProduct.productId}'">
                                <img src="${similarProduct.mainImageURL}" alt="${similarProduct.productName}">
                                <h6 class="mt-2">${similarProduct.productName}</h6>
                                <span class="product-price">₹<fmt:formatNumber value="${similarProduct.price}" pattern="#,##0"/></span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Recently Viewed -->
        <c:if test="${not empty recentlyViewed}">
            <div class="recently-viewed">
                <h3 class="mb-3">Recently Viewed</h3>
                <div class="row">
                    <c:forEach var="recentProduct" items="${recentlyViewed}">
                        <div class="col-md-2">
                            <div class="similar-card" onclick="window.location='/product/${recentProduct.productId}'">
                                <img src="${recentProduct.mainImageURL}" alt="${recentProduct.productName}" style="height: 100px;">
                                <h6 class="mt-2 small">${recentProduct.productName}</h6>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Footer -->
    <jsp:include page="userFooter.jsp" />

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/js/lightbox.min.js"></script>

    <script>
        // Change main image on thumbnail click
        function changeMainImage(imageUrl) {
            document.getElementById('mainProductImage').src = imageUrl;
            
            // Update active thumbnail
            document.querySelectorAll('.thumbnail').forEach(thumb => {
                thumb.classList.remove('active');
                if (thumb.src === imageUrl) {
                    thumb.classList.add('active');
                }
            });
        }

        // Quantity selector
        function updateQuantity(change) {
            const input = document.getElementById('quantity');
            let value = parseInt(input.value) + change;
            const min = 1;
            const max = ${product.stockQuantity};
            
            if (value < min) value = min;
            if (value > max) value = max;
            
            input.value = value;
        }

        // FIXED: Add to cart function with proper quantity handling
        function addToCart() {
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    const quantityInput = document.getElementById('quantity');
                    let quantity = 1;
                    
                    if (quantityInput) {
                        quantity = parseInt(quantityInput.value);
                        if (isNaN(quantity) || quantity < 1) {
                            quantity = 1;
                        }
                    }
                    
                    window.location.href = '/cart/add?productId=${product.productId}&quantity=' + quantity;
                </c:when>
                <c:otherwise>
                    alert('Please login to add items to cart');
                    window.location.href = '/login?redirect=/product/${product.productId}';
                </c:otherwise>
            </c:choose>
        }

        // FIXED: Buy now function with proper quantity handling
        function buyNow() {
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    const quantityInput = document.getElementById('quantity');
                    let quantity = 1;
                    
                    if (quantityInput) {
                        quantity = parseInt(quantityInput.value);
                        if (isNaN(quantity) || quantity < 1) {
                            quantity = 1;
                        }
                    }
                    
                    window.location.href = '/checkout?productId=${product.productId}&quantity=' + quantity;
                </c:when>
                <c:otherwise>
                    alert('Please login to place order');
                    window.location.href = '/login?redirect=/checkout?productId=${product.productId}';
                </c:otherwise>
            </c:choose>
        }

        // Toggle wishlist
        function toggleWishlist(productId, element) {
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    fetch('/api/wishlist/toggle', {
                        method: 'POST',
                        headers: { 
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'productId=' + productId
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            if (data.inWishlist) {
                                element.classList.add('active');
                                element.innerHTML = '<i class="fas fa-heart"></i>';
                                showToast('success', 'Added to wishlist!');
                            } else {
                                element.classList.remove('active');
                                element.innerHTML = '<i class="far fa-heart"></i>';
                                showToast('info', 'Removed from wishlist!');
                            }
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showToast('error', 'Failed to update wishlist');
                    });
                </c:when>
                <c:otherwise>
                    showToast('info', 'Please login to use wishlist');
                    setTimeout(() => window.location.href = '/login?redirect=/product/' + productId, 2000);
                </c:otherwise>
            </c:choose>
        }

        // Check delivery
        function checkDelivery() {
            const pincode = document.getElementById('pincode').value;
            if (pincode.length !== 6 || isNaN(pincode)) {
                showToast('error', 'Please enter a valid 6-digit pincode');
                return;
            }

            fetch('/check-delivery?pincode=' + pincode)
                .then(response => response.json())
                .then(data => {
                    const message = document.getElementById('deliveryMessage');
                    if (data.available) {
                        message.innerHTML = '<span class="text-success"><i class="fas fa-check-circle"></i> ' + 
                            data.message + '</span>';
                    } else {
                        message.innerHTML = '<span class="text-danger"><i class="fas fa-times-circle"></i> ' + 
                            data.message + '</span>';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('error', 'Failed to check delivery');
                });
        }

        // Toast notification function
        function showToast(type, message) {
            // You can implement a toast notification system here
            // For now, use alert
            alert(message);
        }
    </script>
</body>
</html>