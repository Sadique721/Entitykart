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
                <h2><i class="fas fa-box-open me-2"></i>Order Details</h2>
                <div>
                    <a href="/orders" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to Orders
                    </a>
                    <a href="/" class="btn btn-outline-primary">
                        <i class="fas fa-home me-2"></i>Home
                    </a>
                </div>
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
            
            <!-- Order Status Timeline -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="order-timeline">
                        <div class="timeline-step ${order.orderStatus == 'PLACED' || order.orderStatus == 'CONFIRMED' || order.orderStatus == 'SHIPPED' || order.orderStatus == 'DELIVERED' ? 'completed' : ''}">
                            <div class="timeline-icon">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="timeline-content">
                                <h6>Order Placed</h6>
                                <small><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                            </div>
                        </div>
                        
                        <div class="timeline-step ${order.orderStatus == 'CONFIRMED' || order.orderStatus == 'SHIPPED' || order.orderStatus == 'DELIVERED' ? 'completed' : ''}">
                            <div class="timeline-icon">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="timeline-content">
                                <h6>Confirmed</h6>
                                <c:if test="${order.orderStatus == 'CONFIRMED' || order.orderStatus == 'SHIPPED' || order.orderStatus == 'DELIVERED'}">
                                    <small><fmt:formatDate value="${order.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="timeline-step ${order.orderStatus == 'SHIPPED' || order.orderStatus == 'DELIVERED' ? 'completed' : ''}">
                            <div class="timeline-icon">
                                <i class="fas fa-truck"></i>
                            </div>
                            <div class="timeline-content">
                                <h6>Shipped</h6>
                                <c:if test="${order.orderStatus == 'SHIPPED' || order.orderStatus == 'DELIVERED'}">
                                    <small><fmt:formatDate value="${order.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="timeline-step ${order.orderStatus == 'DELIVERED' ? 'completed' : ''}">
                            <div class="timeline-icon">
                                <i class="fas fa-home"></i>
                            </div>
                            <div class="timeline-content">
                                <h6>Delivered</h6>
                                <c:if test="${order.orderStatus == 'DELIVERED'}">
                                    <small><fmt:formatDate value="${order.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                </c:if>
                            </div>
                        </div>
                        
                        <c:if test="${order.orderStatus == 'CANCELLED'}">
                            <div class="timeline-step cancelled">
                                <div class="timeline-icon bg-danger">
                                    <i class="fas fa-times"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="text-danger">Cancelled</h6>
                                    <small><fmt:formatDate value="${order.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${order.orderStatus == 'RETURNED'}">
                            <div class="timeline-step returned">
                                <div class="timeline-icon bg-info">
                                    <i class="fas fa-undo"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="text-info">Returned</h6>
                                    <small><fmt:formatDate value="${order.updatedAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></small>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <!-- Order Information -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Order Information</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <th style="width: 150px;">Order ID:</th>
                                    <td>#${order.orderId}</td>
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
                                <tr>
                                    <th>Total Amount:</th>
                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Delivery Address -->
                <div class="col-md-6">
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
                </div>
            </div>
            
            <!-- Order Items with Return Buttons -->
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
                                    <th>Return Status</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${orderDetails}" varStatus="status">
                                    <c:set var="detail" value="${item[0]}" />
                                    <c:set var="productName" value="${item[1]}" />
                                    <c:set var="productImage" value="${item[2]}" />
                                    <c:set var="returnRequest" value="${returnRequests[detail.orderItemId]}" />
                                    
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${productImage != null ? productImage : 'https://via.placeholder.com/60'}" 
                                                     width="60" height="60" class="rounded me-3" style="object-fit: cover;">
                                                <div>
                                                    <h6 class="mb-0">${productName}</h6>
                                                    <small class="text-muted">#${detail.productId}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${detail.price}" pattern="#,##0.00"/></td>
                                        <td>${detail.quantity}</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,##0.00"/></td>
                                        <td>
                                            <c:if test="${not empty returnRequest}">
                                                <c:choose>
                                                    <c:when test="${returnRequest.returnStatus == 'REQUESTED'}">
                                                        <span class="badge bg-warning">Return Requested</span>
                                                    </c:when>
                                                    <c:when test="${returnRequest.returnStatus == 'APPROVED'}">
                                                        <span class="badge bg-success">Return Approved</span>
                                                    </c:when>
                                                    <c:when test="${returnRequest.returnStatus == 'REJECTED'}">
                                                        <span class="badge bg-danger">Return Rejected</span>
                                                    </c:when>
                                                    <c:when test="${returnRequest.returnStatus == 'REFUNDED'}">
                                                        <span class="badge bg-info">Refunded</span>
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                        <td class="text-center">
                                            <!-- Show Return button only for DELIVERED orders and if no return request exists -->
                                            <c:if test="${order.orderStatus == 'DELIVERED' && empty returnRequest}">
                                                <a href="/return/request/${detail.orderItemId}" 
                                                   class="btn btn-sm btn-warning"
                                                   title="Request Return">
                                                    <i class="fas fa-undo-alt me-1"></i>Return
                                                </a>
                                            </c:if>
                                            
                                            <!-- Show View Return button if return request exists -->
                                            <c:if test="${not empty returnRequest}">
                                                <a href="/my-returns" class="btn btn-sm btn-info" title="View Return Status">
                                                    <i class="fas fa-eye me-1"></i>View Return
                                                </a>
                                            </c:if>
                                            
                                            <!-- Show Cancel button only for return requests that are still pending -->
                                            <c:if test="${not empty returnRequest && returnRequest.returnStatus == 'REQUESTED'}">
                                                <a href="/return/cancel/${returnRequest.returnId}" 
                                                   class="btn btn-sm btn-danger ms-1"
                                                   onclick="return confirm('Are you sure you want to cancel this return request?')"
                                                   title="Cancel Return Request">
                                                    <i class="fas fa-times"></i>
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Payment Summary -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-credit-card me-2 text-primary"></i>Payment Summary</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
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
                        <div class="col-md-6">
                            <c:if test="${not empty payment}">
                                <p><strong>Payment Method:</strong> ${payment.paymentMode}</p>
                                <p><strong>Transaction ID:</strong> ${payment.transactionRef}</p>
                                <p><strong>Payment Date:</strong><fmt:formatDate value="${payment.paymentDateAsDate}" pattern=" dd MMM yyyy, hh:mm a"/></p>
                                <p><strong>Payment Status:</strong> 
                                    <span class="badge ${payment.paymentStatus == 'SUCCESS' ? 'bg-success' : payment.paymentStatus == 'FAILED' ? 'bg-danger' : 'bg-warning'}">
                                        ${payment.paymentStatus}
                                    </span>
                                </p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="text-center mb-4">
                <c:if test="${order.canBeCancelled()}">
                    <a href="/order/cancel?orderId=${order.orderId}" 
                       class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to cancel this order?')">
                        <i class="fas fa-times-circle me-2"></i>Cancel Order
                    </a>
                </c:if>
                <a href="#" class="btn btn-outline-primary ms-2" onclick="window.print()">
                    <i class="fas fa-print me-2"></i>Print Details
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Return Policy Information -->
<c:if test="${order.orderStatus == 'DELIVERED'}">
    <div class="alert alert-info mt-3">
        <i class="fas fa-info-circle me-2"></i>
        <strong>Return Policy:</strong> You can return items within 30 days of delivery. 
        Products should be unused and in original packaging.
    </div>
</c:if>

<style>
    .order-timeline {
        display: flex;
        justify-content: space-between;
        position: relative;
        padding: 20px 0;
    }
    
    .order-timeline::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 2px;
        background: #dee2e6;
        transform: translateY(-50%);
        z-index: 1;
    }
    
    .timeline-step {
        position: relative;
        z-index: 2;
        text-align: center;
        flex: 1;
    }
    
    .timeline-icon {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: #dee2e6;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 10px;
        color: white;
        position: relative;
        z-index: 3;
    }
    
    .timeline-step.completed .timeline-icon {
        background: #28a745;
    }
    
    .timeline-step.cancelled .timeline-icon {
        background: #dc3545;
    }
    
    .timeline-step.returned .timeline-icon {
        background: #17a2b8;
    }
    
    .timeline-content h6 {
        margin-bottom: 5px;
        font-size: 14px;
    }
    
    .timeline-content small {
        font-size: 11px;
        color: #6c757d;
    }
    
    .table td {
        vertical-align: middle;
    }
    
    .btn-sm {
        padding: 0.25rem 0.5rem;
        font-size: 0.75rem;
    }
    
    @media (max-width: 768px) {
        .order-timeline {
            flex-direction: column;
            gap: 20px;
        }
        
        .order-timeline::before {
            display: none;
        }
        
        .timeline-step {
            display: flex;
            align-items: center;
            text-align: left;
            gap: 15px;
        }
        
        .timeline-icon {
            margin: 0;
        }
        
        .table td {
            font-size: 12px;
        }
        
        .btn-sm {
            padding: 0.2rem 0.4rem;
            font-size: 0.7rem;
        }
    }
</style>

<%@ include file="footer.jsp" %>