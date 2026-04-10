<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-heart me-2 text-danger"></i>My Wishlist</h2>
                <div>
                    <a href="/index" class="btn btn-outline-primary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                    </a>
                    <c:if test="${totalItems > 0}">
                        <a href="/wishlist/clear" class="btn btn-outline-danger" 
                           onclick="return confirm('Are you sure you want to clear your wishlist?')">
                            <i class="fas fa-trash me-2"></i>Clear Wishlist
                        </a>
                    </c:if>
                </div>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>
            
            <!-- Wishlist Stats -->
            <c:if test="${totalItems > 0}">
                <div class="alert alert-info mb-4">
                    <i class="fas fa-info-circle me-2"></i>
                    You have <strong>${totalItems}</strong> item<c:if test="${totalItems > 1}">s</c:if> in your wishlist.
                </div>
            </c:if>
            
            <c:if test="${empty wishlistItems}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" 
                         alt="Empty Wishlist" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">Your wishlist is empty</h4>
                    <p class="text-muted">Save your favorite items to buy later.</p>
                    <a href="/listProduct" class="btn btn-primary mt-2">
                        <i class="fas fa-shopping-bag me-2"></i>Explore Products
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty wishlistItems}">
                <div class="row" id="wishlistContainer">
                    <c:forEach var="item" items="${wishlistItems}">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4 wishlist-item" data-id="${item.wishlistId}">
                            <div class="card h-100 product-card">
                                <div class="position-relative">
                                    <img src="${item.imageUrl != null ? item.imageUrl : 'https://via.placeholder.com/300'}" 
                                         class="card-img-top" alt="${item.productName}" 
                                         style="height: 200px; object-fit: cover;">
                                    
                                    <!-- Discount Badge -->
                                    <c:if test="${item.discountPercent > 0}">
                                        <div class="discount-badge">
                                            ${item.discountPercent}% OFF
                                        </div>
                                    </c:if>
                                    
                                    <!-- Remove Button -->
                                    <button class="btn-remove-wishlist" 
                                            onclick="removeFromWishlist(${item.wishlistId})"
                                            title="Remove from wishlist">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                                
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title">${item.productName}</h6>
                                    
                                    <!-- Price -->
                                    <div class="price-section mb-2">
                                        <c:if test="${item.discountedPrice != null}">
                                            <span class="current-price">
                                                <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${item.discountedPrice}" pattern="#,##0.00"/>
                                            </span>
                                            <span class="original-price ms-2">
                                                <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${item.discountedPrice == null}">
                                            <span class="current-price">
                                                <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/>
                                            </span>
                                        </c:if>
                                    </div>
                                    
                                    <!-- Stock Status -->
                                    <div class="stock-info mb-2">
                                        <c:if test="${item.inStock}">
                                            <span class="in-stock">
                                                <i class="fas fa-check-circle"></i> In Stock
                                            </span>
                                        </c:if>
                                        <c:if test="${!item.inStock}">
                                            <span class="out-of-stock">
                                                <i class="fas fa-times-circle"></i> Out of Stock
                                            </span>
                                        </c:if>
                                    </div>
                                    
                                    <!-- Added Date -->
                                    <small class="text-muted mb-2">
                                        <i class="fas fa-clock me-1"></i>Added: ${item.addedAt}
                                    </small>
                                    
                                    <!-- Action Buttons -->
                                    <div class="mt-auto">
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/product/${item.productId}" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-2"></i>View Details
                                            </a>
                                            
                                            <c:if test="${item.inStock}">
                                                <div class="btn-group">
                                                    <a href="/cart/add?productId=${item.productId}" 
                                                       class="btn btn-primary btn-sm">
                                                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                                    </a>
                                                    <a href="/wishlist/move-to-cart/${item.wishlistId}" 
                                                       class="btn btn-success btn-sm"
                                                       onclick="return confirm('Move this item to cart?')">
                                                        <i class="fas fa-arrow-right"></i>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="/wishlist?page=${currentPage-1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${totalPages-1}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="/wishlist?page=${i}">${i+1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="/wishlist?page=${currentPage+1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

<!-- Toast Container for Notifications -->
<div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3"></div>

<script>
    function removeFromWishlist(wishlistId) {
        if (confirm('Remove this item from wishlist?')) {
            fetch('/wishlist/remove/' + wishlistId, {
                method: 'GET'
            }).then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                }
            });
        }
    }
    
    function toggleWishlist(productId, element) {
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
                if (data.loginRequired) {
                    showToast('info', 'Please login to use wishlist');
                    setTimeout(() => {
                        window.location.href = '/login';
                    }, 2000);
                } else {
                    const icon = element.querySelector('i');
                    if (data.inWishlist) {
                        icon.className = 'fas fa-heart text-danger';
                        showToast('success', 'Added to wishlist!');
                    } else {
                        icon.className = 'far fa-heart';
                        showToast('info', 'Removed from wishlist!');
                    }
                    
                    // Update wishlist count in header if exists
                    const wishlistCount = document.getElementById('wishlistCount');
                    if (wishlistCount) {
                        wishlistCount.textContent = data.count;
                    }
                }
            } else {
                showToast('error', data.message || 'An error occurred');
            }
        });
    }
    
    function showToast(type, message) {
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast align-items-center text-white bg-' + type + ' border-0';
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');
        
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        `;
        
        toastContainer.appendChild(toast);
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
        
        setTimeout(() => {
            toast.remove();
        }, 3000);
    }
    
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    .product-card {
        transition: transform 0.2s, box-shadow 0.2s;
        position: relative;
    }
    
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    }
    
    .btn-remove-wishlist {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: white;
        border: none;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        transition: all 0.2s;
        cursor: pointer;
        z-index: 10;
    }
    
    .btn-remove-wishlist:hover {
        transform: scale(1.1);
        background: #f8f9fa;
    }
    
    .btn-remove-wishlist i {
        color: #dc3545;
        font-size: 18px;
    }
    
    .discount-badge {
        position: absolute;
        top: 10px;
        left: 10px;
        background: #dc3545;
        color: white;
        padding: 5px 10px;
        border-radius: 3px;
        font-size: 12px;
        font-weight: 600;
        z-index: 10;
    }
    
    .current-price {
        font-size: 18px;
        font-weight: bold;
        color: #212121;
    }
    
    .original-price {
        font-size: 14px;
        color: #878787;
        text-decoration: line-through;
    }
    
    .in-stock {
        color: #28a745;
        font-size: 13px;
    }
    
    .out-of-stock {
        color: #dc3545;
        font-size: 13px;
    }
    
    .btn-group {
        display: flex;
        gap: 5px;
    }
    
    .btn-group .btn {
        flex: 1;
    }
    
    .btn-group .btn:last-child {
        flex: 0 0 auto;
        width: 40px;
    }
    
    .toast-container {
        z-index: 9999;
    }
    
    .toast {
        min-width: 250px;
    }
    
    @media (max-width: 768px) {
        .product-card .card-img-top {
            height: 150px;
        }
        
        .btn-group {
            flex-direction: column;
        }
        
        .btn-group .btn:last-child {
            width: 100%;
        }
    }
</style>

<%@ include file="footer.jsp" %>