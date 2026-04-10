<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-box me-2"></i>My Orders</h2>
                <a href="/index" class="btn btn-outline-primary">
                    <i class="fas fa-shopping-bag me-2"></i>Continue Shopping
                </a>
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
            
            <c:if test="${empty orders}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" 
                         alt="No Orders" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">No orders yet</h4>
                    <p class="text-muted">Looks like you haven't placed any orders.</p>
                    <a href="/listProduct" class="btn btn-primary mt-2">
                        <i class="fas fa-shopping-bag me-2"></i>Start Shopping
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty orders}">
                <div class="row">
                    <c:forEach var="order" items="${orders}" varStatus="s">
                        <div class="col-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>Order #${order.orderId}</strong>
                                        <span class="text-muted ms-3">
                                            <i class="fas fa-calendar me-1"></i>
                                            <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                        </span>
                                    </div>
                                    <div>
                                        <span class="badge 
                                            ${order.orderStatus == 'DELIVERED' ? 'bg-success' : 
                                              order.orderStatus == 'CANCELLED' ? 'bg-danger' : 
                                              order.orderStatus == 'RETURNED' ? 'bg-info' : 
                                              order.orderStatus == 'SHIPPED' ? 'bg-primary' : 
                                              order.orderStatus == 'CONFIRMED' ? 'bg-warning' : 'bg-secondary'} me-2">
                                            ${order.orderStatus}
                                        </span>
                                        <span class="badge ${order.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'}">
                                            ${order.paymentStatus}
                                        </span>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <!-- Order Items Table with Images and Prices -->
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead>
                                                <tr>
                                                    <th>Product</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="orderDetails" value="${orderDetailsMap[order.orderId]}" />
                                                <c:if test="${empty orderDetails}">
                                                    <tr>
                                                        <td colspan="4" class="text-muted text-center">No items found</td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach var="item" items="${orderDetails}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${item.productImage != null ? item.productImage : 'https://via.placeholder.com/60'}" 
                                                                     alt="${item.productName}" 
                                                                     style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px; margin-right: 15px;">
                                                                <div>
                                                                    <strong>${item.productName}</strong>
                                                                    <div class="text-muted small">Product ID: ${item.productId}</div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>Rs<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                                        <td>${item.quantity}</td>
                                                        <td class="text-primary fw-bold">Rs<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr class="table-light">
                                                    <td colspan="3" class="text-end fw-bold">Total Amount:</td>
                                                    <td class="text-primary fw-bold">Rs<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                    
                                    <!-- Action Buttons -->
                                    <div class="text-end mt-3">
                                        <a href="/order/details?orderId=${order.orderId}" class="btn btn-primary">
                                            <i class="fas fa-eye me-2"></i>View Full Details
                                        </a>
                                        <c:if test="${order.canBeCancelled()}">
                                            <a href="/order/cancel?orderId=${order.orderId}" 
                                               class="btn btn-danger ms-2"
                                               onclick="return confirm('Are you sure you want to cancel this order?')">
                                                <i class="fas fa-times-circle me-2"></i>Cancel Order
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            try {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            } catch(e) {}
        });
    }, 5000);
</script>

<style>
    .card {
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .table tbody tr:hover {
        background-color: #f8f9fa;
    }
</style>

<%@ include file="footer.jsp" %>