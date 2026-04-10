<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-undo-alt me-2 text-primary"></i>Return Management</h2>
                <div>
                    <button class="btn btn-outline-primary me-2" onclick="refreshStats()">
                        <i class="fas fa-sync-alt me-2"></i>Refresh Stats
                    </button>
                    <a href="/admin/export/returns" class="btn btn-outline-success">
                        <i class="fas fa-file-export me-2"></i>Export
                    </a>
                </div>
            </div>
            
            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="text-muted text-uppercase small fw-bold">Total Returns</span>
                                <h2 class="mb-0 mt-2" id="totalReturns">${statistics.totalReturns}</h2>
                            </div>
                            <div class="stat-icon bg-primary bg-opacity-10">
                                <i class="fas fa-undo-alt fa-2x text-primary"></i>
                            </div>
                        </div>
                        <div class="mt-3 small text-muted">
                            <i class="fas fa-arrow-up text-success me-1"></i>
                            <span id="totalReturnsChange">+12%</span> from last month
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="text-muted text-uppercase small fw-bold">Pending</span>
                                <h2 class="mb-0 mt-2 text-warning" id="pendingReturns">${statistics.REQUESTED}</h2>
                            </div>
                            <div class="stat-icon bg-warning bg-opacity-10">
                                <i class="fas fa-clock fa-2x text-warning"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-warning bg-opacity-25 text-warning" id="pendingPercentage">
                                ${statistics.REQUESTED > 0 ? (statistics.REQUESTED / statistics.totalReturns * 100).intValue() : 0}% of total
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="text-muted text-uppercase small fw-bold">Approved</span>
                                <h2 class="mb-0 mt-2 text-success" id="approvedReturns">${statistics.APPROVED}</h2>
                            </div>
                            <div class="stat-icon bg-success bg-opacity-10">
                                <i class="fas fa-check-circle fa-2x text-success"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-success bg-opacity-25 text-success">
                                ${statistics.APPROVED + statistics.REFUNDED} processed
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="text-muted text-uppercase small fw-bold">Rejected</span>
                                <h2 class="mb-0 mt-2 text-danger" id="rejectedReturns">${statistics.REJECTED}</h2>
                            </div>
                            <div class="stat-icon bg-danger bg-opacity-10">
                                <i class="fas fa-times-circle fa-2x text-danger"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-danger bg-opacity-25 text-danger">
                                ${statistics.REJECTED > 0 ? (statistics.REJECTED / statistics.totalReturns * 100).intValue() : 0}% rejected
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Tabs -->
            <div class="card mb-4">
                <div class="card-body py-3">
                    <ul class="nav nav-tabs card-header-tabs" id="returnTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 'ALL' ? 'active' : ''}" 
                               href="/admin/returns?status=ALL&page=0">
                                <i class="fas fa-list me-2"></i>All Returns
                                <span class="badge bg-secondary ms-2">${statistics.totalReturns}</span>
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 'REQUESTED' ? 'active' : ''}" 
                               href="/admin/returns?status=REQUESTED&page=0">
                                <i class="fas fa-clock me-2"></i>Pending
                                <span class="badge bg-warning ms-2">${statistics.REQUESTED}</span>
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 'APPROVED' ? 'active' : ''}" 
                               href="/admin/returns?status=APPROVED&page=0">
                                <i class="fas fa-check-circle me-2"></i>Approved
                                <span class="badge bg-success ms-2">${statistics.APPROVED}</span>
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 'REJECTED' ? 'active' : ''}" 
                               href="/admin/returns?status=REJECTED&page=0">
                                <i class="fas fa-times-circle me-2"></i>Rejected
                                <span class="badge bg-danger ms-2">${statistics.REJECTED}</span>
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 'REFUNDED' ? 'active' : ''}" 
                               href="/admin/returns?status=REFUNDED&page=0">
                                <i class="fas fa-rupee-sign me-2"></i>Refunded
                                <span class="badge bg-info ms-2">${statistics.REFUNDED}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- Returns Table -->
            <div class="table-container">
                <form id="bulkProcessForm" action="/admin/return/bulk-process" method="post">
                    <div class="mb-3 d-flex align-items-center">
                        <div class="me-auto">
                            <button type="button" class="btn btn-success btn-sm" onclick="bulkApprove()">
                                <i class="fas fa-check me-1"></i>Approve Selected
                            </button>
                            <button type="button" class="btn btn-danger btn-sm ms-2" onclick="bulkReject()">
                                <i class="fas fa-times me-1"></i>Reject Selected
                            </button>
                            <button type="button" class="btn btn-info btn-sm ms-2" onclick="bulkProcessRefund()">
                                <i class="fas fa-rupee-sign me-1"></i>Process Refund
                            </button>
                        </div>
                        <div>
                            <span class="text-muted" id="selectedCount">0 items selected</span>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th width="50">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="selectAll" onclick="toggleAll()">
                                        </div>
                                    </th>
                                    <th>Return ID</th>
                                    <th>Order ID</th>
                                    <th>Product Details</th>
                                    <th>Customer</th>
                                    <th>Reason</th>
                                    <th>Request Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${returns}">
                                    <%-- Access return request from the map --%>
                                    <c:set var="returnReq" value="${item.returnReq}" />
                                    <c:set var="order" value="${item.order}" />
                                    <c:set var="product" value="${item.product}" />
                                    <c:set var="orderItem" value="${item.orderItem}" />
                                    
                                    <tr>
                                        <td>
                                            <c:if test="${returnReq.returnStatus == 'REQUESTED' || returnReq.returnStatus == 'APPROVED'}">
                                                <div class="form-check">
                                                    <input class="form-check-input returnCheckbox" type="checkbox" name="returnIds" value="${returnReq.returnId}">
                                                </div>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="fw-bold">#${returnReq.returnId}</span>
                                        </td>
                                        <td>
                                            <a href="/admin/order/details?orderId=${order.orderId}" class="text-decoration-none">
                                                #${order.orderId}
                                            </a>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/40x40?text=Product'}" 
                                                     width="40" height="40" class="rounded me-2" style="object-fit: cover; border: 1px solid #eee;">
                                                <div>
                                                    <div class="fw-bold small">${product.productName}</div>
                                                    <div class="text-muted small">
                                                        <i class="fas fa-times me-1"></i>Qty: ${orderItem.quantity}
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div>
                                                <div class="small fw-bold">Customer #${order.customerId}</div>
                                                <div class="text-muted small">
                                                    <i class="fas fa-envelope me-1"></i>${order.userEmail}
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="${returnReq.reason}">
                                                ${returnReq.reason.length() > 30 ? returnReq.reason.substring(0, 27).concat('...') : returnReq.reason}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="small">
                                                <i class="fas fa-calendar-alt me-1 text-muted"></i>
                                                <fmt:formatDate value="${returnReq.requestedAt}" pattern="dd MMM yyyy"/>
                                            </div>
                                            <div class="text-muted small">
                                                <fmt:formatDate value="${returnReq.requestedAt}" pattern="hh:mm a"/>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${returnReq.returnStatus == 'REQUESTED'}">
                                                    <span class="badge bg-warning text-dark">PENDING</span>
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
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${returnReq.returnStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <a href="/admin/return/details?returnId=${returnReq.returnId}" 
                                                   class="btn btn-outline-primary" 
                                                   title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${returnReq.returnStatus == 'REQUESTED'}">
                                                    <button type="button" 
                                                            class="btn btn-outline-success" 
                                                            onclick="updateReturnStatus(${returnReq.returnId}, 'APPROVE')"
                                                            title="Approve">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                    <button type="button" 
                                                            class="btn btn-outline-danger" 
                                                            onclick="updateReturnStatus(${returnReq.returnId}, 'REJECT')"
                                                            title="Reject">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${returnReq.returnStatus == 'APPROVED'}">
                                                    <button type="button" 
                                                            class="btn btn-outline-info" 
                                                            onclick="updateReturnStatus(${returnReq.returnId}, 'REFUND')"
                                                            title="Process Refund">
                                                        <i class="fas fa-rupee-sign"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty returns}">
                                    <tr>
                                        <td colspan="9" class="text-center py-5">
                                            <i class="fas fa-undo-alt fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">No return requests found</h5>
                                            <p class="text-muted small">There are no return requests matching your criteria</p>
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
                                <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${currentPage-1}">
                                    <i class="fas fa-chevron-left"></i> Previous
                                </a>
                            </li>
                            <c:forEach begin="0" end="${totalPages-1}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${i}">${i+1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/returns?status=${currentStatus}&page=${currentPage+1}">
                                    Next <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
</div>

<style>
    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
        border: 1px solid #f0f0f0;
    }
    
    .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    }
    
    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .nav-tabs .nav-link {
        color: #6c757d;
        border: none;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .nav-tabs .nav-link:hover {
        color: var(--primary-blue);
        background: #f8f9fa;
    }
    
    .nav-tabs .nav-link.active {
        color: var(--primary-blue);
        font-weight: 600;
        border-bottom: 3px solid var(--primary-blue);
        background: transparent;
    }
    
    .table-container {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    
    .table thead th {
        border-top: none;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 0.5px;
        color: #6c757d;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .btn-group .btn {
        padding: 0.25rem 0.5rem;
    }
    
    .badge {
        padding: 0.5rem 0.75rem;
        font-weight: 500;
        font-size: 0.75rem;
    }
</style>

<script>
    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
    
    function toggleAll() {
        const selectAll = document.getElementById('selectAll');
        const checkboxes = document.getElementsByClassName('returnCheckbox');
        for (let checkbox of checkboxes) {
            checkbox.checked = selectAll.checked;
        }
        updateSelectedCount();
    }
    
    function updateSelectedCount() {
        const checkboxes = document.getElementsByClassName('returnCheckbox');
        let count = 0;
        for (let checkbox of checkboxes) {
            if (checkbox.checked) count++;
        }
        document.getElementById('selectedCount').textContent = count + ' item' + (count !== 1 ? 's' : '') + ' selected';
    }
    
    // Add event listeners to checkboxes
    document.querySelectorAll('.returnCheckbox').forEach(checkbox => {
        checkbox.addEventListener('change', updateSelectedCount);
    });
    
    function bulkApprove() {
        if (!validateSelection()) return;
        
        const form = document.getElementById('bulkProcessForm');
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'APPROVE';
        form.appendChild(actionInput);
        
        if (confirm('Are you sure you want to approve the selected return requests?')) {
            form.submit();
        }
    }
    
    function bulkReject() {
        if (!validateSelection()) return;
        
        const form = document.getElementById('bulkProcessForm');
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'REJECT';
        form.appendChild(actionInput);
        
        if (confirm('Are you sure you want to reject the selected return requests?')) {
            form.submit();
        }
    }
    
    function bulkProcessRefund() {
        if (!validateSelection()) return;
        
        const form = document.getElementById('bulkProcessForm');
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'REFUND';
        form.appendChild(actionInput);
        
        if (confirm('Are you sure you want to process refund for the selected return requests?')) {
            form.submit();
        }
    }
    
    function validateSelection() {
        const checkboxes = document.getElementsByClassName('returnCheckbox');
        let selected = false;
        for (let checkbox of checkboxes) {
            if (checkbox.checked) {
                selected = true;
                break;
            }
        }
        
        if (!selected) {
            alert('Please select at least one return request.');
            return false;
        }
        return true;
    }
    
    function updateReturnStatus(returnId, action) {
        let message = '';
        switch(action) {
            case 'APPROVE':
                message = 'Approve this return request?';
                break;
            case 'REJECT':
                message = 'Reject this return request?';
                break;
            case 'REFUND':
                message = 'Process refund for this return request?';
                break;
        }
        
        if (confirm(message)) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/admin/return/update-status';
            
            const returnIdInput = document.createElement('input');
            returnIdInput.type = 'hidden';
            returnIdInput.name = 'returnId';
            returnIdInput.value = returnId;
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = action;
            
            form.appendChild(returnIdInput);
            form.appendChild(actionInput);
            document.body.appendChild(form);
            form.submit();
        }
    }
    
    function refreshStats() {
        fetch('/api/admin/return-stats')
            .then(response => response.json())
            .then(data => {
                document.getElementById('totalReturns').textContent = data.totalReturns;
                document.getElementById('pendingReturns').textContent = data.pendingReturns;
                document.getElementById('approvedReturns').textContent = data.approvedReturns || 0;
                document.getElementById('rejectedReturns').textContent = data.rejectedReturns || 0;
                
                if (data.totalReturns > 0) {
                    const pendingPercent = Math.round((data.pendingReturns / data.totalReturns) * 100);
                    document.getElementById('pendingPercentage').textContent = pendingPercent + '% of total';
                }
                
                // Update badges
                document.querySelectorAll('.nav-link .badge').forEach(badge => {
                    const parent = badge.parentElement;
                    if (parent.textContent.includes('Pending')) {
                        badge.textContent = data.pendingReturns;
                    } else if (parent.textContent.includes('Approved')) {
                        badge.textContent = data.approvedReturns;
                    } else if (parent.textContent.includes('Rejected')) {
                        badge.textContent = data.rejectedReturns;
                    }
                });
            })
            .catch(error => console.error('Error refreshing stats:', error));
    }
    
    // Auto-refresh every 30 seconds
    let refreshInterval = setInterval(refreshStats, 30000);
    
    // Clear interval when leaving page
    window.addEventListener('beforeunload', function() {
        clearInterval(refreshInterval);
    });
</script>

<%@ include file="footer.jsp" %>