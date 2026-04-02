<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-undo-alt me-2"></i>Return Request</h2>
                <a href="/order/details?orderId=${order.orderId}" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Order
                </a>
            </div>
            
            <!-- Product Details -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Item to Return</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/150'}" 
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
                                    <th>Price:</th>
                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price}" pattern="#,##0.00"/></td>
                                </tr>
                                <tr>
                                    <th>Total:</th>
                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price * orderItem.quantity}" pattern="#,##0.00"/></td>
                                </tr>
                                <tr>
                                    <th>Order Date:</th>
                                    <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Return Policy -->
            <div class="alert alert-info mb-4">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Return Policy:</strong> Items can be returned within 30 days of delivery. 
                Product should be unused and in original packaging.
            </div>
            
            <!-- Return Form -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Return Details</h5>
                </div>
                <div class="card-body">
                    <form action="/return/submit" method="post" id="returnForm">
                        <input type="hidden" name="orderItemId" value="${orderItem.orderItemId}">
                        
                        <div class="mb-3">
                            <label class="form-label">Reason for Return <span class="text-danger">*</span></label>
                            <select name="reason" class="form-select" required>
                                <option value="">Select a reason</option>
                                <option value="Damaged Product">Damaged Product</option>
                                <option value="Wrong Item Delivered">Wrong Item Delivered</option>
                                <option value="Size/Fit Issue">Size/Fit Issue</option>
                                <option value="Quality Issue">Quality Issue</option>
                                <option value="Not as Described">Not as Described</option>
                                <option value="Defective Product">Defective Product</option>
                                <option value="Missing Parts">Missing Parts</option>
                                <option value="Changed Mind">Changed Mind</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Additional Comments</label>
                            <textarea name="comments" class="form-control" rows="4" 
                                      placeholder="Please provide more details about the issue..."></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Upload Images (Optional)</label>
                            <input type="file" class="form-control" multiple accept="image/*" disabled>
                            <small class="text-muted">Image upload feature coming soon. You can email images to support@entitykart.com</small>
                        </div>
                        
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="confirmPolicy" required>
                            <label class="form-check-label" for="confirmPolicy">
                                I confirm that the item is unused and in original condition as per return policy
                            </label>
                        </div>
                        
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Note:</strong> Return request will be reviewed within 2-3 business days. 
                            Once approved, you will receive instructions for return shipping.
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                <i class="fas fa-paper-plane me-2"></i>Submit Return Request
                            </button>
                            <a href="/order/details?orderId=${order.orderId}" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('returnForm').addEventListener('submit', function(e) {
        const confirmCheck = document.getElementById('confirmPolicy');
        if (!confirmCheck.checked) {
            e.preventDefault();
            alert('Please confirm that the item meets return policy conditions');
            return;
        }
        
        // Show loading state
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Submitting...';
        submitBtn.disabled = true;
    });
</script>

<style>
    .alert-info {
        border-left: 4px solid var(--primary-blue);
    }
    .alert-warning {
        border-left: 4px solid #ffc107;
    }
</style>

<%@ include file="footer.jsp" %>