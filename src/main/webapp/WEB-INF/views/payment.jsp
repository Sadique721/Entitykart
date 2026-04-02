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
                <a href="/admin/payments" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Payments
                </a>
            </div>
            
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
                                    <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                </tr>
                                <tr>
                                    <th>Created At:</th>
                                    <td><fmt:formatDate value="${payment.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Order Information -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">Order Information</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty order}">
                                <table class="table table-borderless">
                                    <tr>
                                        <th>Order Status:</th>
                                        <td>
                                            <span class="badge 
                                                ${order.orderStatus == 'DELIVERED' ? 'bg-success' : 
                                                  order.orderStatus == 'CANCELLED' ? 'bg-danger' : 
                                                  order.orderStatus == 'RETURNED' ? 'bg-info' : 
                                                  order.orderStatus == 'SHIPPED' ? 'bg-primary' : 
                                                  order.orderStatus == 'CONFIRMED' ? 'bg-warning' : 'bg-secondary'}">
                                                ${order.orderStatus}
                                            </span>
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
                                </table>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Payment Timeline -->
                    <div class="card">
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
                </div>
            </div>
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