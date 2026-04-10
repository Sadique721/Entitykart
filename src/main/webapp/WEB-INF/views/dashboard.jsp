<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <!-- Welcome Card -->
    <div class="welcome-card">
        <h2>Welcome back, ${currentUser.name}!</h2>
        <p>Here's what's happening with your store today. Last login: <fmt:formatDate value="${sessionScope.lastLoginTime}" pattern="dd MMM yyyy, hh:mm a"/></p>
    </div>

    <!-- Statistics Cards Row 1 -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Orders</p>
                    <h3 class="mb-0">${totalOrders}</h3>
                    <small class="text-success"><i class="fas fa-arrow-up"></i> +12% from last month</small>
                </div>
                <div class="bg-primary bg-opacity-10 p-3 rounded">
                    <i class="fas fa-shopping-cart fa-2x text-primary"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Pending Orders</p>
                    <h3 class="mb-0">${pendingOrders}</h3>
                    <small class="text-warning"><i class="fas fa-clock"></i> Need attention</small>
                </div>
                <div class="bg-warning bg-opacity-10 p-3 rounded">
                    <i class="fas fa-clock fa-2x text-warning"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Revenue</p>
                    <h3 class="mb-0"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></h3>
                    <small class="text-success"><i class="fas fa-arrow-up"></i> +8% from last month</small>
                </div>
                <div class="bg-success bg-opacity-10 p-3 rounded">
                    <i class="fas fa-money-bill-wave fa-2x text-success"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Users</p>
                    <h3 class="mb-0">${totalUsers}</h3>
                    <small class="text-info"><i class="fas fa-user-plus"></i> +${newUsers} this week</small>
                </div>
                <div class="bg-info bg-opacity-10 p-3 rounded">
                    <i class="fas fa-users fa-2x text-info"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards Row 2 (Additional Entities) -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Products</p>
                    <h3 class="mb-0" id="totalProducts">${totalProducts}</h3>
                    <small class="text-success">In Stock: <span id="inStockCount">${inStockCount}</span></small>
                </div>
                <div class="bg-primary bg-opacity-10 p-3 rounded">
                    <i class="fas fa-boxes fa-2x text-primary"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Payments</p>
                    <h3 class="mb-0" id="totalPayments">--</h3>
                    <small class="text-success">Success Rate: <span id="successRate">--</span>%</small>
                </div>
                <div class="bg-success bg-opacity-10 p-3 rounded">
                    <i class="fas fa-credit-card fa-2x text-success"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Return Requests</p>
                    <h3 class="mb-0">${statistics.REQUESTED != null ? statistics.REQUESTED : 0}</h3>
                    <small class="text-warning">Pending Approval</small>
                </div>
                <div class="bg-warning bg-opacity-10 p-3 rounded">
                    <i class="fas fa-undo-alt fa-2x text-warning"></i>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card d-flex justify-content-between align-items-center">
                <div>
                    <p class="text-muted mb-1">Total Reviews</p>
                    <h3 class="mb-0" id="totalReviews">--</h3>
                    <small class="text-info">Avg Rating: <span id="avgRating">--</span> / 5</small>
                </div>
                <div class="bg-info bg-opacity-10 p-3 rounded">
                    <i class="fas fa-star fa-2x text-info"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 1 -->
    <div class="row mb-4">
        <div class="col-lg-8 mb-4">
            <div class="card">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Revenue Overview</h5>
                    <select class="form-select form-select-sm w-auto" id="revenuePeriod">
                        <option value="7">Last 7 Days</option>
                        <option value="30" selected>Last 30 Days</option>
                        <option value="90">Last 90 Days</option>
                    </select>
                </div>
                <div class="card-body">
                    <canvas id="revenueChart" height="300"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-4 mb-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Order Status</h5>
                </div>
                <div class="card-body">
                    <canvas id="orderStatusChart" height="280"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 2 -->
    <div class="row mb-4">
        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Payment Mode Distribution</h5>
                </div>
                <div class="card-body">
                    <canvas id="paymentModeChart" height="280"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i>Product Category Distribution</h5>
                </div>
                <div class="card-body">
                    <canvas id="categoryDistributionChart" height="280"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 3 -->
    <div class="row mb-4">
        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-star me-2 text-primary"></i>Rating Distribution</h5>
                </div>
                <div class="card-body">
                    <canvas id="ratingDistributionChart" height="280"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Return Status</h5>
                </div>
                <div class="card-body">
                    <canvas id="returnStatusChart" height="280"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Orders Table -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0"><i class="fas fa-clock me-2 text-primary"></i>Recent Orders</h5>
                    <a href="/admin/orders" class="btn btn-sm btn-primary">View All</a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Payment</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${recentOrders}" end="4">
                                <tr>
                                    <td><strong>#${order.orderId}</strong></td>
                                    <td>${order.customerId}</td>
                                    <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy"/></td>
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
                                        <a href="/admin/order/details?orderId=${order.orderId}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats Row (Additional) -->
    <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between mb-2">
                    <h6 class="text-muted">Low Stock Products</h6>
                    <span class="badge bg-danger" id="lowStockCount">--</span>
                </div>
                <h4 id="lowStockCountVal">--</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-danger" id="lowStockProgress" style="width: 0%"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between mb-2">
                    <h6 class="text-muted">Categories</h6>
                    <span class="badge bg-success">${categoryList.size()}</span>
                </div>
                <h4>${categoryList.size()}</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-success" style="width: 60%"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between mb-2">
                    <h6 class="text-muted">Sub Categories</h6>
                    <span class="badge bg-info">${subCategories.size()}</span>
                </div>
                <h4>${subCategories.size()}</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-info" style="width: 45%"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between mb-2">
                    <h6 class="text-muted">Products with Reviews</h6>
                    <span class="badge bg-primary" id="productsWithReviews">--</span>
                </div>
                <h4 id="productsWithReviewsVal">--</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-primary" id="reviewProductProgress" style="width: 0%"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Global chart instances
    let revenueChart, orderStatusChart, paymentModeChart, categoryChart, ratingChart, returnChart;

    // Helper to fetch API data
    async function fetchJSON(url) {
        try {
            const response = await fetch(url);
            if (!response.ok) throw new Error('Network error');
            return await response.json();
        } catch (error) {
            console.error(`Error fetching ${url}:`, error);
            return null;
        }
    }

    // Update stat cards and charts with API data
    async function loadDashboardData() {
        // Payment Summary
        const paymentSummary = await fetchJSON('/api/admin/payment-summary');
        if (paymentSummary) {
            document.getElementById('totalPayments').innerText = paymentSummary.totalPayments || 0;
            document.getElementById('successRate').innerText = paymentSummary.successRate ? paymentSummary.successRate.toFixed(1) : '0';
            // Payment Mode Chart
            if (paymentSummary.revenueByMode) {
                const modes = Object.keys(paymentSummary.revenueByMode);
                const revenues = Object.values(paymentSummary.revenueByMode);
                if (paymentModeChart) paymentModeChart.destroy();
                const ctxMode = document.getElementById('paymentModeChart').getContext('2d');
                paymentModeChart = new Chart(ctxMode, {
                    type: 'pie',
                    data: {
                        labels: modes,
                        datasets: [{ data: revenues, backgroundColor: ['#007bff', '#28a745', '#ffc107', '#17a2b8', '#6c757d'] }]
                    },
                    options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom' } } }
                });
            }
        }

        // Product Stats
        const productStats = await fetchJSON('/api/admin/product-stats');
        if (productStats) {
            document.getElementById('totalProducts').innerText = productStats.totalProducts || 0;
            document.getElementById('inStockCount').innerText = productStats.inStockCount || 0;
            document.getElementById('lowStockCount').innerText = productStats.lowStockCount || 0;
            document.getElementById('lowStockCountVal').innerText = productStats.lowStockCount || 0;
            const lowStockPercent = productStats.totalProducts ? (productStats.lowStockCount / productStats.totalProducts * 100) : 0;
            document.getElementById('lowStockProgress').style.width = lowStockPercent + '%';
        }

        // Category Distribution for Products
        const categoryDist = await fetchJSON('/api/admin/products/category-distribution');
        if (categoryDist && categoryDist.length) {
            const catNames = categoryDist.map(c => c.name);
            const catCounts = categoryDist.map(c => c.count);
            if (categoryChart) categoryChart.destroy();
            const ctxCat = document.getElementById('categoryDistributionChart').getContext('2d');
            categoryChart = new Chart(ctxCat, {
                type: 'bar',
                data: {
                    labels: catNames,
                    datasets: [{ label: 'Number of Products', data: catCounts, backgroundColor: '#667eea' }]
                },
                options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } } }
            });
        }

        // Review Stats
        const reviewStats = await fetchJSON('/api/admin/review-stats');
        if (reviewStats) {
            document.getElementById('totalReviews').innerText = reviewStats.totalReviews || 0;
            document.getElementById('avgRating').innerText = reviewStats.avgRating ? reviewStats.avgRating.toFixed(1) : '0';
            document.getElementById('productsWithReviews').innerText = reviewStats.productsWithReviews || 0;
            document.getElementById('productsWithReviewsVal').innerText = reviewStats.productsWithReviews || 0;
            const reviewProductPercent = productStats && productStats.totalProducts ? (reviewStats.productsWithReviews / productStats.totalProducts * 100) : 0;
            document.getElementById('reviewProductProgress').style.width = reviewProductPercent + '%';
        }

        // Rating Distribution
        const ratingDist = await fetchJSON('/api/admin/rating-distribution');
        if (ratingDist) {
            const ratings = ['1 Star', '2 Star', '3 Star', '4 Star', '5 Star'];
            const counts = [ratingDist.oneStar, ratingDist.twoStar, ratingDist.threeStar, ratingDist.fourStar, ratingDist.fiveStar];
            if (ratingChart) ratingChart.destroy();
            const ctxRating = document.getElementById('ratingDistributionChart').getContext('2d');
            ratingChart = new Chart(ctxRating, {
                type: 'bar',
                data: {
                    labels: ratings,
                    datasets: [{ label: 'Number of Reviews', data: counts, backgroundColor: '#ffc107' }]
                },
                options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } } }
            });
        }

        // Return Stats
        const returnStats = await fetchJSON('/api/admin/return-stats');
        if (returnStats) {
            const returnStatuses = ['REQUESTED', 'APPROVED', 'REJECTED', 'REFUNDED'];
            const returnCounts = [
                returnStats.requestedcount || 0,
                returnStats.approvedcount || 0,
                returnStats.rejectedcount || 0,
                returnStats.refundedcount || 0
            ];
            if (returnChart) returnChart.destroy();
            const ctxReturn = document.getElementById('returnStatusChart').getContext('2d');
            returnChart = new Chart(ctxReturn, {
                type: 'pie',
                data: {
                    labels: returnStatuses,
                    datasets: [{ data: returnCounts, backgroundColor: ['#ffc107', '#28a745', '#dc3545', '#17a2b8'] }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom' } } }
            });
            document.getElementById('pendingReturns').innerText = returnStats.requestedcount || 0;
        }
    }

    // Revenue Chart with dynamic period
    async function loadRevenueChart(period = 30) {
        const data = await fetchJSON(`/api/admin/payment-summary`);
        if (data && data.dailyRevenue && data.dailyRevenue.length) {
            const dates = data.dailyRevenue.map(d => d.date);
            const revenues = data.dailyRevenue.map(d => d.revenue);
            if (revenueChart) revenueChart.destroy();
            const ctx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: dates,
                    datasets: [{
                        label: 'Daily Revenue (₹)',
                        data: revenues,
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false }
            });
        } else {
            // Fallback mock data
            const labels = Array.from({length: period}, (_, i) => `Day ${i+1}`);
            const mockData = labels.map(() => Math.floor(Math.random() * 5000) + 1000);
            if (revenueChart) revenueChart.destroy();
            const ctx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{ label: 'Revenue (₹)', data: mockData, borderColor: '#667eea', tension: 0.4, fill: true }]
                },
                options: { responsive: true, maintainAspectRatio: false }
            });
        }
    }

    // Order Status Chart (using server-side data)
    function initOrderStatusChart() {
        const ctx = document.getElementById('orderStatusChart').getContext('2d');
        orderStatusChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled', 'Returned'],
                datasets: [{
                    data: [${placedOrders}, ${confirmedOrders}, ${shippedOrders}, ${deliveredOrders}, ${cancelledOrders}, ${returnedOrders}],
                    backgroundColor: ['#ffc107', '#17a2b8', '#007bff', '#28a745', '#dc3545', '#6c757d']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom' } } }
        });
    }

    // Event listener for revenue period dropdown
    document.getElementById('revenuePeriod').addEventListener('change', function(e) {
        loadRevenueChart(parseInt(e.target.value));
    });

    // Initialize all charts and data
    document.addEventListener('DOMContentLoaded', function() {
        initOrderStatusChart();
        loadRevenueChart(30);
        loadDashboardData();
    });
</script>
 
<%@ include file="footer.jsp" %>