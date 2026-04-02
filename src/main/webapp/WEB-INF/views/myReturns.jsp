<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-undo-alt me-2"></i>My Return Requests</h2>
                <a href="/orders" class="btn btn-outline-primary">
                    <i class="fas fa-box me-2"></i>My Orders
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
            
            <c:if test="${empty returns}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/5996/5996831.png" 
                         alt="No Returns" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">No Return Requests</h4>
                    <p class="text-muted">You haven't requested any returns yet.</p>
                    <a href="/orders" class="btn btn-primary mt-2">
                        <i class="fas fa-box me-2"></i>View Orders
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty returns}">
                <div class="row">
                    <c:forEach var="item" items="${returns}">
                        <c:set var="returnReq" value="${item.returnReq}" />
                        <c:set var="order" value="${item.order}" />
                        <c:set var="product" value="${item.product}" />
                        <c:set var="orderItem" value="${item.orderItem}" />
                        
                        <div class="col-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>Return #${returnReq.returnId}</strong>
                                        <span class="text-muted ms-3">
                                            <i class="fas fa-calendar me-1"></i>
                                            Requested: 
                                            <%-- Use the formatted string method instead of fmt:formatDate --%>
                                            ${returnReq.formattedRequestedAt}
                                        </span>
                                    </div>
                                    <div>
                                        <c:choose>
                                            <c:when test="${returnReq.returnStatus == 'REQUESTED'}">
                                                <span class="badge bg-warning">PENDING</span>
                                            </c:when>
                                            <c:when test="${returnReq.returnStatus == 'APPROVED'}">
                                                <span class="badge bg-success">APPROVED</span>
                                            </c:when>
                                            <c:when test="${returnReq.returnStatus == 'REJECTED'}">
                                                <span class="badge bg-danger">REJECTED</span>
                                            </c:when>
                                            <c:when test="${returnReq.returnStatus == 'REFUNDED'}">
                                                <span class="badge bg-info">REFUNDED</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/100'}" 
                                                 class="img-fluid rounded" alt="${product.productName}">
                                        </div>
                                        <div class="col-md-7">
                                            <h6>${product.productName}</h6>
                                            <p class="mb-1"><strong>Order #:</strong> ${order.orderId}</p>
                                            <p class="mb-1"><strong>Reason:</strong> ${returnReq.reason}</p>
                                            <p class="mb-1"><strong>Quantity:</strong> ${orderItem.quantity}</p>
                                            <p class="mb-0"><strong>Amount:</strong> 
                                                <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price * orderItem.quantity}" pattern="#,##0.00"/>
                                            </p>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <c:if test="${returnReq.returnStatus == 'REQUESTED'}">
                                                <a href="/return/cancel/${returnReq.returnId}" 
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Are you sure you want to cancel this return request?')">
                                                    <i class="fas fa-times-circle me-1"></i>Cancel Request
                                                </a>
                                            </c:if>
                                            <c:if test="${returnReq.returnStatus == 'APPROVED'}">
                                                <span class="text-success">
                                                    <i class="fas fa-check-circle"></i> Return Approved
                                                </span>
                                            </c:if>
                                            <c:if test="${returnReq.returnStatus == 'REJECTED'}">
                                                <span class="text-danger">
                                                    <i class="fas fa-times-circle"></i> Return Rejected
                                                </span>
                                            </c:if>
                                            <c:if test="${returnReq.returnStatus == 'REFUNDED'}">
                                                <span class="text-info">
                                                    <i class="fas fa-rupee-sign"></i> Refund Processed
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${returnReq.processedAt != null}">
                                    <div class="card-footer text-muted small">
                                        Processed on: ${returnReq.formattedProcessedAt}
                                    </div>
                                </c:if>
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
    .badge {
        font-size: 11px;
        padding: 5px 8px;
    }
</style>

<%@ include file="footer.jsp" %>