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
                <h2><i class="fas fa-undo-alt me-2"></i>Return Management</h2>
                <button class="btn btn-outline-primary" onclick="refreshStats()">
                    <i class="fas fa-sync-alt me-2"></i>Refresh Stats
                </button>
            </div>

            <!-- Action Buttons (Export) -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/export/returns/excel" class="btn btn-success">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/export/returns/word" class="btn btn-primary">
                                <i class="fas fa-file-word"></i> Export to Word
                            </a>
                            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="returns">
                                <i class="fas fa-envelope"></i> Email Report
                            </button>
                            <button class="btn btn-outline-primary" onclick="refreshStats()">
                                <i class="fas fa-sync-alt"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Returns</h6>
                            <h3 id="totalReturns">
                                <c:set var="total" value="0" />
                                <c:forEach var="stat" items="${statistics}">
                                    <c:set var="total" value="${total + stat.value}" />
                                </c:forEach>
                                ${total}
                            </h3>
                        </div>
                        <i class="fas fa-undo-alt fa-2x text-primary"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Pending</h6>
                            <h3 id="pendingReturns" class="text-warning">${statistics.REQUESTED != null ? statistics.REQUESTED : 0}</h3>
                        </div>
                        <i class="fas fa-clock fa-2x text-warning"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Approved</h6>
                            <h3 id="approvedReturns" class="text-success">${statistics.APPROVED != null ? statistics.APPROVED : 0}</h3>
                        </div>
                        <i class="fas fa-check-circle fa-2x text-success"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Rejected</h6>
                            <h3 id="rejectedReturns" class="text-danger">${statistics.REJECTED != null ? statistics.REJECTED : 0}</h3>
                        </div>
                        <i class="fas fa-times-circle fa-2x text-danger"></i>
                    </div>
                </div>
            </div>
            
            <!-- Filter Tabs -->
            <ul class="nav nav-tabs mb-3" id="returnTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${currentStatus == 'ALL' ? 'active' : ''}" 
                       href="/admin/returns?status=ALL&page=0">All Returns</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${currentStatus == 'REQUESTED' ? 'active' : ''}" 
                       href="/admin/returns?status=REQUESTED&page=0">Pending</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${currentStatus == 'APPROVED' ? 'active' : ''}" 
                       href="/admin/returns?status=APPROVED&page=0">Approved</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${currentStatus == 'REJECTED' ? 'active' : ''}" 
                       href="/admin/returns?status=REJECTED&page=0">Rejected</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${currentStatus == 'REFUNDED' ? 'active' : ''}" 
                       href="/admin/returns?status=REFUNDED&page=0">Refunded</a>
                </li>
            </ul>
            
            <!-- Returns Table -->
            <div class="table-container">
                <form id="bulkProcessForm" action="/admin/return/bulk-process" method="post">
                    <div class="mb-3">
                        <button type="button" class="btn btn-success btn-sm" onclick="bulkApprove()">
                            <i class="fas fa-check me-1"></i>Approve Selected
                        </button>
                        <button type="button" class="btn btn-danger btn-sm ms-2" onclick="bulkReject()">
                            <i class="fas fa-times me-1"></i>Reject Selected
                        </button>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th width="50">
                                        <input type="checkbox" id="selectAll" onclick="toggleAll()">
                                    </th>
                                    <th>Return ID</th>
                                    <th>Order ID</th>
                                    <th>Product</th>
                                    <th>Customer</th>
                                    <th>Reason</th>
                                    <th>Requested Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${returns}">
                                    <%-- Extract variables from the map --%>
                                    <c:set var="returnReq" value="${item.returnReq}" />
                                    <c:set var="order" value="${item.order}" />
                                    <c:set var="product" value="${item.product}" />
                                    <c:set var="orderItem" value="${item.orderItem}" />
                                    
                                    <tr>
                                        <td>
                                            <c:if test="${returnReq.returnStatus == 'REQUESTED'}">
                                                <input type="checkbox" name="returnIds" value="${returnReq.returnId}" class="returnCheckbox">
                                            </c:if>
                                        </td>
                                        <td><strong>#${returnReq.returnId}</strong></td>
                                        <td>
                                            <a href="/admin/order/details?orderId=${order.orderId}" class="text-decoration-none">
                                                #${order.orderId}
                                            </a>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/40'}" 
                                                     width="40" height="40" class="rounded me-2" style="object-fit: cover;">
                                                <div>
                                                    <strong>${product.productName}</strong>
                                                    <br>
                                                    <small class="text-muted">Qty: ${orderItem.quantity} | Price: <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${orderItem.price}" pattern="#,##0.00"/></small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div>
                                                <strong>Customer #${order.customerId}</strong>
                                                <br>
                                                <small class="text-muted">Order Date: <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy"/></small>
                                            </div>
                                        </td>
                                        <td>
                                            <span title="${returnReq.reason}">
                                                <c:choose>
                                                    <c:when test="${fn:length(returnReq.reason) > 30}">
                                                        ${fn:substring(returnReq.reason, 0, 27)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${returnReq.reason}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <%-- FIXED: Using formatted string method instead of fmt:formatDate on LocalDateTime --%>
                                        <td>${returnReq.formattedRequestedAt}</td>
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
                                        <td>
                                            <div class="btn-group-vertical btn-group-sm" role="group">
                                                <a href="/admin/return/details?returnId=${returnReq.returnId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${returnReq.returnStatus == 'REQUESTED'}">
                                                    <button type="button" class="btn btn-outline-success" onclick="processReturn(${returnReq.returnId}, 'APPROVE')" title="Approve">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger" onclick="processReturn(${returnReq.returnId}, 'REJECT')" title="Reject">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${returnReq.returnStatus == 'APPROVED'}">
                                                    <button type="button" class="btn btn-outline-primary" onclick="processReturn(${returnReq.returnId}, 'REFUND')" title="Process Refund">
                                                        <i class="fas fa-rupee-sign"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty returns}">
                                    <tr>
                                        <td colspan="9" class="text-center py-4">
                                            <i class="fas fa-undo-alt fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No return requests found</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </form>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${currentPage-1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${totalPages-1}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${i}">${i+1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${currentPage+1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
                
                <!-- Summary -->
                <div class="mt-3 text-muted small">
                    Showing ${fn:length(returns)} of ${totalElements} total returns
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Process Return Modal -->
<div class="modal fade" id="processModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="processModalTitle">Process Return Request</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="processForm" action="/admin/return/process" method="post">
                <input type="hidden" name="returnId" id="modalReturnId">
                <input type="hidden" name="action" id="modalAction">
                <div class="modal-body">
                    <p id="modalMessage">Are you sure you want to process this return request?</p>
                    <div class="mb-3">
                        <label class="form-label">Admin Comments</label>
                        <textarea name="adminComments" class="form-control" rows="3" 
                                  placeholder="Add any notes about this decision..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="modalConfirmBtn">Confirm</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container for Notifications -->
<div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;"></div>

<!-- Email Report Modal -->
<div class="modal fade" id="emailReportModal" tabindex="-1" aria-labelledby="emailReportModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="emailReportModalLabel">Send Report via Email</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/admin/export/send-report" method="post">
        <div class="modal-body">
          <div class="mb-3">
            <label for="reportType" class="form-label">Report Type</label>
            <select class="form-select" name="reportType" id="reportType">
              <option value="orders">Orders</option>
              <option value="products">Products</option>
              <option value="users">Users</option>
              <option value="payments">Payments</option>
              <option value="returns">Returns</option>
              <option value="reviews">Reviews</option>
              <option value="wishlist">Wishlist</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" name="email" id="email" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary">Send Report</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
// Auto‑set report type
document.addEventListener('DOMContentLoaded', function() {
    var emailModal = document.getElementById('emailReportModal');
    if (emailModal) {
        emailModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var reportType = button.getAttribute('data-report-type');
            var select = emailModal.querySelector('#reportType');
            if (reportType) {
                select.value = reportType;
            }
        });
    }
});

let currentReturnId = null;
let currentAction = null;

function toggleAll() {
    const selectAll = document.getElementById('selectAll');
    const checkboxes = document.getElementsByClassName('returnCheckbox');
    for (let checkbox of checkboxes) {
        checkbox.checked = selectAll.checked;
    }
}

function getSelectedIds() {
    const checkboxes = document.getElementsByClassName('returnCheckbox');
    const selected = [];
    for (let checkbox of checkboxes) {
        if (checkbox.checked) {
            selected.push(checkbox.value);
        }
    }
    return selected;
}

function bulkApprove() {
    const selectedIds = getSelectedIds();
    if (selectedIds.length === 0) {
        showToast('warning', 'Please select at least one return request to approve.');
        return;
    }
    
    if (confirm('Are you sure you want to approve the selected ' + selectedIds.length + ' return requests?')) {
        const form = document.getElementById('bulkProcessForm');
        
        // Remove any existing returnIds inputs
        const existingInputs = form.querySelectorAll('input[name="returnIds"]');
        existingInputs.forEach(input => input.remove());
        
        // Add selected IDs as inputs
        for (let id of selectedIds) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'returnIds';
            input.value = id;
            form.appendChild(input);
        }
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'APPROVE';
        form.appendChild(actionInput);
        
        form.submit();
    }
}

function bulkReject() {
    const selectedIds = getSelectedIds();
    if (selectedIds.length === 0) {
        showToast('warning', 'Please select at least one return request to reject.');
        return;
    }
    
    if (confirm('Are you sure you want to reject the selected ' + selectedIds.length + ' return requests?')) {
        const form = document.getElementById('bulkProcessForm');
        
        // Remove any existing returnIds inputs
        const existingInputs = form.querySelectorAll('input[name="returnIds"]');
        existingInputs.forEach(input => input.remove());
        
        // Add selected IDs as inputs
        for (let id of selectedIds) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'returnIds';
            input.value = id;
            form.appendChild(input);
        }
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'REJECT';
        form.appendChild(actionInput);
        
        form.submit();
    }
}

function processReturn(returnId, action) {
    document.getElementById('modalReturnId').value = returnId;
    document.getElementById('modalAction').value = action;
    
    let title = '';
    let message = '';
    let confirmBtnClass = '';
    
    if (action === 'APPROVE') {
        title = 'Approve Return';
        message = 'Are you sure you want to approve this return request?';
        confirmBtnClass = 'btn-success';
    } else if (action === 'REJECT') {
        title = 'Reject Return';
        message = 'Are you sure you want to reject this return request?';
        confirmBtnClass = 'btn-danger';
    } else if (action === 'REFUND') {
        title = 'Process Refund';
        message = 'Are you sure you want to process refund for this return?';
        confirmBtnClass = 'btn-primary';
    }
    
    document.getElementById('processModalTitle').textContent = title;
    document.getElementById('modalMessage').textContent = message;
    document.getElementById('modalConfirmBtn').className = 'btn ' + confirmBtnClass;
    
    var modal = new bootstrap.Modal(document.getElementById('processModal'));
    modal.show();
}

function refreshStats() {
    fetch('/api/admin/return-stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('totalReturns').textContent = data.totalReturns || 0;
            document.getElementById('pendingReturns').textContent = data.pendingReturns || 0;
            document.getElementById('approvedReturns').textContent = data.approvedcount || 0;
            document.getElementById('rejectedReturns').textContent = data.rejectedcount || 0;
        })
        .catch(error => console.error('Error refreshing stats:', error));
}

function showToast(type, message) {
    const toastId = 'toast-' + Date.now();
    const bgColor = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : type === 'warning' ? 'bg-warning' : 'bg-info';
    const icon = type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : type === 'warning' ? 'fa-exclamation-triangle' : 'fa-info-circle';
    
    const toast = document.createElement('div');
    toast.id = toastId;
    toast.className = `toast align-items-center text-white ${bgColor} border-0`;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', 'assertive');
    toast.setAttribute('aria-atomic', 'true');
    
    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                <i class="fas ${icon} me-2"></i>
                ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    `;
    
    document.getElementById('toastContainer').appendChild(toast);
    
    const bsToast = new bootstrap.Toast(toast, { delay: 3000 });
    bsToast.show();
    
    toast.addEventListener('hidden.bs.toast', function() {
        toast.remove();
    });
}

// Refresh every 30 seconds
setInterval(refreshStats, 30000);

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
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        transition: transform 0.2s;
        height: 100%;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .nav-tabs .nav-link {
        color: #495057;
        font-weight: 500;
    }
    
    .nav-tabs .nav-link.active {
        color: #007bff;
        font-weight: 600;
        border-bottom: 2px solid #007bff;
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    
    .badge {
        font-size: 11px;
        padding: 5px 8px;
    }
    
    .table td {
        vertical-align: middle;
    }
    
    .btn-group-vertical {
        display: inline-flex;
        flex-direction: column;
        gap: 2px;
    }
    
    .btn-group-vertical .btn {
        border-radius: 4px !important;
        padding: 0.2rem 0.4rem;
    }
    
    .pagination {
        margin-top: 20px;
    }
    
    .toast-container {
        z-index: 9999;
    }
    
    @media (max-width: 768px) {
        .stat-card {
            margin-bottom: 15px;
        }
        
        .table-responsive {
            font-size: 12px;
        }
        
        .btn-group-vertical {
            flex-direction: row;
        }
        
        .btn-group-vertical .btn {
            flex: 1;
        }
    }
</style>

<%@ include file="footer.jsp" %>