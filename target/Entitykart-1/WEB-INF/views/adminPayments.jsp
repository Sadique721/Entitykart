<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-credit-card me-2 text-primary"></i>Payment Management</h2>
                <div>
                    <a href="/admin/export/payments/excel" class="btn btn-success me-2"><i class="fas fa-file-excel"></i> Excel</a>
                    <a href="/admin/export/payments/word" class="btn btn-primary me-2"><i class="fas fa-file-word"></i> Word</a>
                    <button type="button" class="btn btn-info me-2" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="payments"><i class="fas fa-envelope"></i> Email</button>
                    <a href="/admin/payment-summary" class="btn btn-outline-primary me-2"><i class="fas fa-chart-pie me-2"></i>View Summary</a>
                    <button class="btn btn-outline-primary" onclick="refreshStats()"><i class="fas fa-sync-alt me-2"></i>Refresh</button>
                </div>
            </div>
            
            <!-- Payment Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Total Payments</p>
                                <h3 class="mb-0" id="totalPayments">${totalPayments}</h3>
                            </div>
                            <div class="stat-icon bg-primary">
                                <i class="fas fa-credit-card"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Successful</p>
                                <h3 class="mb-0 text-success" id="successfulPayments">${successCount}</h3>
                            </div>
                            <div class="stat-icon bg-success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Failed</p>
                                <h3 class="mb-0 text-danger" id="failedPayments">${failedCount}</h3>
                            </div>
                            <div class="stat-icon bg-danger">
                                <i class="fas fa-times-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Pending</p>
                                <h3 class="mb-0 text-warning" id="pendingPayments">${pendingCount}</h3>
                            </div>
                            <div class="stat-icon bg-warning">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Tabs -->
            <ul class="nav nav-tabs mb-3" id="paymentTabs" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button">All Payments</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="success-tab" data-bs-toggle="tab" data-bs-target="#success" type="button">Successful</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="failed-tab" data-bs-toggle="tab" data-bs-target="#failed" type="button">Failed</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button">Pending</button>
                </li>
            </ul>
            
            <!-- Payments Table -->
            <div class="tab-content">
                <div class="tab-pane fade show active" id="all">
                    <div class="table-container">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Payment ID</th>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Payment Mode</th>
                                        <th>Transaction Ref</th>
                                        <th>Status</th>
                                        <th>Payment Date</th>
                                        <th style="min-width: 120px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${payments}">
                                        <tr id="payment-row-${payment.paymentId}">
                                            <td><strong>#${payment.paymentId}</strong></td>
                                            <td>
                                                <a href="/admin/order/details?orderId=${payment.orderId}" class="text-decoration-none">
                                                    #${payment.orderId}
                                                </a>
                                            </td>
                                            <td>
                                                <c:set var="customerFound" value="false" />
                                                <c:forEach var="order" items="${orders}">
                                                    <c:if test="${order.orderId eq payment.orderId}">
                                                        Customer #${order.customerId}
                                                        <c:set var="customerFound" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${not customerFound}">
                                                    <span class="text-muted">N/A</span>
                                                </c:if>
                                            </td>
                                            <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                                            <td>
                                                <span class="badge 
                                                    <c:choose>
                                                        <c:when test="${payment.paymentMode eq 'COD'}">bg-success</c:when>
                                                        <c:when test="${payment.paymentMode eq 'CARD'}">bg-warning</c:when>
                                                        <c:when test="${payment.paymentMode eq 'UPI'}">bg-info</c:when>
                                                        <c:when test="${payment.paymentMode eq 'NET_BANKING'}">bg-secondary</c:when>
                                                        <c:otherwise>bg-primary</c:otherwise>
                                                    </c:choose>">
                                                    ${payment.paymentMode}
                                                </span>
                                            </td>
                                            <td><span class="text-muted small">${payment.transactionRef}</span></td>
                                            <td>
                                                <span class="badge payment-status 
                                                    <c:choose>
                                                        <c:when test="${payment.paymentStatus eq 'SUCCESS'}">bg-success</c:when>
                                                        <c:when test="${payment.paymentStatus eq 'FAILED'}">bg-danger</c:when>
                                                        <c:otherwise>bg-warning</c:otherwise>
                                                    </c:choose>">
                                                    ${payment.paymentStatus}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${payment.paymentDate != null}">
                                                     <fmt:formatDate value="${payment.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="/admin/payment/details?paymentId=${payment.paymentId}" 
                                                       class="btn btn-sm btn-outline-primary" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    
                                                    <c:if test="${payment.paymentStatus eq 'PENDING'}">
                                                        <button class="btn btn-sm btn-outline-success" 
                                                                onclick="updateStatus(${payment.paymentId}, 'SUCCESS')"
                                                                title="Accept Payment">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger" 
                                                                onclick="updateStatus(${payment.paymentId}, 'FAILED')"
                                                                title="Reject Payment">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </c:if>
                                                    
                                                    <c:if test="${payment.paymentStatus eq 'FAILED'}">
                                                        <button class="btn btn-sm btn-outline-warning" 
                                                                onclick="retryPayment(${payment.paymentId})"
                                                                title="Retry Payment">
                                                            <i class="fas fa-redo-alt"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty payments}">
                                        <tr>
                                            <td colspan="9" class="text-center py-4">
                                                <p class="text-muted mb-0">No payments found</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Dynamic tabs -->
                <div class="tab-pane fade" id="success"></div>
                <div class="tab-pane fade" id="failed"></div>
                <div class="tab-pane fade" id="pending"></div>
            </div>
        </div>
    </div>
</div>

<!-- Status Update Modal -->
<div class="modal fade" id="statusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Payment Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="statusMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="confirmStatusUpdate()">Confirm</button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div id="toastContainer" class="toast-container"></div>

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
              <option value="payments">Payments</option>
              <option value="returns">Returns</option>
              <option value="reviews">Reviews</option>
              <option value="users">Users</option>
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
// Set report type based on the button that opened the modal
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
</script>

<script>
    let currentPaymentId = null;
    let currentStatus = null;
    let statusModal = null;
    
    document.addEventListener('DOMContentLoaded', function() {
        statusModal = new bootstrap.Modal(document.getElementById('statusModal'));
        loadTabData();
    });
    
    function refreshStats() {
        fetch('/api/admin/payment-summary')
            .then(response => response.json())
            .then(data => {
                document.getElementById('totalPayments').textContent = data.totalPayments || 0;
                document.getElementById('successfulPayments').textContent = data.successfulPayments || 0;
                document.getElementById('failedPayments').textContent = data.failedPayments || 0;
                document.getElementById('pendingPayments').textContent = data.pendingPayments || 0;
            })
            .catch(error => console.error('Error:', error));
    }
    
    document.querySelectorAll('#paymentTabs button').forEach(tab => {
        tab.addEventListener('shown.bs.tab', function(event) {
            const status = event.target.id.replace('-tab', '').toUpperCase();
            if (status !== 'ALL') {
                loadPaymentsByStatus(status);
            }
        });
    });
    
    function loadPaymentsByStatus(status) {
        const tabId = status.toLowerCase();
        const tabPane = document.getElementById(tabId);
        
        tabPane.innerHTML = '<div class="text-center p-4"><div class="spinner-border text-primary"></div></div>';
        
        fetch('/api/admin/payments?status=' + status)
            .then(response => response.json())
            .then(payments => {
                if (payments.length === 0) {
                    tabPane.innerHTML = '<div class="text-center p-4 text-muted">No payments found</div>';
                    return;
                }
                
                let html = '<div class="table-container"><div class="table-responsive"><table class="table table-hover"><thead><tr>' +
                          '<th>Payment ID</th><th>Order ID</th><th>Customer</th><th>Amount</th>' +
                          '<th>Mode</th><th>Transaction Ref</th><th>Status</th><th>Payment Date</th><th>Actions</th>' +
                          '</tr></thead><tbody>';
                
                payments.forEach(p => {
                    let statusClass = p.status === 'SUCCESS' ? 'bg-success' : 
                                     p.status === 'FAILED' ? 'bg-danger' : 'bg-warning';
                    
                    let modeClass = p.mode === 'COD' ? 'bg-success' :
                                   p.mode === 'CARD' ? 'bg-warning' :
                                   p.mode === 'UPI' ? 'bg-info' :
                                   p.mode === 'NET_BANKING' ? 'bg-secondary' : 'bg-primary';
                    
                    let actions = '<div class="action-buttons">' +
                                 '<a href="/admin/payment/details?paymentId=' + p.paymentId + '" class="btn btn-sm btn-outline-primary">' +
                                 '<i class="fas fa-eye"></i></a>';
                    
                    if (p.status === 'PENDING') {
                        actions += '<button class="btn btn-sm btn-outline-success" onclick="updateStatus(' + p.paymentId + ', \'SUCCESS\')">' +
                                  '<i class="fas fa-check"></i></button>' +
                                  '<button class="btn btn-sm btn-outline-danger" onclick="updateStatus(' + p.paymentId + ', \'FAILED\')">' +
                                  '<i class="fas fa-times"></i></button>';
                    }
                    
                    if (p.status === 'FAILED') {
                        actions += '<button class="btn btn-sm btn-outline-warning" onclick="retryPayment(' + p.paymentId + ')">' +
                                  '<i class="fas fa-redo-alt"></i></button>';
                    }
                    
                    actions += '</div>';
                    
                    html += '<tr>' +
                        '<td>#' + p.paymentId + '</td>' +
                        '<td><a href="/admin/order/details?orderId=' + p.orderId + '">#' + p.orderId + '</a></td>' +
                        '<td>Customer #' + (p.customerId || p.orderId) + '</td>' +
                        '<td><i class="fas fa-rupee-sign"></i> ' + (p.amount || 0).toFixed(2) + '</td>' +
                        '<td><span class="badge ' + modeClass + '">' + (p.mode || 'N/A') + '</span></td>' +
                        '<td><span class="text-muted small">' + (p.transactionRef || 'N/A') + '</span></td>' +
                        '<td><span class="badge ' + statusClass + '">' + (p.status || 'PENDING') + '</span></td>' +
                        '<td>' + (p.paymentDate || '-') + '</td>' +
                        '<td>' + actions + '</td>' +
                        '</tr>';
                });
                
                html += '</tbody></table></div></div>';
                tabPane.innerHTML = html;
            })
            .catch(error => {
                tabPane.innerHTML = '<div class="text-center p-4 text-danger">Error loading payments</div>';
            });
    }
    
    function updateStatus(paymentId, status) {
        currentPaymentId = paymentId;
        currentStatus = status;
        
        document.getElementById('statusMessage').textContent = status === 'SUCCESS' ? 
            'Mark this payment as successful?' : 'Mark this payment as failed?';
        
        statusModal.show();
    }
    
    function confirmStatusUpdate() {
        if (!currentPaymentId || !currentStatus) return;
        
        fetch('/api/admin/payment/update-status', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'paymentId=' + currentPaymentId + '&status=' + currentStatus
        })
        .then(response => response.json())
        .then(data => {
            statusModal.hide();
            
            if (data.success) {
                showToast('success', data.message);
                
                const row = document.querySelector('#payment-row-' + currentPaymentId);
                if (row) {
                    const statusCell = row.querySelector('.payment-status');
                    if (statusCell) {
                        statusCell.className = 'badge payment-status ' + 
                            (currentStatus === 'SUCCESS' ? 'bg-success' : 'bg-danger');
                        statusCell.textContent = currentStatus;
                    }
                    
                    const actionCell = row.querySelector('td:last-child .action-buttons');
                    if (actionCell) {
                        actionCell.innerHTML = '<a href="/admin/payment/details?paymentId=' + currentPaymentId + '" ' +
                                              'class="btn btn-sm btn-outline-primary"><i class="fas fa-eye"></i></a>';
                    }
                }
                
                refreshStats();
                
                const activeTab = document.querySelector('#paymentTabs .active');
                if (activeTab && activeTab.id !== 'all-tab') {
                    const status = activeTab.id.replace('-tab', '').toUpperCase();
                    loadPaymentsByStatus(status);
                }
            } else {
                showToast('error', data.message);
            }
        })
        .catch(() => showToast('error', 'Failed to update status'));
    }
    
    function retryPayment(paymentId) {
        if (confirm('Retry this payment?')) {
            window.location.href = '/admin/payment/retry/' + paymentId;
        }
    }
    
    function showToast(type, message) {
        const toast = document.createElement('div');
        toast.className = 'toast align-items-center text-white ' + (type === 'success' ? 'bg-success' : 'bg-danger') + ' border-0';
        toast.innerHTML = '<div class="d-flex"><div class="toast-body">' + message + 
                         '</div><button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button></div>';
        
        document.getElementById('toastContainer').appendChild(toast);
        const bsToast = new bootstrap.Toast(toast, { delay: 3000 });
        bsToast.show();
        
        setTimeout(() => toast.remove(), 3000);
    }
    
    function loadTabData() {
        setTimeout(() => {
            document.querySelectorAll('#paymentTabs button:not(#all-tab)').forEach(tab => {
                const status = tab.id.replace('-tab', '').toUpperCase();
                loadPaymentsByStatus(status);
            });
        }, 500);
    }
    
    setInterval(refreshStats, 30000);
</script>

<style>
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        height: 100%;
    }
    
    .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 20px;
    }
    
    .stat-icon.bg-primary { background: linear-gradient(135deg, #667eea, #764ba2); }
    .stat-icon.bg-success { background: linear-gradient(135deg, #43e97b, #38f9d7); }
    .stat-icon.bg-danger { background: linear-gradient(135deg, #f093fb, #f5576c); }
    .stat-icon.bg-warning { background: linear-gradient(135deg, #fa709a, #fee140); }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
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
    
    .action-buttons {
        display: flex;
        gap: 4px;
        flex-wrap: wrap;
    }
    
    .action-buttons .btn {
        padding: 0.25rem 0.5rem;
        font-size: 0.75rem;
    }
    
    .badge {
        font-size: 11px;
        padding: 5px 8px;
    }
    
    .toast-container {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
    }
    
    .toast {
        min-width: 250px;
        margin-bottom: 10px;
    }
</style>

<%@ include file="footer.jsp" %>