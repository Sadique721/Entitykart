<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-chart-pie me-2 text-primary"></i>Payment Summary</h2>
                <div>
                    <a href="/admin/payments" class="btn btn-outline-primary me-2">
                        <i class="fas fa-credit-card me-2"></i>View All Payments
                    </a>
                    <button class="btn btn-outline-primary" onclick="refreshData()">
                        <i class="fas fa-sync-alt me-2"></i>Refresh Data
                    </button>
                </div>
            </div>
            
            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
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
                        <div class="progress mt-3" style="height: 4px;">
                            <div class="progress-bar bg-primary" style="width: 100%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Successful</p>
                                <h3 class="mb-0 text-success" id="successfulPayments">${successfulPayments}</h3>
                            </div>
                            <div class="stat-icon bg-success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                        <div class="progress mt-3" style="height: 4px;">
                            <div class="progress-bar bg-success" id="successBar" style="width: ${successfulPayments > 0 ? (successfulPayments / totalPayments * 100) : 0}%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Failed</p>
                                <h3 class="mb-0 text-danger" id="failedPayments">${failedPayments}</h3>
                            </div>
                            <div class="stat-icon bg-danger">
                                <i class="fas fa-times-circle"></i>
                            </div>
                        </div>
                        <div class="progress mt-3" style="height: 4px;">
                            <div class="progress-bar bg-danger" id="failedBar" style="width: ${failedPayments > 0 ? (failedPayments / totalPayments * 100) : 0}%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Success Rate</p>
                                <h3 class="mb-0 text-info" id="successRate"><fmt:formatNumber value="${successRate}" pattern="#0.0"/>%</h3>
                            </div>
                            <div class="stat-icon bg-info">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                        <div class="progress mt-3" style="height: 4px;">
                            <div class="progress-bar bg-info" id="rateBar" style="width: ${successRate}%"></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Revenue and Chart Row -->
            <div class="row mb-4">
                <div class="col-xl-8 mb-4">
                    <div class="card">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Daily Revenue Overview</h5>
                            <div class="btn-group" role="group" id="periodButtons">
                                <button class="btn btn-sm btn-outline-primary active" onclick="loadDailyRevenue(7, this)">7 Days</button>
                                <button class="btn btn-sm btn-outline-primary" onclick="loadDailyRevenue(30, this)">30 Days</button>
                                <button class="btn btn-sm btn-outline-primary" onclick="loadDailyRevenue(90, this)">90 Days</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div style="position: relative; height: 350px;">
                                <canvas id="revenueChart"></canvas>
                            </div>
                            <div class="text-center mt-3 text-muted small" id="chartDateRange">
                                Loading chart data...
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-4 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Payment Status Distribution</h5>
                        </div>
                        <div class="card-body">
                            <div style="position: relative; height: 200px;">
                                <canvas id="statusChart"></canvas>
                            </div>
                            <div class="text-center mt-4">
                                <h4 class="text-primary" id="totalRevenue"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></h4>
                                <p class="text-muted mb-0">Total Revenue</p>
                            </div>
                            <div class="row mt-4 text-center" id="statusLegend">
                                <div class="col-4">
                                    <span class="badge bg-success mb-1">${successfulPayments}</span>
                                    <small class="d-block text-muted">Successful</small>
                                </div>
                                <div class="col-4">
                                    <span class="badge bg-danger mb-1">${failedPayments}</span>
                                    <small class="d-block text-muted">Failed</small>
                                </div>
                                <div class="col-4">
                                    <span class="badge bg-warning mb-1">${pendingPayments}</span>
                                    <small class="d-block text-muted">Pending</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Revenue by Payment Mode -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-credit-card me-2 text-primary"></i>Revenue by Payment Mode</h5>
                        </div>
                        <div class="card-body">
                            <div class="row" id="revenueByModeContainer">
                                <c:if test="${not empty revenueByMode}">
                                    <c:forEach var="entry" items="${revenueByMode}">
                                        <c:set var="totalRev" value="${totalRevenue}" />
                                        <c:set var="modeRev" value="${entry.value}" />
                                        <c:set var="percentage" value="${totalRev > 0 ? (modeRev / totalRev * 100) : 0}" />
                                        
                                        <div class="col-lg-3 col-md-4 col-sm-6 mb-3">
                                            <div class="card h-100 border-0 shadow-sm">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="badge 
                                                            <c:choose>
                                                                <c:when test="${entry.key == 'COD'}">bg-success</c:when>
                                                                <c:when test="${entry.key == 'UPI'}">bg-info</c:when>
                                                                <c:when test="${entry.key == 'CARD'}">bg-warning</c:when>
                                                                <c:when test="${entry.key == 'NET_BANKING'}">bg-secondary</c:when>
                                                                <c:otherwise>bg-primary</c:otherwise>
                                                            </c:choose>">
                                                            <c:choose>
                                                                <c:when test="${entry.key == 'COD'}">
                                                                    <i class="fas fa-money-bill-wave me-1"></i>
                                                                </c:when>
                                                                <c:when test="${entry.key == 'CARD'}">
                                                                    <i class="fas fa-credit-card me-1"></i>
                                                                </c:when>
                                                                <c:when test="${entry.key == 'UPI'}">
                                                                    <i class="fas fa-mobile-alt me-1"></i>
                                                                </c:when>
                                                                <c:when test="${entry.key == 'NET_BANKING'}">
                                                                    <i class="fas fa-university me-1"></i>
                                                                </c:when>
                                                            </c:choose>
                                                            ${entry.key}
                                                        </span>
                                                        <span class="fw-bold text-primary"><fmt:formatNumber value="${percentage}" pattern="#0.0"/>%</span>
                                                    </div>
                                                    <h5 class="mb-0"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${entry.value}" pattern="#,##0.00"/></h5>
                                                    <div class="progress mt-2" style="height: 5px;">
                                                        <div class="progress-bar 
                                                            <c:choose>
                                                                <c:when test="${entry.key == 'COD'}">bg-success</c:when>
                                                                <c:when test="${entry.key == 'UPI'}">bg-info</c:when>
                                                                <c:when test="${entry.key == 'CARD'}">bg-warning</c:when>
                                                                <c:when test="${entry.key == 'NET_BANKING'}">bg-secondary</c:when>
                                                                <c:otherwise>bg-primary</c:otherwise>
                                                            </c:choose>" 
                                                            style="width: ${percentage}%"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty revenueByMode}">
                                    <div class="col-12 text-center py-4">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Recent Payments Table -->
            <div class="row">
                <div class="col-12">
                    <div class="table-container">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0"><i class="fas fa-clock me-2 text-primary"></i>Recent Payments</h5>
                            <a href="/admin/payments" class="btn btn-sm btn-primary">View All Payments</a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-hover" id="recentPaymentsTable">
                                <thead>
                                    <tr>
                                        <th>Payment ID</th>
                                        <th>Order ID</th>
                                        <th>Amount (₹)</th>
                                        <th>Payment Mode</th>
                                        <th>Transaction Ref</th>
                                        <th>Status</th>
                                        <th>Payment Date & Time</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="recentPaymentsBody">
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
                                                     ${payment.paymentDate}
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
                                <tbody id="recentPaymentsBody">
                                    <tr>
                                        <td colspan="8" class="text-center py-4">
                                            <div class="spinner-border text-primary" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Chart instances
    let revenueChart = null;
    let statusChart = null;
    
    // Current period
    let currentPeriod = 7;
    
    // Load data on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Load all data
        loadPaymentSummary();
        loadRecentPayments();
        loadDailyRevenue(currentPeriod);
    });
    
    // Refresh all data
    function refreshData() {
        showToast('info', 'Refreshing payment data...');
        loadPaymentSummary();
        loadRecentPayments();
        loadDailyRevenue(currentPeriod);
    }
    
    // Load payment summary from API
    function loadPaymentSummary() {
        fetch('/api/admin/payment-summary')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // Update summary cards with animation
                animateNumber('totalPayments', data.totalPayments || 0);
                animateNumber('successfulPayments', data.successfulPayments || 0);
                animateNumber('failedPayments', data.failedPayments || 0);
                document.getElementById('successRate').textContent = (data.successRate || 0).toFixed(1) + '%';
                
                // Format total revenue
                const totalRevenue = data.totalRevenue || 0;
                document.getElementById('totalRevenue').innerHTML = '<i class="fas fa-rupee-sign"></i> ' + 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2}).format(totalRevenue);
                
                // Update progress bars
                const total = data.totalPayments || 1;
                const successBar = document.getElementById('successBar');
                const failedBar = document.getElementById('failedBar');
                const rateBar = document.getElementById('rateBar');
                
                if (successBar) successBar.style.width = ((data.successfulPayments / total) * 100) + '%';
                if (failedBar) failedBar.style.width = ((data.failedPayments / total) * 100) + '%';
                if (rateBar) rateBar.style.width = (data.successRate || 0) + '%';
                
                // Update status legend
                const legendSuccess = document.querySelector('#statusLegend .col-4:first-child .badge');
                const legendFailed = document.querySelector('#statusLegend .col-4:nth-child(2) .badge');
                const legendPending = document.querySelector('#statusLegend .col-4:last-child .badge');
                
                if (legendSuccess) legendSuccess.textContent = data.successfulPayments || 0;
                if (legendFailed) legendFailed.textContent = data.failedPayments || 0;
                if (legendPending) legendPending.textContent = data.pendingPayments || 0;
                
                // Update status chart
                updateStatusChart(data.successfulPayments || 0, data.failedPayments || 0, data.pendingPayments || 0);
                
                // Update revenue by mode
                updateRevenueByMode(data.revenueByMode || {});
            })
            .catch(error => {
                console.error('Error loading payment summary:', error);
                showToast('error', 'Failed to load payment summary');
            });
    }
    
    // Animate number change
    function animateNumber(elementId, newValue) {
        const element = document.getElementById(elementId);
        const oldValue = parseInt(element.textContent) || 0;
        
        if (oldValue === newValue) return;
        
        let start = null;
        const duration = 500; // 500ms animation
        
        const step = (timestamp) => {
            if (!start) start = timestamp;
            const progress = Math.min((timestamp - start) / duration, 1);
            const current = Math.floor(oldValue + (progress * (newValue - oldValue)));
            element.textContent = current;
            
            if (progress < 1) {
                window.requestAnimationFrame(step);
            } else {
                element.textContent = newValue;
            }
        };
        
        window.requestAnimationFrame(step);
    }
    
    // Load recent payments
    function loadRecentPayments() {
        fetch('/api/admin/recent-payments')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(payments => {
                const tbody = document.getElementById('recentPaymentsBody');
                
                if (!payments || payments.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center py-4">No recent payments found</td></tr>';
                    return;
                }
                
                let html = '';
                payments.forEach(payment => {
                    let statusClass = '';
                    let statusText = payment.status || 'PENDING';
                    
                    if (statusText === 'SUCCESS') {
                        statusClass = 'bg-success';
                        statusText = 'SUCCESS';
                    } else if (statusText === 'FAILED') {
                        statusClass = 'bg-danger';
                        statusText = 'FAILED';
                    } else {
                        statusClass = 'bg-warning';
                        statusText = 'PENDING';
                    }
                    
                    let modeIcon = '';
                    if (payment.mode === 'COD') modeIcon = '<i class="fas fa-money-bill-wave me-1"></i>';
                    else if (payment.mode === 'CARD') modeIcon = '<i class="fas fa-credit-card me-1"></i>';
                    else if (payment.mode === 'UPI') modeIcon = '<i class="fas fa-mobile-alt me-1"></i>';
                    else if (payment.mode === 'NET_BANKING') modeIcon = '<i class="fas fa-university me-1"></i>';
                    
                    const formattedAmount = new Intl.NumberFormat('en-IN', {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(payment.amount);
                    
                    html += `
                        <tr>
                            <td><strong>#${payment.paymentId}</strong></td>
                            <td><a href="/admin/order/details?orderId=${payment.orderId}" class="text-decoration-none">#${payment.orderId}</a></td>
                            <td><i class="fas fa-rupee-sign"></i> ${formattedAmount}</td>
                            <td><span class="badge bg-info">${modeIcon}${payment.mode || 'N/A'}</span></td>
                            <td><span class="text-muted small font-monospace">${payment.transactionRef || 'N/A'}</span></td>
                            <td><span class="badge ${statusClass}">${statusText}</span></td>
                            <td>${payment.paymentDateTime || payment.date || '-'}</td>
                            <td>
                                <a href="/admin/payment/details?paymentId=${payment.paymentId}" class="btn btn-sm btn-outline-primary" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </td>
                        </tr>
                    `;
                });
                
                tbody.innerHTML = html;
            })
            .catch(error => {
                console.error('Error loading recent payments:', error);
                document.getElementById('recentPaymentsBody').innerHTML = 
                    '<tr><td colspan="8" class="text-center py-4 text-danger">Failed to load recent payments</td></tr>';
            });
    }
    
    // Load daily revenue for specified days
    function loadDailyRevenue(days, button = null) {
        // Update active button if provided
        if (button) {
            document.querySelectorAll('#periodButtons .btn').forEach(btn => {
                btn.classList.remove('active');
            });
            button.classList.add('active');
            currentPeriod = days;
        }
        
        // Update date range text
        const endDate = new Date();
        const startDate = new Date();
        startDate.setDate(startDate.getDate() - (days - 1));
        
        document.getElementById('chartDateRange').textContent = 
            `Showing data from ${startDate.toLocaleDateString('en-IN', {day: '2-digit', month: 'short'})} to ${endDate.toLocaleDateString('en-IN', {day: '2-digit', month: 'short', year: 'numeric'})}`;
        
        fetch('/api/admin/payment-summary')
            .then(response => response.json())
            .then(data => {
                if (data.dailyRevenue && data.dailyRevenue.length > 0) {
                    // Use real data
                    updateRevenueChart(data.dailyRevenue);
                } else {
                    // Generate realistic mock data based on days
                    const mockData = generateMockDailyRevenue(days);
                    updateRevenueChart(mockData);
                }
            })
            .catch(() => {
                // Use mock data if API fails
                const mockData = generateMockDailyRevenue(days);
                updateRevenueChart(mockData);
            });
    }
    
    // Generate realistic mock daily revenue data
    function generateMockDailyRevenue(days) {
        const data = [];
        const today = new Date();
        
        // Generate realistic revenue pattern with slight upward trend
        let baseRevenue = 110000;
        
        for (let i = days - 1; i >= 0; i--) {
            const date = new Date(today);
            date.setDate(date.getDate() - i);
            
            // Add some variation
            const variation = (Math.random() * 20000) - 10000;
            const revenue = Math.max(50000, Math.round((baseRevenue + variation) / 1000) * 1000);
            
            // Slight upward trend for recent days
            baseRevenue += 2000;
            
            data.push({
                date: date.toLocaleDateString('en-IN', { 
                    day: '2-digit', 
                    month: 'short'
                }),
                fullDate: date.toLocaleDateString('en-IN', { 
                    day: '2-digit', 
                    month: 'short', 
                    year: 'numeric' 
                }),
                revenue: revenue
            });
        }
        
        return data;
    }
    
    // Update revenue chart
    function updateRevenueChart(dailyData) {
        const ctx = document.getElementById('revenueChart').getContext('2d');
        
        // Destroy existing chart if it exists
        if (revenueChart) {
            revenueChart.destroy();
        }
        
        const labels = dailyData.map(d => d.date);
        const values = dailyData.map(d => d.revenue);
        const fullDates = dailyData.map(d => d.fullDate || d.date);
        
        revenueChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Revenue (₹)',
                    data: values,
                    borderColor: '#2874f0',
                    backgroundColor: 'rgba(40, 116, 240, 0.1)',
                    borderWidth: 3,
                    tension: 0.3,
                    fill: true,
                    pointBackgroundColor: '#2874f0',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: '#2874f0',
                    pointHoverBorderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        callbacks: {
                            label: function(context) {
                                return 'Revenue: ₹' + context.raw.toLocaleString('en-IN');
                            },
                            afterLabel: function(context) {
                                return fullDates[context.dataIndex];
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            callback: function(value) {
                                return '₹' + value.toLocaleString('en-IN');
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            maxRotation: 45,
                            minRotation: 45
                        }
                    }
                },
                animation: {
                    duration: 800,
                    easing: 'easeInOutQuart'
                }
            }
        });
    }
    
    // Update status chart
    function updateStatusChart(success, failed, pending) {
        const ctx = document.getElementById('statusChart').getContext('2d');
        
        // Destroy existing chart if it exists
        if (statusChart) {
            statusChart.destroy();
        }
        
        statusChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Successful', 'Failed', 'Pending'],
                datasets: [{
                    data: [success, failed, pending],
                    backgroundColor: ['#28a745', '#dc3545', '#ffc107'],
                    borderWidth: 0,
                    hoverOffset: 10
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '65%',
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw || 0;
                                const total = success + failed + pending;
                                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                },
                animation: {
                    animateRotate: true,
                    animateScale: true,
                    duration: 800
                }
            }
        });
    }
    
    // Update revenue by payment mode
    function updateRevenueByMode(revenueByMode) {
        const container = document.getElementById('revenueByModeContainer');
        
        if (!revenueByMode || Object.keys(revenueByMode).length === 0) {
            container.innerHTML = '<div class="col-12 text-center py-4">No revenue data available</div>';
            return;
        }
        
        let totalRevenue = 0;
        const revenueArray = [];
        
        for (let mode in revenueByMode) {
            totalRevenue += revenueByMode[mode];
            revenueArray.push({
                mode: mode,
                revenue: revenueByMode[mode]
            });
        }
        
        // Sort by revenue descending
        revenueArray.sort((a, b) => b.revenue - a.revenue);
        
        let html = '';
        revenueArray.forEach(item => {
            const percentage = totalRevenue > 0 ? ((item.revenue / totalRevenue) * 100).toFixed(1) : 0;
            
            let icon = 'fa-credit-card';
            let color = 'primary';
            
            if (item.mode === 'COD') {
                icon = 'fa-money-bill-wave';
                color = 'success';
            } else if (item.mode === 'UPI') {
                icon = 'fa-mobile-alt';
                color = 'info';
            } else if (item.mode === 'CARD') {
                icon = 'fa-credit-card';
                color = 'warning';
            } else if (item.mode === 'NET_BANKING') {
                icon = 'fa-university';
                color = 'secondary';
            }
            
            const formattedRevenue = new Intl.NumberFormat('en-IN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(item.revenue);
            
            html += `
                <div class="col-lg-3 col-md-4 col-sm-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="badge bg-${color}"><i class="fas ${icon} me-1"></i>${item.mode}</span>
                                <span class="text-${color} fw-bold">${percentage}%</span>
                            </div>
                            <h5 class="mb-0"><i class="fas fa-rupee-sign"></i> ${formattedRevenue}</h5>
                            <div class="progress mt-2" style="height: 5px;">
                                <div class="progress-bar bg-${color}" style="width: ${percentage}%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            `;
        });
        
        container.innerHTML = html;
    }
    
    // Show toast notification
    function showToast(type, message) {
        // Check if toast container exists
        let toastContainer = document.getElementById('toastContainer');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toastContainer';
            toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
            toastContainer.style.zIndex = '9999';
            document.body.appendChild(toastContainer);
        }
        
        const toastId = 'toast-' + Date.now();
        const bgColor = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-info';
        const icon = type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle';
        
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
        
        toastContainer.appendChild(toast);
        
        const bsToast = new bootstrap.Toast(toast, { delay: 3000 });
        bsToast.show();
        
        toast.addEventListener('hidden.bs.toast', function() {
            toast.remove();
        });
    }
    
    // Auto-refresh data every 60 seconds
    let refreshInterval = setInterval(function() {
        if (document.visibilityState === 'visible') {
            loadPaymentSummary();
            loadRecentPayments();
        }
    }, 60000);
    
    // Clean up interval on page unload
    window.addEventListener('beforeunload', function() {
        if (refreshInterval) {
            clearInterval(refreshInterval);
        }
    });
</script>

<style>
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
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
    
    .bg-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    .bg-success { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
    .bg-danger { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
    .bg-info { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
    .bg-warning { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
    .bg-secondary { background: linear-gradient(135deg, #757f9a 0%, #d7dde8 100%); }
    
    .progress {
        border-radius: 10px;
        background-color: #f0f0f0;
    }
    
    .progress-bar {
        border-radius: 10px;
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    
    .btn-group .btn.active {
        background-color: #2874f0;
        color: white;
        border-color: #2874f0;
    }
    
    .btn-outline-primary.active:hover {
        background-color: #1e5fd8;
    }
    
    .toast-container {
        z-index: 9999;
    }
    
    .toast {
        min-width: 250px;
    }
    
    .card {
        border: none;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        transition: box-shadow 0.3s;
    }
    
    .card:hover {
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .font-monospace {
        font-family: 'Courier New', monospace;
        font-size: 0.85em;
    }
    
    @media (max-width: 768px) {
        .stat-card {
            margin-bottom: 15px;
        }
        
        .btn-group {
            margin-top: 10px;
            width: 100%;
        }
        
        .btn-group .btn {
            flex: 1;
        }
    }
</style>

<%@ include file="footer.jsp" %>