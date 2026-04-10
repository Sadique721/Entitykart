<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            
            <!-- Payment Status -->
            <div class="text-center mb-4">
                <c:choose>
                    <c:when test="${payment.paymentStatus == 'SUCCESS'}">
                        <div class="success-animation">
                            <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                                <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                                <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                            </svg>
                        </div>
                        <h2 class="text-success mt-3">Payment Successful!</h2>
                        <p class="lead">Your payment has been processed successfully.</p>
                    </c:when>
                    <c:when test="${payment.paymentStatus == 'FAILED'}">
                        <div class="error-animation">
                            <svg class="crossmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                                <circle class="crossmark__circle" cx="26" cy="26" r="25" fill="none"/>
                                <path class="crossmark__cross" fill="none" d="M16 16 L36 36 M36 16 L16 36"/>
                            </svg>
                        </div>
                        <h2 class="text-danger mt-3">Payment Failed!</h2>
                        <p class="lead">There was an issue processing your payment.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="pending-animation">
                            <i class="fas fa-clock fa-5x text-warning"></i>
                        </div>
                        <h2 class="text-warning mt-3">Payment Pending</h2>
                        <p class="lead">Your payment is being processed.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Payment Details -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Payment Details</h5>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr>
                            <th style="width: 200px;">Payment ID:</th>
                            <td>#${payment.paymentId}</td>
                        </tr>
                        <tr>
                            <th>Order ID:</th>
                            <td>#${order.orderId}</td>
                        </tr>
                        <tr>
                            <th>Amount Paid:</th>
                            <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <th>Payment Method:</th>
                            <td>${payment.paymentMode}</td>
                        </tr>
                        <tr>
                            <th>Transaction Reference:</th>
                            <td>${payment.transactionRef}</td>
                        </tr>
                        <tr>
                            <th>Payment Date:</th>
                            <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                        </tr>
                        <tr>
                            <th>Payment Status:</th>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.paymentStatus == 'SUCCESS'}">
                                        <span class="badge bg-success">SUCCESS</span>
                                    </c:when>
                                    <c:when test="${payment.paymentStatus == 'FAILED'}">
                                        <span class="badge bg-danger">FAILED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning">PENDING</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="text-center mb-4">
                <c:if test="${payment.paymentStatus == 'SUCCESS'}">
                    <a href="/order/details?orderId=${order.orderId}" class="btn btn-primary">
                        <i class="fas fa-eye me-2"></i>View Order
                    </a>
                </c:if>
                
                <c:if test="${payment.paymentStatus == 'FAILED'}">
                    <a href="/payment/retry/${order.orderId}" class="btn btn-warning">
                        <i class="fas fa-redo me-2"></i>Retry Payment
                    </a>
                </c:if>
                
                <a href="/orders" class="btn btn-outline-primary ms-2">
                    <i class="fas fa-box me-2"></i>My Orders
                </a>
                
                <a href="/" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-home me-2"></i>Home
                </a>
            </div>
            
            <!-- Email Confirmation -->
            <div class="alert alert-info text-center">
                <i class="fas fa-envelope me-2"></i>
                Payment receipt has been sent to your email address.
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
    
    .error-animation {
        margin: 0 auto 20px;
        width: 100px;
        height: 100px;
    }
    
    .pending-animation {
        margin: 0 auto 20px;
        width: 100px;
        height: 100px;
        display: flex;
        align-items: center;
        justify-content: center;
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
    
    .crossmark {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        display: block;
        stroke-width: 2;
        stroke: #dc3545;
        stroke-miterlimit: 10;
        box-shadow: inset 0px 0px 0px #dc3545;
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
    
    .crossmark__circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 2;
        stroke-miterlimit: 10;
        stroke: #dc3545;
        fill: #fff;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }
    
    .checkmark__check {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
    }
    
    .crossmark__cross {
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