<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-box-open me-2"></i>Order #${order.orderId} Details</h2>
                <a href="/admin/orders" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Orders
                </a>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Order Status Update -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-edit me-2 text-primary"></i>Update Order Status</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/order/update-status" method="post" class="row align-items-end">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <div class="col-md-4">
                            <label class="form-label">Current Status</label>
                            <input type="text" class="form-control" value="${order.orderStatus}" readonly>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Update Status</label>
                            <select name="orderStatus" class="form-select">
                                <option value="PLACED" ${order.orderStatus == 'PLACED' ? 'selected' : ''}>Placed</option>
                                <option value="CONFIRMED" ${order.orderStatus == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                <option value="SHIPPED" ${order.orderStatus == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                <option value="DELIVERED" ${order.orderStatus == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                <option value="CANCELLED" ${order.orderStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                <option value="RETURNED" ${order.orderStatus == 'RETURNED' ? 'selected' : ''}>Returned</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-save me-2"></i>Update Status
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="row">
                <!-- Customer Info -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-user me-2 text-primary"></i>Customer Information</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty customer}">
                                <p><strong>Customer ID:</strong> #${customer.userId}</p>
                                <p><strong>Name:</strong> ${customerName}</p>
                                <p><strong>Email:</strong> ${customer.email}</p>
                                <p><strong>Contact:</strong> ${customer.contactNum}</p>
                            </c:if>
                            <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></p>
                        </div>
                    </div>
                </div>
                
                <!-- Order Info -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Order Information</h5>
                        </div>
                        <div class="card-body">
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
                                <tr>
                                    <th>Total Items:</th>
                                    <td>${totalItems}</td>
                                </tr>
                            </table>
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
                                                <img src="${item[2] != null ? item[2] : 'https://via.placeholder.com/60'}" 
                                                     width="60" height="60" class="rounded me-3" style="object-fit: cover;">
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
                                <p><strong>Payment Date:</strong> <fmt:formatDate value="${payment.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>