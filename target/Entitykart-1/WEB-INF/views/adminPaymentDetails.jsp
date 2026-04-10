<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-credit-card me-2 text-primary"></i>Payment Details</h2>
                <div>
                    <a href="/admin/payments" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to Payments
                    </a>
                    <button class="btn btn-outline-primary" onclick="window.print()">
                        <i class="fas fa-print me-2"></i>Print
                    </button>
                </div>
            </div>
            
            <c:if test="${empty payment}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Payment not found or invalid payment ID.
                </div>
            </c:if>
            
            <c:if test="${not empty payment}">
                <div class="row">
                    <!-- Payment Information -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-info-circle me-2 text-primary"></i>
                                    Payment Information
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <th style="width: 150px;">Payment ID:</th>
                                        <td><span class="fw-bold">#${payment.paymentId}</span></td>
                                    </tr>
                                    <tr>
                                        <th>Order ID:</th>
                                        <td>
                                            <a href="/admin/order/details?orderId=${payment.orderId}" class="text-decoration-none">
                                                #${payment.orderId} <i class="fas fa-external-link-alt fa-sm"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Customer ID:</th>
                                        <td>#${order.customerId}</td>
                                    </tr>
                                    <tr>
                                        <th>Amount:</th>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                                    </tr>
                                    <tr>
                                        <th>Payment Method:</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${payment.paymentMode == 'CARD'}">
                                                    <span class="badge bg-info"><i class="fas fa-credit-card me-1"></i>Credit/Debit Card</span>
                                                </c:when>
                                                <c:when test="${payment.paymentMode == 'UPI'}">
                                                    <span class="badge bg-info"><i class="fas fa-mobile-alt me-1"></i>UPI</span>
                                                </c:when>
                                                <c:when test="${payment.paymentMode == 'NET_BANKING'}">
                                                    <span class="badge bg-info"><i class="fas fa-university me-1"></i>Net Banking</span>
                                                </c:when>
                                                <c:when test="${payment.paymentMode == 'WALLET'}">
                                                    <span class="badge bg-info"><i class="fas fa-wallet me-1"></i>Wallet</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-info">${payment.paymentMode}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Transaction Reference:</th>
                                        <td><code>${payment.transactionRef}</code></td>
                                    </tr>
                                    <tr>
                                        <th>Payment Status:</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${payment.paymentStatus == 'SUCCESS'}">
                                                    <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>SUCCESS</span>
                                                </c:when>
                                                <c:when test="${payment.paymentStatus == 'FAILED'}">
                                                    <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>FAILED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning"><i class="fas fa-clock me-1"></i>PENDING</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Payment Date:</th>
                                        <td>
                                           <c:if test="${payment.paymentDate != null}">
    											<i class="fas fa-calendar-alt me-1 text-muted"></i>
    												<small class="text-muted"><fmt:formatDate value="${payment.paymentDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
											</c:if>
                                            <c:if test="${payment.paymentDate == null}">
                                                <span class="text-muted">Not processed yet</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Created At:</th>
                                        <td><i class="fas fa-clock me-1 text-muted"></i><small class="text-muted"><fmt:formatDate value="${payment.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small></td>
                                    </tr>
                                    <tr>
                                        <th>Last Updated:</th>
                                        <td><i class="fas fa-sync-alt me-1 text-muted"></i><small class="text-muted"><fmt:formatDate value="${payment.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Information -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-shopping-cart me-2 text-primary"></i>
                                    Order Information
                                </h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty order}">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th style="width: 150px;">Order Status:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 'DELIVERED'}">
                                                        <span class="badge bg-success">DELIVERED</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'CANCELLED'}">
                                                        <span class="badge bg-danger">CANCELLED</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'RETURNED'}">
                                                        <span class="badge bg-info">RETURNED</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'SHIPPED'}">
                                                        <span class="badge bg-primary">SHIPPED</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'CONFIRMED'}">
                                                        <span class="badge bg-warning">CONFIRMED</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.orderStatus}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Order Date:</th>
											<td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                        </tr>
                                        <tr>
                                            <th>Total Amount:</th>
                                            <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                        </tr>
                                        <tr>
                                            <th>Delivery Address:</th>
											<td>
    											<c:if test="${not empty address}">
        												${address.addressLine1}, 
        												${address.city}, ${address.state} - ${address.pincode}
    											</c:if>
											</td>
                                        </tr>
                                    </table>
                                </c:if>
                                <c:if test="${empty order}">
                                    <div class="alert alert-warning mb-0">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        Order details not available
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- Payment Timeline -->
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-history me-2 text-primary"></i>
                                    Payment Timeline
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <!-- Payment Created -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-primary"></div>
                                        <div class="timeline-content">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-1 fw-bold">Payment Initiated</h6>
                                                <small class="text-muted"><fmt:formatDate value="${payment.paymentDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                            </div>
                                            <p class="mb-0 text-muted small">Payment record created in system</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Payment Processed -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker 
                                            ${payment.paymentStatus == 'SUCCESS' ? 'bg-success' : 
                                              payment.paymentStatus == 'FAILED' ? 'bg-danger' : 
                                              payment.paymentStatus == 'PENDING' ? 'bg-warning' : 'bg-secondary'}">
                                        </div>
                                        <div class="timeline-content">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-1 fw-bold">
                                                    Payment 
                                                    <c:choose>
                                                        <c:when test="${payment.paymentStatus == 'SUCCESS'}">Completed</c:when>
                                                        <c:when test="${payment.paymentStatus == 'FAILED'}">Failed</c:when>
                                                        <c:otherwise>Processing</c:otherwise>
                                                    </c:choose>
                                                </h6>
                                                <c:if test="${payment.paymentDate != null}">
                                                    <small class="text-muted"><fmt:formatDate value="${payment.paymentDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                                </c:if>
                                            </div>
                                            <p class="mb-0 text-muted small">
                                                <c:choose>
                                                    <c:when test="${payment.paymentStatus == 'SUCCESS'}">
                                                        Payment successful via ${payment.paymentMode}
                                                    </c:when>
                                                    <c:when test="${payment.paymentStatus == 'FAILED'}">
                                                        Payment failed. Transaction ref: ${payment.transactionRef}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Waiting for payment confirmation
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                    
                                    <!-- Last Updated -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-secondary"></div>
                                        <div class="timeline-content">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-1 fw-bold">Last Updated</h6>
                                                <small class="text-muted"><fmt:formatDate value="${payment.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                            </div>
                                            <p class="mb-0 text-muted small">Payment record last modified</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="mt-3 text-end">
                            <c:if test="${payment.paymentStatus == 'FAILED'}">
                                <button class="btn btn-warning" onclick="retryPayment(${payment.paymentId})">
                                    <i class="fas fa-redo-alt me-2"></i>Retry Payment
                                </button>
                            </c:if>
                            <c:if test="${payment.paymentStatus == 'SUCCESS' && order.orderStatus != 'DELIVERED'}">
    							<form action="/admin/order/update-status" method="post" style="display: inline;">
        							<input type="hidden" name="orderId" value="${payment.orderId}">
        							<input type="hidden" name="orderStatus" value="DELIVERED">
        							<button type="submit" class="btn btn-success">
            							<i class="fas fa-truck me-2"></i>Mark as Delivered
        							</button>
    							</form>
							</c:if>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<style>
    .timeline {
        position: relative;
        padding: 10px 0;
    }
    
    .timeline-item {
        position: relative;
        padding-left: 40px;
        padding-bottom: 25px;
    }
    
    .timeline-item:last-child {
        padding-bottom: 0;
    }
    
    .timeline-item::before {
        content: '';
        position: absolute;
        left: 13px;
        top: 24px;
        bottom: 0;
        width: 2px;
        background: linear-gradient(to bottom, #e9ecef 0%, #dee2e6 100%);
    }
    
    .timeline-item:last-child::before {
        display: none;
    }
    
    .timeline-marker {
        position: absolute;
        left: 0;
        top: 0;
        width: 28px;
        height: 28px;
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        z-index: 1;
    }
    
    .timeline-marker.bg-primary { background: var(--primary-blue); }
    .timeline-marker.bg-success { background: #28a745; }
    .timeline-marker.bg-danger { background: #dc3545; }
    .timeline-marker.bg-warning { background: #ffc107; }
    .timeline-marker.bg-secondary { background: #6c757d; }
    
    .timeline-content {
        background: #f8f9fa;
        padding: 12px 15px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    
    .timeline-content:hover {
        background: #e9ecef;
        transform: translateX(5px);
    }
    
    @media print {
        .sidebar, .header, .btn, .nav-tabs, .card-header {
            display: none !important;
        }
        .timeline-content {
            background: none !important;
        }
    }
</style>

<script>
    function retryPayment(paymentId) {
        if (confirm('Are you sure you want to retry this payment?')) {
            window.location.href = '/admin/payment/retry/' + paymentId;
        }
    }
</script>

<%@ include file="footer.jsp" %>