<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-heart me-2 text-danger"></i>Wishlist Statistics</h2>
                <button class="btn btn-outline-primary" onclick="refreshStats()">
                    <i class="fas fa-sync-alt me-2"></i>Refresh Stats
                </button>
            </div>

            <!-- Action Buttons (Export) -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/export/wishlist/excel" class="btn btn-success">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/export/wishlist/word" class="btn btn-primary">
                                <i class="fas fa-file-word"></i> Export to Word
                            </a>
                            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="wishlist">
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
                <div class="col-md-4">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Wishlist Items</h6>
                            <h3 id="totalItems">${totalItems}</h3>
                        </div>
                        <i class="fas fa-heart fa-2x text-danger"></i>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Users with Wishlist</h6>
                            <h3 id="usersWithWishlist">${usersWithWishlist}</h3>
                        </div>
                        <i class="fas fa-users fa-2x text-primary"></i>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Avg Wishlist Size</h6>
                            <h3 id="avgWishlistSize">${avgWishlistSize}</h3>
                        </div>
                        <i class="fas fa-chart-bar fa-2x text-success"></i>
                    </div>
                </div>
            </div>
            
            <!-- Most Wishlisted Products -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-crown me-2 text-warning"></i>Most Wishlisted Products</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Wishlist Count</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${topProducts}" varStatus="loop">
                                    <tr>
                                        <td>
                                            <img src="${product.image != null ? product.image : 'https://via.placeholder.com/50'}" 
                                                 width="50" height="50" class="rounded" style="object-fit: cover;">
                                        </td>
                                        <td>
                                            <strong>${product.productName}</strong>
                                            <br>
                                            <small class="text-muted">ID: #${product.productId}</small>
                                        </td>
                                        <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                                        <td>
                                            <span class="badge bg-warning text-dark fs-6">
                                                <i class="fas fa-heart me-1"></i>${product.wishlistCount}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="/admin/product/view/${product.productId}" class="btn btn-sm btn-info">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty topProducts}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4">
                                            <i class="fas fa-heart-broken fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No wishlist data available</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Wishlist Trends (Placeholder for Chart) -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Wishlist Trends</h5>
                </div>
                <div class="card-body">
                    <canvas id="wishlistChart" style="height: 300px;"></canvas>
                </div>
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

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

function refreshStats() {
    fetch('/api/admin/wishlist-stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('totalItems').textContent = data.totalItems || 0;
            document.getElementById('usersWithWishlist').textContent = data.usersWithWishlist || 0;
            document.getElementById('avgWishlistSize').textContent = (data.avgWishlistSize || 0).toFixed(1);
        })
        .catch(error => console.error('Error refreshing stats:', error));
}

// Initialize chart
document.addEventListener('DOMContentLoaded', function() {
    const ctx = document.getElementById('wishlistChart').getContext('2d');
    
    // Sample data - replace with actual data from API
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const wishlistData = [65, 59, 80, 81, 56, 55, 40, 45, 70, 85, 90, 78];
    
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'New Wishlist Items',
                data: wishlistData,
                borderColor: '#dc3545',
                backgroundColor: 'rgba(220, 53, 69, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 20
                    }
                }
            }
        }
    });
});

// Auto-refresh every 30 seconds
setInterval(refreshStats, 30000);
</script>

<style>
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        transition: transform 0.2s;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .badge.fs-6 {
        font-size: 1rem !important;
        padding: 8px 12px;
    }
    
    .table td {
        vertical-align: middle;
    }
</style>

<%@ include file="footer.jsp" %>