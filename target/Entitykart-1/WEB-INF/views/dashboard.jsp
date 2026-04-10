<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <!-- Welcome Card -->
    <div class="welcome-card">
        <h2>Welcome back, ${currentUser.name}!</h2>
        <p>Here's what's happening with your store today. Last login: <fmt:formatDate value="${sessionScope.lastLoginTime}" pattern="dd MMM yyyy, hh:mm a"/></p>
    </div>
    
    <!-- Statistics Cards -->
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
    
    <!-- Charts Row -->
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
                    <canvas id="orderStatusChart" height="300"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Recent Orders -->
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
    
    <!-- Quick Stats Row -->
    <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between mb-2">
                    <h6 class="text-muted">Total Products</h6>
                    <span class="badge bg-primary">+${newProducts}</span>
                </div>
                <h4>${totalProducts}</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-primary" style="width: 75%"></div>
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
                    <h6 class="text-muted">Return Requests</h6>
                    <span class="badge bg-warning">${statistics.REQUESTED != null ? statistics.REQUESTED : 0}</span>
                </div>
                <h4>${statistics.REQUESTED != null ? statistics.REQUESTED : 0}</h4>
                <div class="progress mt-2" style="height: 5px;">
                    <div class="progress-bar bg-warning" style="width: 30%"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Revenue Chart
    const ctx1 = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctx1, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Revenue',
                data: [45000, 52000, 48000, 60000, 58000, 65000, 72000, 80000, 78000, 85000, 92000, 110000],
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            }
        }
    });
    
    // Order Status Chart
    const ctx2 = document.getElementById('orderStatusChart').getContext('2d');
    new Chart(ctx2, {
        type: 'doughnut',
        data: {
            labels: ['Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled', 'Returned'],
            datasets: [{
                data: [${placedOrders}, ${confirmedOrders}, ${shippedOrders}, ${deliveredOrders}, ${cancelledOrders}, ${returnedOrders}],
                backgroundColor: ['#ffc107', '#17a2b8', '#007bff', '#28a745', '#dc3545', '#6c757d']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>

<%@ include file="footer.jsp" %>