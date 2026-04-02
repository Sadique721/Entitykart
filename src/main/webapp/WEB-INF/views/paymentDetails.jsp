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
                <a href="/order/details?orderId=${payment.orderId}" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Order
                </a>
            </div>
            
            <c:if test="${empty payment}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Payment not found.
                </div>
            </c:if>
            
            <c:if test="${not empty payment}">
                <div class="row">
                    <!-- Payment Information -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Payment Information</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <th style="width: 150px;">Payment ID:</th>
                                        <td>#${payment.paymentId}</td>
                                    </tr>
                                    <tr>
                                        <th>Order ID:</th>
                                        <td>#${payment.orderId}</td>
                                    </tr>
                                    <tr>
                                        <th>Amount:</th>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                                    </tr>
                                    <tr>
                                        <th>Payment Method:</th>
                                        <td>
                                            <span class="badge bg-info">${payment.paymentMode}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Transaction Reference:</th>
                                        <td>${payment.transactionRef}</td>
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
                                    <tr>
                                        <th>Payment Date:</th>
                                        <td>
                                            <c:if test="${payment.paymentDate != null}">
                                                <fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                            </c:if>
                                            <c:if test="${payment.paymentDate == null}">
                                                Not processed yet
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Created At:</th>
                                        <td><fmt:formatDate value="${payment.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Payment Timeline -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Payment Timeline</h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-marker ${payment.createdAt != null ? 'bg-success' : 'bg-secondary'}"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Payment Initiated</h6>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${payment.createdAt}" pattern="dd MMM yyyy, hh:mm a"/>
                                            </small>
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-item">
                                        <div class="timeline-marker ${payment.paymentStatus == 'SUCCESS' ? 'bg-success' : payment.paymentStatus == 'FAILED' ? 'bg-danger' : 'bg-warning'}"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">
                                                Payment 
                                                <c:choose>
                                                    <c:when test="${payment.paymentStatus == 'SUCCESS'}">Completed</c:when>
                                                    <c:when test="${payment.paymentStatus == 'FAILED'}">Failed</c:when>
                                                    <c:otherwise>Pending</c:otherwise>
                                                </c:choose>
                                            </h6>
                                            <c:if test="${payment.paymentDate != null}">
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                                </small>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Receipt -->
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Payment Receipt</h5>
                            </div>
                            <div class="card-body text-center">
                                <i class="fas fa-receipt fa-4x text-primary mb-3"></i>
                                <p class="mb-1"><strong>Transaction ID:</strong> ${payment.transactionRef}</p>
                                <p class="mb-1"><strong>Amount:</strong> <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></p>
                                <p class="mb-3"><strong>Date:</strong> <fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy"/></p>
                                <button class="btn btn-outline-primary" onclick="window.print()">
                                    <i class="fas fa-print me-2"></i>Print Receipt
                                </button>
                            </div>
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
        padding: 20px 0;
    }
    
    .timeline-item {
        position: relative;
        padding-left: 40px;
        margin-bottom: 30px;
    }
    
    .timeline-item:last-child {
        margin-bottom: 0;
    }
    
    .timeline-item::before {
        content: '';
        position: absolute;
        left: 10px;
        top: 0;
        bottom: -30px;
        width: 2px;
        background: #dee2e6;
    }
    
    .timeline-item:last-child::before {
        display: none;
    }
    
    .timeline-marker {
        position: absolute;
        left: 0;
        top: 0;
        width: 20px;
        height: 20px;
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        z-index: 1;
    }
    
    .timeline-content {
        padding-bottom: 10px;
    }
</style>

<%@ include file="footer.jsp" %>