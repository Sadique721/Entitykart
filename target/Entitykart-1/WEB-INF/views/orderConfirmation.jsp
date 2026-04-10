<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            
            <!-- Success Animation -->
            <div class="text-center mb-4">
                <div class="success-animation">
                    <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                        <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                        <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>
                </div>
                <h2 class="text-success mt-3">Order Placed Successfully!</h2>
                <p class="lead">Thank you for your purchase. Your order has been confirmed.</p>
            </div>
            
            <!-- Order Summary Card -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong>Order ID:</strong> #${order.orderId}</p>
                            <p><strong>Order Date:</strong> 
                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/>
                            </p>
                            <p><strong>Payment Method:</strong> ${payment.paymentMode}</p>
                        </div>
                        <div class="col-sm-6">
                            <p><strong>Order Status:</strong> 
                                <span class="badge bg-success">${order.orderStatus}</span>
                            </p>
                            <p><strong>Payment Status:</strong> 
                                <span class="badge ${order.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'}">
                                    ${order.paymentStatus}
                                </span>
                            </p>
                            <p><strong>Transaction ID:</strong> ${payment.transactionRef}</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Delivery Address -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-map-marker-alt me-2 text-primary"></i>Delivery Address</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty address}">
                        <p><strong>${address.fullName}</strong></p>
                        <p>${address.addressLine1}</p>
                        <p>${address.city}, ${address.state} - ${address.pincode}</p>
                        <p><i class="fas fa-phone me-2"></i>${address.mobileNo}</p>
                    </c:if>
                </div>
            </div>
            
            <!-- Order Items -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-box me-2 text-primary"></i>Order Items</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th class="text-end">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${orderDetails}">
                                    <c:set var="detail" value="${item[0]}" />
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${item[2] != null ? item[2] : 'https://via.placeholder.com/50'}" 
                                                     width="50" height="50" class="rounded me-3" style="object-fit: cover;">
                                                <div>
                                                    <h6 class="mb-0">${item[1]}</h6>
                                                    <small class="text-muted">#${detail.productId}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${detail.price}" pattern="#,##0.00"/></td>
                                        <td>${detail.quantity}</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Price Summary -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Price Details</h5>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr>
                            <td>Subtotal</td>
                            <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount - 40 - (order.totalAmount * 0.18 / 1.18)}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <td>Shipping</td>
                            <td class="text-end"><i class="fas fa-rupee-sign"></i> 40.00</td>
                        </tr>
                        <tr>
                            <td>Tax (18% GST)</td>
                            <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount * 0.18 / 1.18}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr class="border-top">
                            <th>Total Amount</th>
                            <th class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></th>
                        </tr>
                    </table>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="text-center mb-4">
                <a href="/orders" class="btn btn-primary">
                    <i class="fas fa-box me-2"></i>View My Orders
                </a>
                <a href="/index" class="btn btn-outline-primary ms-2">
                    <i class="fas fa-shopping-bag me-2"></i>Continue Shopping
                </a>
                <a href="/" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-home me-2"></i>Go to Home
                </a>
            </div>
            
            <!-- Email Confirmation Message -->
            <div class="alert alert-info text-center">
                <i class="fas fa-envelope me-2"></i>
                Order confirmation has been sent to your email address.
            </div>
            
        </div>
    </div>
</div>

<style>
    .success-animation {
        margin: 0 auto 20px;
        width: 100px;
        height: 100px;
    }
    
    .checkmark {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        display: block;
        stroke-width: 2;
        stroke: #4bb71b;
        stroke-miterlimit: 10;
        box-shadow: inset 0px 0px 0px #4bb71b;
        animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
    }
    
    .checkmark__circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 2;
        stroke-miterlimit: 10;
        stroke: #4bb71b;
        fill: #fff;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }
    
    .checkmark__check {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
    }
    
    @keyframes stroke {
        100% {
            stroke-dashoffset: 0;
        }
    }
    @keyframes scale {
        0%, 100% {
            transform: none;
        }
        50% {
            transform: scale3d(1.1, 1.1, 1);
        }
    }
    @keyframes fill {
        100% {
            box-shadow: inset 0px 0px 0px 30px #4bb71b;
        }
    }
    
    @media print {
        .btn, .alert-info {
            display: none !important;
        }
    }
</style>

<%@ include file="footer.jsp" %>