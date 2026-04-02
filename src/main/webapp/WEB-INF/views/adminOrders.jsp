<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-box me-2"></i>Manage Orders</h2>
                <button class="btn btn-outline-primary" onclick="refreshStats()">
                    <i class="fas fa-sync-alt me-2"></i>Refresh Stats
                </button>
            </div>

            <!-- Action Buttons (Export) -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/export/orders/excel" class="btn btn-success">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/export/orders/word" class="btn btn-primary">
                                <i class="fas fa-file-word"></i> Export to Word
                            </a>
                            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="orders">
                                <i class="fas fa-envelope"></i> Email Report
                            </button>
                            <button class="btn btn-outline-primary" onclick="refreshStats()">
                                <i class="fas fa-sync-alt"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Order Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Orders</h6>
                            <h3 id="totalOrders">${stats.totalOrders}</h3>
                        </div>
                        <i class="fas fa-shopping-cart fa-2x text-primary"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Pending Orders</h6>
                            <h3 id="pendingOrders">${stats.pendingOrders}</h3>
                        </div>
                        <i class="fas fa-clock fa-2x text-warning"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Delivered</h6>
                            <h3 id="deliveredOrders">${stats.deliveredOrders}</h3>
                        </div>
                        <i class="fas fa-check-circle fa-2x text-success"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Revenue</h6>
                            <h3 id="totalRevenue"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,##0.00"/></h3>
                        </div>
                        <i class="fas fa-money-bill-wave fa-2x text-info"></i>
                    </div>
                </div>
            </div>
            
            <!-- Filter Tabs -->
            <ul class="nav nav-tabs mb-3" id="orderTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="all-tab" data-bs-toggle="tab" 
                            data-bs-target="#all" type="button" role="tab">All Orders</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="placed-tab" data-bs-toggle="tab" 
                            data-bs-target="#placed" type="button" role="tab">Placed</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="confirmed-tab" data-bs-toggle="tab" 
                            data-bs-target="#confirmed" type="button" role="tab">Confirmed</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="shipped-tab" data-bs-toggle="tab" 
                            data-bs-target="#shipped" type="button" role="tab">Shipped</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="delivered-tab" data-bs-toggle="tab" 
                            data-bs-target="#delivered" type="button" role="tab">Delivered</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" 
                            data-bs-target="#cancelled" type="button" role="tab">Cancelled</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="returned-tab" data-bs-toggle="tab" 
                            data-bs-target="#returned" type="button" role="tab">Returned</button>
                </li>
            </ul>
            
            <!-- Orders Table -->
            <div class="tab-content" id="orderTabsContent">
                <div class="tab-pane fade show active" id="all" role="tabpanel">
                    <div class="table-container">
                        <table class="table table-hover dataTable">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th>Items</th>
                                    <th>Total</th>
                                    <th>Order Status</th>
                                    <th>Payment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>#${order.orderId}</td>
                                        <td>${customerNames[order.orderId]}</td>
                                        <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                        <td>${itemCounts[order.orderId]}</td>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
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
                                        <td>
                                            <span class="badge ${order.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'}">
                                                ${order.paymentStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="/admin/order/details?orderId=${order.orderId}" class="btn btn-sm btn-info" title="View">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Other tabs will be loaded dynamically -->
                <div class="tab-pane fade" id="placed" role="tabpanel"></div>
                <div class="tab-pane fade" id="confirmed" role="tabpanel"></div>
                <div class="tab-pane fade" id="shipped" role="tabpanel"></div>
                <div class="tab-pane fade" id="delivered" role="tabpanel"></div>
                <div class="tab-pane fade" id="cancelled" role="tabpanel"></div>
                <div class="tab-pane fade" id="returned" role="tabpanel"></div>
            </div>
        </div>
    </div>
</div>

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
// Auto‑set report type based on button that opened the modal
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

function refreshStats() {
    fetch('/admin/order-stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('totalOrders').textContent = data.totalOrders;
            document.getElementById('pendingOrders').textContent = 
                (data.placedOrders || 0) + (data.confirmedOrders || 0);
            document.getElementById('deliveredOrders').textContent = data.deliveredOrders || 0;
            document.getElementById('totalRevenue').innerHTML = 
                '<i class="fas fa-rupee-sign"></i> ' + 
                new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(data.totalRevenue || 0);
        })
        .catch(error => console.error('Error refreshing stats:', error));
}

// Load stats on page load
refreshStats();

// Refresh every 30 seconds
setInterval(refreshStats, 30000);

// Load tab data
document.querySelectorAll('#orderTabs button').forEach(tab => {
    tab.addEventListener('shown.bs.tab', function(event) {
        const status = event.target.id.replace('-tab', '').toUpperCase();
        if (status !== 'ALL') {
            loadOrdersByStatus(status);
        }
    });
});

function loadOrdersByStatus(status) {
    const tabId = status.toLowerCase();
    const tabPane = document.getElementById(tabId);
    
    if (!tabPane) return;
    
    // Show loading indicator
    tabPane.innerHTML = '<div class="text-center p-4"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
    
    fetch('/api/admin/orders?status=' + status)
        .then(response => response.json())
        .then(data => {
            if (data.length === 0) {
                tabPane.innerHTML = '<div class="text-center p-4 text-muted">No orders found</div>';
                return;
            }
            
            let html = '<div class="table-container"><table class="table table-hover"><thead><tr>' +
                      '<th>Order ID</th><th>Customer</th><th>Date</th><th>Items</th>' +
                      '<th>Total</th><th>Order Status</th><th>Payment</th><th>Actions</th>' +
                      '</tr></thead><tbody>';
            
            data.forEach(order => {
                const orderDate = order.orderDate ? new Date(order.orderDate) : new Date();
                const formattedDate = orderDate.toLocaleDateString('en-IN', { 
                    day: '2-digit', 
                    month: 'short', 
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                });
                
                let statusBadgeClass = 'bg-secondary';
                if (order.orderStatus === 'DELIVERED') statusBadgeClass = 'bg-success';
                else if (order.orderStatus === 'CANCELLED') statusBadgeClass = 'bg-danger';
                else if (order.orderStatus === 'RETURNED') statusBadgeClass = 'bg-info';
                else if (order.orderStatus === 'SHIPPED') statusBadgeClass = 'bg-primary';
                else if (order.orderStatus === 'CONFIRMED') statusBadgeClass = 'bg-warning';
                
                let paymentBadgeClass = order.paymentStatus === 'PAID' ? 'bg-success' : 'bg-warning';
                
                html += '<tr>' +
                    '<td>#' + order.orderId + '</td>' +
                    '<td>' + (order.customerName || 'Customer #' + order.customerId) + '</td>' +
                    '<td>' + formattedDate + '</td>' +
                    '<td>' + (order.itemCount || 0) + '</td>' +
                    '<td><i class="fas fa-rupee-sign"></i> ' + 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2}).format(order.totalAmount || 0) + '</td>' +
                    '<td><span class="badge ' + statusBadgeClass + '">' + order.orderStatus + '</span></td>' +
                    '<td><span class="badge ' + paymentBadgeClass + '">' + order.paymentStatus + '</span></td>' +
                    '<td><a href="/admin/order/details?orderId=' + order.orderId + '" class="btn btn-sm btn-info" title="View">' +
                    '<i class="fas fa-eye"></i></a></td>' +
                    '</tr>';
            });
            
            html += '</tbody></table></div>';
            tabPane.innerHTML = html;
        })
        .catch(error => {
            console.error('Error loading orders:', error);
            tabPane.innerHTML = '<div class="text-center p-4 text-danger">Error loading orders</div>';
        });
}
</script>

<style>
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        transition: transform 0.2s;
    }
    
    .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .nav-tabs .nav-link {
        color: #495057;
        font-weight: 500;
    }
    
    .nav-tabs .nav-link.active {
        color: #007bff;
        font-weight: 600;
    }
</style>

<%@ include file="footer.jsp" %>