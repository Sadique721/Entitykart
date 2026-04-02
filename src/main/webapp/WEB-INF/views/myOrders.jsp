<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                                        <strong>Order #${s.count}</strong>
                                        <span class="text-muted ms-3">
                                            <i class="fas fa-calendar me-1"></i>
                                            <%-- Using the helper method getOrderDateAsDate() --%>
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
                                    <div class="row">
                                        <div class="col-md-8">
                                            <p><strong>Total Amount:</strong> 
                                                <span class="text-primary"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span>
                                            </p>
                                            <p><strong>Items:</strong> 
                                                <a href="/order/details?orderId=${order.orderId}" class="text-primary">
                                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                                </a>
                                            </p>
                                        </div>
                                        <div class="col-md-4 text-end">
                                            <a href="/order/details?orderId=${order.orderId}" class="btn btn-primary">
                                                <i class="fas fa-eye me-2"></i>View Details
                                            </a>
                                            <c:if test="${order.canBeCancelled()}">
                                                <a href="/order/cancel?orderId=${order.orderId}" 
                                                   class="btn btn-danger mt-2 mt-md-0 ms-md-2"
                                                   onclick="return confirm('Are you sure you want to cancel this order?')">
                                                    <i class="fas fa-times-circle me-2"></i>Cancel
                                                </a>
                                            </c:if>
                                        </div>
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
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
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
</style>

<%@ include file="footer.jsp" %>