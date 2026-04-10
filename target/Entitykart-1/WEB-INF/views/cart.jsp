<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
 
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-shopping-cart me-2"></i> Shopping Cart</h2>
                <a href="/index" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i> Continue Shopping
                </a>
            </div>
 
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
 
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>
 
            <c:if test="${empty cartItems}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png"
                         alt="Empty Cart" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">Your cart is empty</h4>
                    <p class="text-muted">Looks like you haven't added any items to your cart yet.</p>
                    <a href="/listProduct" class="btn btn-primary mt-2">
                        <i class="fas fa-shopping-bag me-2"></i> Start Shopping
                    </a>
                </div>
            </c:if>
 
            <c:if test="${not empty cartItems}">
                <div class="row">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Cart Items (${itemCount})</h5>
                                <a href="/cart/clear" class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to clear your cart?')">
                                    <i class="fas fa-trash me-1"></i> Clear Cart
                                </a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 100px">Product</th>
                                                <th>Details</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Total</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${cartItems}">
                                                <c:set var="cart" value="${item.cart}" />
                                                <c:set var="subtotal" value="${cart.price * cart.quantity}" />
                                                <tr id="cart-row-${cart.cartId}">
                                                    <td>
                                                        <img src="${item.productImage != null ? item.productImage : 'https://via.placeholder.com/80'}"
                                                             width="80" height="80" class="rounded"
                                                             alt="${item.productName}" style="object-fit: cover;">
                                                    </td>
                                                    <td>
                                                        <h6 class="mb-1">${item.productName}</h6>
                                                        <small class="text-muted">Product ID: #${cart.productId}</small>
                                                        <c:if test="${cart.quantity > item.stockQuantity}">
                                                            <br><span class="badge bg-danger mt-1">Stock: ${item.stockQuantity}</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${cart.price}" pattern="#,##0.00"/>
                                                    </td>
                                                    <td style="width: 150px">
                                                        <div class="input-group input-group-sm">
                                                            <button class="btn btn-outline-secondary" type="button"
                                                                    onclick="updateQuantity(${cart.cartId}, ${cart.quantity - 1})"
                                                                    ${cart.quantity <= 1 ? 'disabled' : ''}>
                                                                <i class="fas fa-minus"></i>
                                                            </button>
                                                            <input type="text" class="form-control text-center"
                                                                   id="qty-${cart.cartId}" value="${cart.quantity}"
                                                                   readonly style="width: 50px;">
                                                            <button class="btn btn-outline-secondary" type="button"
                                                                    onclick="updateQuantity(${cart.cartId}, ${cart.quantity + 1})"
                                                                    ${cart.quantity >= item.stockQuantity ? 'disabled' : ''}>
                                                                <i class="fas fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <strong><i class="fas fa-rupee-sign"></i> <span id="subtotal-${cart.cartId}"><fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span></strong>
                                                    </td>
                                                    <td>
                                                        <a href="/cart/remove?cartId=${cart.cartId}"
                                                           class="btn btn-sm btn-outline-danger"
                                                           onclick="return confirm('Remove this item from cart?')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
 
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="card sticky-top" style="top: 20px;">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Order Summary</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <td>Subtotal (${itemCount} items)</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <span id="summarySubtotal"><fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span></td>
                                    </tr>
                                    <tr>
                                        <td>Shipping</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <span id="summaryShipping"><fmt:formatNumber value="${shipping}" pattern="#,##0.00"/></span></td>
                                    </tr>
                                    <tr>
                                        <td>Tax (18% GST)</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <span id="summaryTax"><fmt:formatNumber value="${tax}" pattern="#,##0.00"/></span></td>
                                    </tr>
                                    <tr class="border-top">
                                        <th>Total</th>
                                        <th class="text-end"><i class="fas fa-rupee-sign"></i> <span id="summaryTotal"><fmt:formatNumber value="${total}" pattern="#,##0.00"/></span></th>
                                    </tr>
                                </table>
 
                                <div class="d-grid gap-2">
                                    <a href="/checkout" class="btn btn-primary btn-lg">
                                        <i class="fas fa-credit-card me-2"></i> Proceed to Checkout
                                    </a>
                                    <a href="/index" class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-2"></i> Continue Shopping
                                    </a>
                                </div>
 
                                <div class="mt-3 small text-muted text-center">
                                    <i class="fas fa-shield-alt me-1"></i> Secure checkout
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    function updateQuantity(cartId, newQuantity) {
        if (newQuantity < 1) return;
        fetch('/cart/update', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'cartId=' + cartId + '&quantity=' + newQuantity
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (data.deleted) {
                    document.getElementById('cart-row-' + cartId).remove();
                    updateCartCount();
                } else {
                    document.getElementById('qty-' + cartId).value = newQuantity;
                    document.getElementById('subtotal-' + cartId).textContent = 
                        new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(data.newSubtotal);
                }
                document.getElementById('summarySubtotal').textContent = 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(data.cartTotal);
                document.getElementById('summaryTax').textContent = 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(data.tax);
                document.getElementById('summaryTotal').textContent = 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(data.total);
                document.querySelectorAll('.cart-count').forEach(el => { el.textContent = data.itemCount; });
                if (data.itemCount == 0) location.reload();
            } else {
                alert(data.message);
            }
        });
    }
 
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    .table td {
        vertical-align: middle;
    }
    .sticky-top {
        z-index: 100;
    }
    @media (max-width: 768px) {
        .sticky-top {
            position: relative !important;
            top: 0 !important;
        }
    }
</style>

<%@ include file="footer.jsp" %>