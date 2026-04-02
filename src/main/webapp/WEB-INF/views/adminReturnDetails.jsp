<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-undo-alt me-2"></i>Return Request #${returnReq.returnId}</h2>
                <a href="/admin/returns" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Returns
                </a>
            </div>
            
            <!-- Status Update Section (for pending returns) -->
            <c:if test="${returnReq.returnStatus == 'REQUESTED'}">
                <div class="card mb-4 border-warning">
                    <div class="card-header bg-warning text-white">
                        <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Process Return Request</h5>
                    </div>
                    <div class="card-body">
                        <form action="/admin/return/process" method="post" class="row align-items-end">
                            <input type="hidden" name="returnId" value="${returnReq.returnId}">
                            <div class="col-md-4">
                                <label class="form-label">Action</label>
                                <select name="action" class="form-select" required>
                                    <option value="">Select action</option>
                                    <option value="APPROVE">Approve Return</option>
                                    <option value="REJECT">Reject Return</option>
                                    <option value="REFUND">Process Refund</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Admin Comments (Optional)</label>
                                <input type="text" name="adminComments" class="form-control" 
                                       placeholder="Add notes about this decision">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-save me-2"></i>Submit
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>
            
            <div class="row">
                <!-- Return Information -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">Return Information</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <th style="width: 150px;">Return ID:</th>
                                    <td>#${returnReq.returnId}</td>
                                </tr>
                                <tr>
                                    <th>Order Item ID:</th>
                                    <td>#${returnReq.orderItemId}</td>
                                </tr>
                                <tr>
                                    <th>Reason:</th>
                                    <td>${returnReq.reason}</td>
                                </tr>
                                <tr>
                                    <th>Status:</th>
                                    <td>
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
                                    </td>
                                </tr>
                                <tr>
                                    <th>Requested Date:</th>
                                    <td>${returnReq.formattedRequestedAtWithTime}</td>
                                </tr>
                                <c:if test="${returnReq.processedAt != null}">
                                    <tr>
                                        <th>Processed Date:</th>
                                        <td>${returnReq.formattedProcessedAt}</td>
                                    </tr>
                                </c:if>
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
                                        <th>Order ID:</th>
                                        <td>#${order.orderId}</td>
                                    </tr>
                                    <tr>
                                        <th>Customer ID:</th>
                                        <td>#${order.customerId}</td>
                                    </tr>
                                    <tr>
                                        <th>Order Date:</th>
                                        <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                    </tr>
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
                                        <th>Payment Status:</th>
                                        <td>
                                            <span class="badge ${order.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'}">
                                                ${order.paymentStatus}
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Product Details -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Product Details</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/200'}" 
                                 class="img-fluid rounded" alt="${product.productName}">
                        </div>
                        <div class="col-md-9">
                            <h5>${product.productName}</h5>
                            <p class="text-muted">Product ID: #${product.productId}</p>
                            <table class="table table-borderless">
                                <tr>
                                    <th style="width: 150px;">Quantity:</th>
                                    <td>${orderItem.quantity}</td>
                                </tr>
                                <tr>
                                    <th>Unit Price:</th>
                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price}" pattern="#,##0.00"/></td>
                                </tr>
                                <tr>
                                    <th>Total Amount:</th>
                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price * orderItem.quantity}" pattern="#,##0.00"/></td>
                                </tr>
                                <tr>
                                    <th>Brand:</th>
                                    <td>${product.brand}</td>
                                </tr>
                                <tr>
                                    <th>Category:</th>
                                    <td>
                                        <c:forEach var="cat" items="${categoryList}">
                                            <c:if test="${cat.categoryId == product.categoryId}">
                                                ${cat.categoryName}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Return Timeline -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Return Timeline</h5>
                </div>
                <div class="card-body">
                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-marker bg-primary"></div>
                            <div class="timeline-content">
                                <h6 class="mb-1">Return Requested</h6>
                                <small class="text-muted">${returnReq.formattedRequestedAtWithTime}</small>
                            </div>
                        </div>
                        
                        <c:if test="${returnReq.processedAt != null}">
                            <div class="timeline-item">
                                <div class="timeline-marker 
                                    ${returnReq.returnStatus == 'APPROVED' ? 'bg-success' : 
                                      returnReq.returnStatus == 'REJECTED' ? 'bg-danger' : 
                                      returnReq.returnStatus == 'REFUNDED' ? 'bg-info' : 'bg-warning'}">
                                </div>
                                <div class="timeline-content">
                                    <h6 class="mb-1">
                                        Request 
                                        <c:choose>
                                            <c:when test="${returnReq.returnStatus == 'APPROVED'}">Approved</c:when>
                                            <c:when test="${returnReq.returnStatus == 'REJECTED'}">Rejected</c:when>
                                            <c:when test="${returnReq.returnStatus == 'REFUNDED'}">Refunded</c:when>
                                            <c:otherwise>Processed</c:otherwise>
                                        </c:choose>
                                    </h6>
                                    <small class="text-muted">${returnReq.formattedProcessedAt}</small>
                                </div>
                            </div>
                        </c:if>
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
    
    .badge {
        font-size: 11px;
        padding: 5px 8px;
    }
    
    .table td {
        vertical-align: middle;
    }
</style>

<%@ include file="footer.jsp" %>