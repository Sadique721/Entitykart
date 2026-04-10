<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header with Stats Refresh -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-star me-2" style="color: #ffc107;"></i>Review Management</h2>
                <div>
                    <span class="badge bg-light text-dark me-2" id="lastUpdated">
                        <i class="fas fa-clock me-1"></i>Last Updated: Just now
                    </span>
                    <button class="btn btn-outline-primary" onclick="refreshAllData()">
                        <i class="fas fa-sync-alt me-2"></i>Refresh Dashboard
                    </button>
                </div>
            </div>

            <!-- Action Buttons (Export) -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/export/reviews/excel" class="btn btn-success">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/export/reviews/word" class="btn btn-primary">
                                <i class="fas fa-file-word"></i> Export to Word
                            </a>
                            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="reviews">
                                <i class="fas fa-envelope"></i> Email Report
                            </button>
                            <button class="btn btn-outline-primary" onclick="refreshAllData()">
                                <i class="fas fa-sync-alt"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Statistics Cards Row -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card primary">
                        <div class="stat-card-body">
                            <div class="stat-card-icon">
                                <i class="fas fa-star"></i>
                            </div>
                            <div class="stat-card-content">
                                <h6 class="stat-card-title">Total Reviews</h6>
                                <h3 class="stat-card-value" id="totalReviews">${totalReviews}</h3>
                                <p class="stat-card-footer">
                                    <span class="text-success">
                                        <i class="fas fa-arrow-up"></i> ${totalReviews > 0 ? 'Active' : 'No'} reviews
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card warning">
                        <div class="stat-card-body">
                            <div class="stat-card-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="stat-card-content">
                                <h6 class="stat-card-title">Average Rating</h6>
                                <h3 class="stat-card-value" id="avgRating">${overallAvgRating != null ? overallAvgRating : '0.0'}</h3>
                                <p class="stat-card-footer">
                                    <span class="text-warning">
                                        <c:choose>
                                            <c:when test="${overallAvgRating >= 4.5}">Excellent</c:when>
                                            <c:when test="${overallAvgRating >= 4.0}">Very Good</c:when>
                                            <c:when test="${overallAvgRating >= 3.0}">Good</c:when>
                                            <c:when test="${overallAvgRating >= 2.0}">Average</c:when>
                                            <c:otherwise>Needs Improvement</c:otherwise>
                                        </c:choose>
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card success">
                        <div class="stat-card-body">
                            <div class="stat-card-icon">
                                <i class="fas fa-box"></i>
                            </div>
                            <div class="stat-card-content">
                                <h6 class="stat-card-title">Products with Reviews</h6>
                                <h3 class="stat-card-value" id="productsWithReviews">${productsWithReviews != null ? productsWithReviews : '0'}</h3>
                                <p class="stat-card-footer">
                                    <span class="text-success">
                                        <i class="fas fa-percentage"></i> 
                                        ${totalProducts > 0 ? Math.round((productsWithReviews / totalProducts) * 100) : 0}% of products
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card info">
                        <div class="stat-card-body">
                            <div class="stat-card-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-card-content">
                                <h6 class="stat-card-title">Active Reviewers</h6>
                                <h3 class="stat-card-value" id="activeReviewers">${activeReviewers != null ? activeReviewers : '0'}</h3>
                                <p class="stat-card-footer">
                                    <span class="text-info">
                                        <i class="fas fa-user-check"></i> Unique customers
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row -->
            <div class="row mb-4">
                <!-- Rating Distribution Pie Chart -->
                <div class="col-xl-6 col-lg-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Rating Distribution</h5>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary" type="button" onclick="refreshPieChart()">
                                    <i class="fas fa-redo-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container" style="position: relative; height: 300px; width: 100%;">
                                <canvas id="ratingPieChart"></canvas>
                            </div>
                            <div class="row mt-3 text-center">
                                <div class="col-4">
                                    <div class="rating-stat">
                                        <span class="badge bg-success rounded-pill p-2" id="fiveStarCount">0</span>
                                        <small class="d-block text-muted">5 Star</small>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="rating-stat">
                                        <span class="badge bg-info rounded-pill p-2" id="fourStarCount">0</span>
                                        <small class="d-block text-muted">4 Star</small>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="rating-stat">
                                        <span class="badge bg-primary rounded-pill p-2" id="threeStarCount">0</span>
                                        <small class="d-block text-muted">3 Star</small>
                                    </div>
                                </div>
                                <div class="col-4 mt-2">
                                    <div class="rating-stat">
                                        <span class="badge bg-warning rounded-pill p-2" id="twoStarCount">0</span>
                                        <small class="d-block text-muted">2 Star</small>
                                    </div>
                                </div>
                                <div class="col-4 mt-2">
                                    <div class="rating-stat">
                                        <span class="badge bg-danger rounded-pill p-2" id="oneStarCount">0</span>
                                        <small class="d-block text-muted">1 Star</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Monthly Review Trend Line Chart -->
                <div class="col-xl-6 col-lg-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-success"></i>Monthly Review Trend</h5>
                            <div>
                                <select class="form-select form-select-sm" id="yearSelect" style="width: auto;" onchange="loadMonthlyData()">
                                    <option value="2025">2025</option>
                                    <option value="2024">2024</option>
                                    <option value="2023">2023</option>
                                </select>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container" style="position: relative; height: 250px; width: 100%;">
                                <canvas id="monthlyTrendChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Section -->
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-filter me-2 text-secondary"></i>Filter Reviews</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/reviews" method="get" class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Filter by Product</label>
                            <select name="productId" class="form-select">
                                <option value="">All Products</option>
                                <c:forEach var="product" items="${allProducts}">
                                    <option value="${product.productId}" ${filterProduct.productId == product.productId ? 'selected' : ''}>
                                        ${product.productName} (ID: ${product.productId})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2 align-self-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Apply Filter
                            </button>
                        </div>
                        <div class="col-md-2 align-self-end">
                            <a href="/admin/reviews" class="btn btn-outline-secondary w-100">
                                <i class="fas fa-times me-2"></i>Clear Filter
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Reviews Table Section -->
            <div class="card shadow-sm">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>All Reviews</h5>
                    <span class="badge bg-primary">${totalElements} Reviews Found</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Product</th>
                                    <th>Customer</th>
                                    <th>Rating</th>
                                    <th>Review</th>
                                    <th>Date</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty reviews}">
                                        <tr>
                                            <td colspan="7" class="text-center py-5">
                                                <i class="fas fa-star fa-3x text-muted mb-3"></i>
                                                <h5 class="text-muted">No reviews found</h5>
                                                <p class="text-muted">There are no reviews matching your criteria.</p>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="item" items="${reviews}">
                                            <c:set var="review" value="${item.review}" />
                                            <c:set var="user" value="${item.user}" />
                                            <c:set var="product" value="${item.product}" />
                                            
                                            <tr>
                                                <td><span class="fw-semibold">#${review.reviewId}</span></td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/50x50?text=No+Image'}" 
                                                             width="50" height="50" class="rounded me-3" style="object-fit: cover; border: 1px solid #eee;">
                                                        <div>
                                                            <div class="fw-semibold">${product.productName}</div>
                                                            <small class="text-muted">ID: ${product.productId}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${not empty user.profilePicURL}">
                                                                <img src="${user.profilePicURL}" width="35" height="35" 
                                                                     class="rounded-circle me-2" style="object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="rounded-circle bg-secondary bg-opacity-10 d-flex align-items-center justify-content-center me-2" 
                                                                     style="width: 35px; height: 35px;">
                                                                    <i class="fas fa-user text-secondary"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div>
                                                            <div class="fw-semibold">${user.name}</div>
                                                            <small class="text-muted">${user.email}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted opacity-25'}"></i>
                                                        </c:forEach>
                                                        <br>
                                                        <span class="badge bg-warning text-dark mt-1">${review.rating}/5</span>
                                                    </div>
                                                </td>
                                                <td style="max-width: 250px;">
                                                    <div class="review-text" title="${review.comment}">
                                                        <c:choose>
                                                            <c:when test="${review.comment.length() > 80}">
                                                                ${review.comment.substring(0, 77)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${review.comment}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div><fmt:formatDate value="${review.createdAtAsDate}" pattern="dd MMM yyyy"/></div>
                                                    <small class="text-muted"><fmt:formatDate value="${review.createdAtAsDate}" pattern="hh:mm a"/></small>
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group" role="group">
                                                        <a href="/product/reviews/${product.productId}" class="btn btn-sm btn-outline-info" title="View Product Reviews">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                onclick="confirmDelete(${review.reviewId}, '${user.name}')" title="Delete Review">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="card-footer bg-white">
                        <nav aria-label="Review pagination">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/reviews?page=${currentPage-1}&productId=${param.productId}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages-1}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="/admin/reviews?page=${i}&productId=${param.productId}">${i+1}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/reviews?page=${currentPage+1}&productId=${param.productId}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">
                    <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this review from <strong id="deleteUserName"></strong>?</p>
                <p class="text-danger mb-0"><small>This action cannot be undone.</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteForm" action="/admin/review/delete" method="post" style="display: inline;">
                    <input type="hidden" name="reviewId" id="deleteReviewId">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Delete Review
                    </button>
                </form>
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

// Chart instances
let pieChart, trendChart;

// Initialize charts on page load
document.addEventListener('DOMContentLoaded', function() {
    initializePieChart();
    initializeTrendChart();
    loadRatingDistribution();
});

// Initialize Pie Chart with empty data
function initializePieChart() {
    const ctx = document.getElementById('ratingPieChart').getContext('2d');
    pieChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['5 Star', '4 Star', '3 Star', '2 Star', '1 Star'],
            datasets: [{
                data: [0, 0, 0, 0, 0],
                backgroundColor: [
                    '#28a745',  // 5 Star - Green
                    '#17a2b8',  // 4 Star - Teal
                    '#007bff',  // 3 Star - Blue
                    '#ffc107',  // 2 Star - Yellow
                    '#dc3545'   // 1 Star - Red
                ],
                borderWidth: 2,
                borderColor: '#ffffff',
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '60%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        usePointStyle: true,
                        padding: 20
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            let value = context.raw || 0;
                            let total = context.dataset.data.reduce((a, b) => a + b, 0);
                            let percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                            return `${label}: ${value} (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });
}

// Initialize Trend Chart
function initializeTrendChart() {
    const ctx = document.getElementById('monthlyTrendChart').getContext('2d');
    trendChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Number of Reviews',
                data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                borderColor: '#28a745',
                borderWidth: 3,
                tension: 0.3,
                fill: true,
                pointBackgroundColor: '#28a745',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

// Load rating distribution data
function loadRatingDistribution() {
    fetch('/api/admin/rating-distribution')
        .then(response => response.json())
        .then(data => {
            // Update pie chart
            pieChart.data.datasets[0].data = [
                data.fiveStar || 0,
                data.fourStar || 0,
                data.threeStar || 0,
                data.twoStar || 0,
                data.oneStar || 0
            ];
            pieChart.update();
            
            // Update stat badges
            document.getElementById('fiveStarCount').textContent = data.fiveStar || 0;
            document.getElementById('fourStarCount').textContent = data.fourStar || 0;
            document.getElementById('threeStarCount').textContent = data.threeStar || 0;
            document.getElementById('twoStarCount').textContent = data.twoStar || 0;
            document.getElementById('oneStarCount').textContent = data.oneStar || 0;
            
            // Update stats cards
            document.getElementById('totalReviews').textContent = data.totalReviews || 0;
            document.getElementById('avgRating').textContent = (data.avgRating || 0).toFixed(1);
            document.getElementById('productsWithReviews').textContent = data.productsWithReviews || 0;
            document.getElementById('activeReviewers').textContent = data.activeReviewers || 0;
        })
        .catch(error => {
            console.error('Error loading rating distribution:', error);
            // Fallback to server-side data
            updateFromServerData();
        });
}

// Load monthly trend data
function loadMonthlyData() {
    const year = document.getElementById('yearSelect').value;
    
    fetch(`/api/admin/monthly-reviews?year=${year}`)
        .then(response => response.json())
        .then(data => {
            trendChart.data.datasets[0].data = data.monthlyData || Array(12).fill(0);
            trendChart.update();
        })
        .catch(error => {
            console.error('Error loading monthly data:', error);
        });
}

// Fallback to server-side data
function updateFromServerData() {
    // This function would use the data already in the JSP model
    <c:if test="${not empty ratingDistribution}">
        pieChart.data.datasets[0].data = [
            ${ratingDistribution.fiveStar != null ? ratingDistribution.fiveStar : 0},
            ${ratingDistribution.fourStar != null ? ratingDistribution.fourStar : 0},
            ${ratingDistribution.threeStar != null ? ratingDistribution.threeStar : 0},
            ${ratingDistribution.twoStar != null ? ratingDistribution.twoStar : 0},
            ${ratingDistribution.oneStar != null ? ratingDistribution.oneStar : 0}
        ];
        pieChart.update();
        
        document.getElementById('fiveStarCount').textContent = '${ratingDistribution.fiveStar != null ? ratingDistribution.fiveStar : 0}';
        document.getElementById('fourStarCount').textContent = '${ratingDistribution.fourStar != null ? ratingDistribution.fourStar : 0}';
        document.getElementById('threeStarCount').textContent = '${ratingDistribution.threeStar != null ? ratingDistribution.threeStar : 0}';
        document.getElementById('twoStarCount').textContent = '${ratingDistribution.twoStar != null ? ratingDistribution.twoStar : 0}';
        document.getElementById('oneStarCount').textContent = '${ratingDistribution.oneStar != null ? ratingDistribution.oneStar : 0}';
    </c:if>
}

// Refresh all data
function refreshAllData() {
    document.getElementById('lastUpdated').innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Updating...';
    
    Promise.all([
        fetch('/api/admin/review-stats').then(res => res.json()),
        fetch('/api/admin/rating-distribution').then(res => res.json()),
        fetch(`/api/admin/monthly-reviews?year=${document.getElementById('yearSelect').value}`).then(res => res.json())
    ])
    .then(([stats, ratingData, monthlyData]) => {
        // Update stats
        document.getElementById('totalReviews').textContent = stats.totalReviews || 0;
        document.getElementById('avgRating').textContent = (stats.avgRating || 0).toFixed(1);
        document.getElementById('productsWithReviews').textContent = stats.productsWithReviews || 0;
        document.getElementById('activeReviewers').textContent = stats.activeReviewers || 0;
        
        // Update pie chart
        pieChart.data.datasets[0].data = [
            ratingData.fiveStar || 0,
            ratingData.fourStar || 0,
            ratingData.threeStar || 0,
            ratingData.twoStar || 0,
            ratingData.oneStar || 0
        ];
        pieChart.update();
        
        // Update rating counts
        document.getElementById('fiveStarCount').textContent = ratingData.fiveStar || 0;
        document.getElementById('fourStarCount').textContent = ratingData.fourStar || 0;
        document.getElementById('threeStarCount').textContent = ratingData.threeStar || 0;
        document.getElementById('twoStarCount').textContent = ratingData.twoStar || 0;
        document.getElementById('oneStarCount').textContent = ratingData.oneStar || 0;
        
        // Update trend chart
        trendChart.data.datasets[0].data = monthlyData.monthlyData || Array(12).fill(0);
        trendChart.update();
        
        document.getElementById('lastUpdated').innerHTML = '<i class="fas fa-clock me-1"></i>Last Updated: Just now';
    })
    .catch(error => {
        console.error('Error refreshing data:', error);
        document.getElementById('lastUpdated').innerHTML = '<i class="fas fa-exclamation-triangle text-danger me-1"></i>Update failed';
    });
}

// Refresh just pie chart
function refreshPieChart() {
    loadRatingDistribution();
}

// Confirm delete
function confirmDelete(reviewId, userName) {
    document.getElementById('deleteReviewId').value = reviewId;
    document.getElementById('deleteUserName').textContent = userName;
    
    var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    deleteModal.show();
}

// Auto-refresh every 60 seconds
setInterval(refreshAllData, 60000);
</script>

<!-- Additional CSS -->
<style>
    .stat-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
        border-left: 4px solid;
        height: 100%;
    }
    
    .stat-card.primary { border-left-color: #007bff; }
    .stat-card.warning { border-left-color: #ffc107; }
    .stat-card.success { border-left-color: #28a745; }
    .stat-card.info { border-left-color: #17a2b8; }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    }
    
    .stat-card-body {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .stat-card-icon {
        width: 60px;
        height: 60px;
        background: rgba(0,0,0,0.03);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    
    .stat-card.primary .stat-card-icon { color: #007bff; }
    .stat-card.warning .stat-card-icon { color: #ffc107; }
    .stat-card.success .stat-card-icon { color: #28a745; }
    .stat-card.info .stat-card-icon { color: #17a2b8; }
    
    .stat-card-content {
        flex: 1;
    }
    
    .stat-card-title {
        color: #6c757d;
        font-size: 14px;
        margin-bottom: 5px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .stat-card-value {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 5px;
        color: #2c3e50;
    }
    
    .stat-card-footer {
        font-size: 12px;
        margin-bottom: 0;
    }
    
    .rating-stat {
        background: #f8f9fa;
        padding: 10px;
        border-radius: 10px;
    }
    
    .rating-stars i {
        margin-right: 2px;
    }
    
    .review-text {
        color: #4a5568;
        line-height: 1.5;
    }
    
    .chart-container {
        margin-bottom: 15px;
    }
    
    .table th {
        font-weight: 600;
        color: #495057;
        border-top: none;
    }
    
    .btn-group .btn {
        padding: 0.25rem 0.5rem;
    }
    
    .badge {
        font-weight: 500;
        padding: 0.5em 1em;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .stat-card-body {
            flex-direction: column;
            text-align: center;
        }
        
        .stat-card-icon {
            margin-bottom: 10px;
        }
        
        .d-flex.align-items-center {
            flex-direction: column;
            text-align: center;
        }
        
        .d-flex.align-items-center img {
            margin-bottom: 10px;
            margin-right: 0 !important;
        }
    }
</style>

<%@ include file="footer.jsp" %>