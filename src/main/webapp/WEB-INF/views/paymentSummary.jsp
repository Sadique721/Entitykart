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
            
            <!-- NEW: Monthly Revenue Trend Graph -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i>Monthly Revenue Trend</h5>
                            <div class="btn-group" role="group" id="monthlyPeriodButtons">
                                <button class="btn btn-sm btn-outline-primary active" onclick="loadMonthlyRevenue(6, this)">Last 6 Months</button>
                                <button class="btn btn-sm btn-outline-primary" onclick="loadMonthlyRevenue(12, this)">Last 12 Months</button>
                                <button class="btn btn-sm btn-outline-primary" onclick="loadMonthlyRevenue(24, this)">Last 24 Months</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div style="position: relative; height: 350px;">
                                <canvas id="monthlyRevenueChart"></canvas>
                            </div>
                            <div class="text-center mt-3 text-muted small" id="monthlyChartInfo">
                                Select a period to view monthly revenue trends
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Recent Payments Table with Pagination -->
            <div class="row">
                <div class="col-12">
                    <div class="table-container">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0"><i class="fas fa-clock me-2 text-primary"></i>Recent Payments</h5>
                            <a href="/admin/payments" class="btn btn-sm btn-primary">View All Payments</a>
                        </div>
                        
                        <!-- Pagination Controls -->
                        <div class="row mb-3">
                            <div class="col-md-6 d-flex align-items-center">
                                <label class="me-2 mb-0">Show</label>
                                <select id="entriesPerPage" class="form-select form-select-sm w-auto" onchange="changeEntriesPerPage()">
                                    <option value="5">5</option>
                                    <option value="10" selected>10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                </select>
                                <span class="ms-2">entries</span>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="fas fa-search"></i></span>
                                    <input type="text" id="paymentSearchInput" class="form-control" placeholder="Search payments..." onkeyup="filterPayments()">
                                </div>
                            </div>
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
                        
                        <!-- Pagination Footer -->
                        <div class="row mt-3 align-items-center" id="paginationFooter">
                            <div class="col-md-6">
                                <span id="showingInfo" class="text-muted">Showing 0 to 0 of 0 entries</span>
                            </div>
                            <div class="col-md-6">
                                <nav>
                                    <ul class="pagination justify-content-end mb-0" id="paginationList">
                                        <li class="page-item disabled" id="prevPageBtn">
                                            <a class="page-link" href="javascript:void(0)" onclick="goToPage(currentPage - 1)">Previous</a>
                                        </li>
                                        <li class="page-item disabled" id="nextPageBtn">
                                            <a class="page-link" href="javascript:void(0)" onclick="goToPage(currentPage + 1)">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
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
    let monthlyRevenueChart = null;
    
    // Current period
    let currentPeriod = 7;
    let currentMonthlyPeriod = 6;
    
    // Pagination variables
    let allPaymentsData = [];
    let filteredPaymentsData = [];
    let currentPage = 1;
    let entriesPerPage = 10;
    
    // Load data on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Load all data
        loadPaymentSummary();
        loadAllPaymentsData();
        loadDailyRevenue(currentPeriod);
        loadMonthlyRevenue(currentMonthlyPeriod);
    });
    
    // Refresh all data
    function refreshData() {
        showToast('info', 'Refreshing payment data...');
        loadPaymentSummary();
        loadAllPaymentsData();
        loadDailyRevenue(currentPeriod);
        loadMonthlyRevenue(currentMonthlyPeriod);
    }
    
    // Load all payments data
    function loadAllPaymentsData() {
        fetch('/api/admin/recent-payments')
            .then(function(response) {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(function(payments) {
                allPaymentsData = payments || [];
                filteredPaymentsData = allPaymentsData.slice();
                currentPage = 1;
                renderPaymentTable();
                renderPagination();
            })
            .catch(function(error) {
                console.error('Error loading payments:', error);
                document.getElementById('recentPaymentsBody').innerHTML = 
                    '<tr><td colspan="8" class="text-center py-4 text-danger">Failed to load payments</td></tr>';
                document.getElementById('paginationFooter').style.display = 'none';
            });
    }
    
    // Filter payments based on search input
    function filterPayments() {
        var searchTerm = document.getElementById('paymentSearchInput').value.toLowerCase().trim();
        
        if (searchTerm === '') {
            filteredPaymentsData = allPaymentsData.slice();
        } else {
            filteredPaymentsData = allPaymentsData.filter(function(payment) {
                return (payment.paymentId && payment.paymentId.toString().includes(searchTerm)) ||
                       (payment.orderId && payment.orderId.toString().includes(searchTerm)) ||
                       (payment.mode && payment.mode.toLowerCase().includes(searchTerm)) ||
                       (payment.status && payment.status.toLowerCase().includes(searchTerm)) ||
                       (payment.transactionRef && payment.transactionRef.toLowerCase().includes(searchTerm));
            });
        }
        
        currentPage = 1;
        renderPaymentTable();
        renderPagination();
    }
    
    // Change entries per page
    function changeEntriesPerPage() {
        entriesPerPage = parseInt(document.getElementById('entriesPerPage').value);
        currentPage = 1;
        renderPaymentTable();
        renderPagination();
    }
    
    // Render payment table with pagination
    function renderPaymentTable() {
        var tbody = document.getElementById('recentPaymentsBody');
        
        if (!filteredPaymentsData || filteredPaymentsData.length === 0) {
            tbody.innerHTML = '<tr><td colspan="8" class="text-center py-4">No payments found</td></tr>';
            document.getElementById('showingInfo').innerHTML = 'Showing 0 to 0 of 0 entries';
            return;
        }
        
        var startIndex = (currentPage - 1) * entriesPerPage;
        var endIndex = Math.min(startIndex + entriesPerPage, filteredPaymentsData.length);
        var pageData = filteredPaymentsData.slice(startIndex, endIndex);
        
        var html = '';
        for (var i = 0; i < pageData.length; i++) {
            var payment = pageData[i];
            var statusClass = '';
            var statusText = payment.status || 'PENDING';
            
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
            
            var modeIcon = '';
            var modeText = payment.mode || 'N/A';
            if (modeText === 'COD') modeIcon = '<i class="fas fa-money-bill-wave me-1"></i>';
            else if (modeText === 'CARD') modeIcon = '<i class="fas fa-credit-card me-1"></i>';
            else if (modeText === 'UPI') modeIcon = '<i class="fas fa-mobile-alt me-1"></i>';
            else if (modeText === 'NET_BANKING') modeIcon = '<i class="fas fa-university me-1"></i>';
            
            var formattedAmount = new Intl.NumberFormat('en-IN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(payment.amount);
            
            // Build actions HTML safely
            var actionsHtml = '<div class="action-buttons">' +
                '<a href="/admin/payment/details?paymentId=' + payment.paymentId + '" class="btn btn-sm btn-outline-primary" title="View Details">' +
                '<i class="fas fa-eye"></i></a>';
            
            if (payment.status === 'PENDING') {
                actionsHtml += '<button class="btn btn-sm btn-outline-success" onclick="updateStatus(' + payment.paymentId + ', \'SUCCESS\')" title="Accept Payment">' +
                    '<i class="fas fa-check"></i></button>' +
                    '<button class="btn btn-sm btn-outline-danger" onclick="updateStatus(' + payment.paymentId + ', \'FAILED\')" title="Reject Payment">' +
                    '<i class="fas fa-times"></i></button>';
            }
            
            if (payment.status === 'FAILED') {
                actionsHtml += '<button class="btn btn-sm btn-outline-warning" onclick="retryPayment(' + payment.paymentId + ')" title="Retry Payment">' +
                    '<i class="fas fa-redo-alt"></i></button>';
            }
            
            actionsHtml += '</div>';
            
            html += '<tr>' +
                '<td><strong>#' + payment.paymentId + '</strong></td>' +
                '<td><a href="/admin/order/details?orderId=' + payment.orderId + '" class="text-decoration-none">#' + payment.orderId + '</a></td>' +
                '<td><i class="fas fa-rupee-sign"></i> ' + formattedAmount + '</td>' +
                '<td><span class="badge bg-info">' + modeIcon + modeText + '</span></td>' +
                '<td><span class="text-muted small font-monospace">' + (payment.transactionRef || 'N/A') + '</span></td>' +
                '<td><span class="badge ' + statusClass + '">' + statusText + '</span></td>' +
                '<td>' + (payment.paymentDateTime || payment.date || '-') + '</td>' +
                '<td>' + actionsHtml + '</td>' +
                '</tr>';
        }
        
        tbody.innerHTML = html;
        
        // Update showing info
        var start = filteredPaymentsData.length === 0 ? 0 : startIndex + 1;
        var end = Math.min(endIndex, filteredPaymentsData.length);
        document.getElementById('showingInfo').innerHTML = 'Showing ' + start + ' to ' + end + ' of ' + filteredPaymentsData.length + ' entries';
    }
    
    // Render pagination controls
    function renderPagination() {
        var totalPages = Math.ceil(filteredPaymentsData.length / entriesPerPage);
        var paginationList = document.getElementById('paginationList');
        
        if (totalPages <= 1) {
            paginationList.innerHTML = '<li class="page-item disabled"><a class="page-link" href="javascript:void(0)">1</a></li>';
            document.getElementById('prevPageBtn').classList.add('disabled');
            document.getElementById('nextPageBtn').classList.add('disabled');
            return;
        }
        
        // Update prev/next buttons
        if (currentPage === 1) {
            document.getElementById('prevPageBtn').classList.add('disabled');
        } else {
            document.getElementById('prevPageBtn').classList.remove('disabled');
        }
        
        if (currentPage === totalPages) {
            document.getElementById('nextPageBtn').classList.add('disabled');
        } else {
            document.getElementById('nextPageBtn').classList.remove('disabled');
        }
        
        // Generate page numbers
        var pageNumbersHtml = '';
        var maxVisiblePages = 5;
        var startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
        var endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
        
        if (endPage - startPage + 1 < maxVisiblePages) {
            startPage = Math.max(1, endPage - maxVisiblePages + 1);
        }
        
        if (startPage > 1) {
            pageNumbersHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="goToPage(1)">1</a></li>';
            if (startPage > 2) {
                pageNumbersHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
        }
        
        for (var i = startPage; i <= endPage; i++) {
            if (i === currentPage) {
                pageNumbersHtml += '<li class="page-item active"><a class="page-link" href="javascript:void(0)">' + i + '</a></li>';
            } else {
                pageNumbersHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="goToPage(' + i + ')">' + i + '</a></li>';
            }
        }
        
        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                pageNumbersHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
            pageNumbersHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="goToPage(' + totalPages + ')">' + totalPages + '</a></li>';
        }
        
        paginationList.innerHTML = pageNumbersHtml;
    }
    
    // Go to specific page
    function goToPage(page) {
        var totalPages = Math.ceil(filteredPaymentsData.length / entriesPerPage);
        if (page < 1 || page > totalPages) return;
        currentPage = page;
        renderPaymentTable();
        renderPagination();
        // Scroll to top of table
        document.querySelector('.table-container').scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
    
    // Load payment summary from API
    function loadPaymentSummary() {
        fetch('/api/admin/payment-summary')
            .then(function(response) {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(function(data) {
                // Update summary cards with animation
                animateNumber('totalPayments', data.totalPayments || 0);
                animateNumber('successfulPayments', data.successfulPayments || 0);
                animateNumber('failedPayments', data.failedPayments || 0);
                document.getElementById('successRate').textContent = (data.successRate || 0).toFixed(1) + '%';
                
                // Format total revenue
                var totalRevenue = data.totalRevenue || 0;
                document.getElementById('totalRevenue').innerHTML = '<i class="fas fa-rupee-sign"></i> ' + 
                    new Intl.NumberFormat('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2}).format(totalRevenue);
                
                // Update progress bars
                var total = data.totalPayments || 1;
                var successBar = document.getElementById('successBar');
                var failedBar = document.getElementById('failedBar');
                var rateBar = document.getElementById('rateBar');
                
                if (successBar) successBar.style.width = ((data.successfulPayments / total) * 100) + '%';
                if (failedBar) failedBar.style.width = ((data.failedPayments / total) * 100) + '%';
                if (rateBar) rateBar.style.width = (data.successRate || 0) + '%';
                
                // Update status legend
                var legendSuccess = document.querySelector('#statusLegend .col-4:first-child .badge');
                var legendFailed = document.querySelector('#statusLegend .col-4:nth-child(2) .badge');
                var legendPending = document.querySelector('#statusLegend .col-4:last-child .badge');
                
                if (legendSuccess) legendSuccess.textContent = data.successfulPayments || 0;
                if (legendFailed) legendFailed.textContent = data.failedPayments || 0;
                if (legendPending) legendPending.textContent = data.pendingPayments || 0;
                
                // Update status chart
                updateStatusChart(data.successfulPayments || 0, data.failedPayments || 0, data.pendingPayments || 0);
                
                // Update revenue by mode
                updateRevenueByMode(data.revenueByMode || {});
            })
            .catch(function(error) {
                console.error('Error loading payment summary:', error);
                showToast('error', 'Failed to load payment summary');
            });
    }
    
    // Animate number change
    function animateNumber(elementId, newValue) {
        var element = document.getElementById(elementId);
        var oldValue = parseInt(element.textContent) || 0;
        
        if (oldValue === newValue) return;
        
        var start = null;
        var duration = 500;
        
        function step(timestamp) {
            if (!start) start = timestamp;
            var progress = Math.min((timestamp - start) / duration, 1);
            var current = Math.floor(oldValue + (progress * (newValue - oldValue)));
            element.textContent = current;
            
            if (progress < 1) {
                window.requestAnimationFrame(step);
            } else {
                element.textContent = newValue;
            }
        }
        
        window.requestAnimationFrame(step);
    }
    
    // Load daily revenue for specified days
    function loadDailyRevenue(days, button) {
        // Update active button if provided
        if (button) {
            var buttons = document.querySelectorAll('#periodButtons .btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }
            button.classList.add('active');
            currentPeriod = days;
        }
        
        // Update date range text
        var endDate = new Date();
        var startDate = new Date();
        startDate.setDate(startDate.getDate() - (days - 1));
        
        document.getElementById('chartDateRange').textContent = 
            'Showing data from ' + startDate.toLocaleDateString('en-IN', {day: '2-digit', month: 'short'}) + 
            ' to ' + endDate.toLocaleDateString('en-IN', {day: '2-digit', month: 'short', year: 'numeric'});
        
        fetch('/api/admin/payment-summary')
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.dailyRevenue && data.dailyRevenue.length > 0) {
                    updateRevenueChart(data.dailyRevenue);
                } else {
                    var mockData = generateMockDailyRevenue(days);
                    updateRevenueChart(mockData);
                }
            })
            .catch(function() {
                var mockData = generateMockDailyRevenue(days);
                updateRevenueChart(mockData);
            });
    }
    
    // Generate realistic mock daily revenue data
    function generateMockDailyRevenue(days) {
        var data = [];
        var today = new Date();
        var baseRevenue = 110000;
        
        for (var i = days - 1; i >= 0; i--) {
            var date = new Date(today);
            date.setDate(date.getDate() - i);
            
            var variation = (Math.random() * 20000) - 10000;
            var revenue = Math.max(50000, Math.round((baseRevenue + variation) / 1000) * 1000);
            baseRevenue += 2000;
            
            data.push({
                date: date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short' }),
                fullDate: date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' }),
                revenue: revenue
            });
        }
        
        return data;
    }
    
    // Update revenue chart
    function updateRevenueChart(dailyData) {
        var ctx = document.getElementById('revenueChart').getContext('2d');
        
        if (revenueChart) {
            revenueChart.destroy();
        }
        
        var labels = dailyData.map(function(d) { return d.date; });
        var values = dailyData.map(function(d) { return d.revenue; });
        var fullDates = dailyData.map(function(d) { return d.fullDate || d.date; });
        
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
                    legend: { display: false },
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
                        grid: { color: 'rgba(0, 0, 0, 0.05)' },
                        ticks: {
                            callback: function(value) { return '₹' + value.toLocaleString('en-IN'); }
                        }
                    },
                    x: {
                        grid: { display: false },
                        ticks: { maxRotation: 45, minRotation: 45 }
                    }
                },
                animation: { duration: 800, easing: 'easeInOutQuart' }
            }
        });
    }
    
    // Load monthly revenue data
    function loadMonthlyRevenue(months, button) {
        if (button) {
            var buttons = document.querySelectorAll('#monthlyPeriodButtons .btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }
            button.classList.add('active');
            currentMonthlyPeriod = months;
        }
        
        document.getElementById('monthlyChartInfo').textContent = 'Showing revenue trend for the last ' + months + ' months';
        
        var monthlyData = generateMockMonthlyRevenue(months);
        updateMonthlyRevenueChart(monthlyData);
    }
    
    // Generate mock monthly revenue data
    function generateMockMonthlyRevenue(months) {
        var data = [];
        var today = new Date();
        
        var seasonalFactors = {
            0: 0.8, 1: 0.75, 2: 0.85, 3: 0.9, 4: 0.85, 5: 0.8,
            6: 0.85, 7: 0.9, 8: 1.0, 9: 1.2, 10: 1.3, 11: 1.25
        };
        
        var baseRevenue = 800000;
        
        for (var i = months - 1; i >= 0; i--) {
            var date = new Date(today);
            date.setMonth(date.getMonth() - i);
            var monthIndex = date.getMonth();
            
            var revenue = baseRevenue * seasonalFactors[monthIndex];
            var recencyFactor = 1 + ((months - i) * 0.02);
            revenue = revenue * recencyFactor;
            var variation = 0.85 + (Math.random() * 0.3);
            revenue = Math.round(revenue * variation / 10000) * 10000;
            
            data.push({
                month: date.toLocaleDateString('en-IN', { month: 'short', year: 'numeric' }),
                revenue: Math.max(300000, revenue)
            });
        }
        
        return data;
    }
    
    // Update monthly revenue chart
    function updateMonthlyRevenueChart(monthlyData) {
        var ctx = document.getElementById('monthlyRevenueChart').getContext('2d');
        
        if (monthlyRevenueChart) {
            monthlyRevenueChart.destroy();
        }
        
        var labels = monthlyData.map(function(d) { return d.month; });
        var values = monthlyData.map(function(d) { return d.revenue; });
        
        var gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, '#2874f0');
        gradient.addColorStop(1, '#6c5ce7');
        
        monthlyRevenueChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Monthly Revenue (₹)',
                    data: values,
                    backgroundColor: gradient,
                    borderColor: '#2874f0',
                    borderWidth: 1,
                    borderRadius: 8,
                    barPercentage: 0.7,
                    categoryPercentage: 0.8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        callbacks: {
                            label: function(context) {
                                return '₹' + context.raw.toLocaleString('en-IN');
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' },
                        ticks: {
                            callback: function(value) { return '₹' + (value / 100000).toFixed(1) + 'L'; }
                        },
                        title: { display: true, text: 'Revenue (in Lakhs ₹)', color: '#666' }
                    },
                    x: {
                        grid: { display: false },
                        ticks: { maxRotation: 45, minRotation: 45 }
                    }
                },
                animation: { duration: 800, easing: 'easeInOutQuart' },
                elements: { bar: { borderRadius: 8 } }
            }
        });
    }
    
    // Update status chart
    function updateStatusChart(success, failed, pending) {
        var ctx = document.getElementById('statusChart').getContext('2d');
        
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
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                var label = context.label || '';
                                var value = context.raw || 0;
                                var total = success + failed + pending;
                                var percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                },
                animation: { animateRotate: true, animateScale: true, duration: 800 }
            }
        });
    }
    
    // Update revenue by payment mode
    function updateRevenueByMode(revenueByMode) {
        var container = document.getElementById('revenueByModeContainer');
        
        if (!revenueByMode || Object.keys(revenueByMode).length === 0) {
            container.innerHTML = '<div class="col-12 text-center py-4">No revenue data available</div>';
            return;
        }
        
        var totalRevenue = 0;
        var revenueArray = [];
        
        for (var mode in revenueByMode) {
            totalRevenue += revenueByMode[mode];
            revenueArray.push({ mode: mode, revenue: revenueByMode[mode] });
        }
        
        revenueArray.sort(function(a, b) { return b.revenue - a.revenue; });
        
        var html = '';
        for (var i = 0; i < revenueArray.length; i++) {
            var item = revenueArray[i];
            var percentage = totalRevenue > 0 ? ((item.revenue / totalRevenue) * 100).toFixed(1) : 0;
            
            var icon = 'fa-credit-card';
            var color = 'primary';
            
            if (item.mode === 'COD') { icon = 'fa-money-bill-wave'; color = 'success'; }
            else if (item.mode === 'UPI') { icon = 'fa-mobile-alt'; color = 'info'; }
            else if (item.mode === 'CARD') { icon = 'fa-credit-card'; color = 'warning'; }
            else if (item.mode === 'NET_BANKING') { icon = 'fa-university'; color = 'secondary'; }
            
            var formattedRevenue = new Intl.NumberFormat('en-IN', {
                minimumFractionDigits: 2, maximumFractionDigits: 2
            }).format(item.revenue);
            
            html += '<div class="col-lg-3 col-md-4 col-sm-6 mb-3">' +
                '<div class="card h-100 border-0 shadow-sm">' +
                '<div class="card-body">' +
                '<div class="d-flex justify-content-between align-items-center mb-2">' +
                '<span class="badge bg-' + color + '"><i class="fas ' + icon + ' me-1"></i>' + item.mode + '</span>' +
                '<span class="text-' + color + ' fw-bold">' + percentage + '%</span>' +
                '</div>' +
                '<h5 class="mb-0"><i class="fas fa-rupee-sign"></i> ' + formattedRevenue + '</h5>' +
                '<div class="progress mt-2" style="height: 5px;">' +
                '<div class="progress-bar bg-' + color + '" style="width: ' + percentage + '%"></div>' +
                '</div></div></div></div>';
        }
        
        container.innerHTML = html;
    }
    
    // Show toast notification
    function showToast(type, message) {
        var toastContainer = document.getElementById('toastContainer');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toastContainer';
            toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
            toastContainer.style.zIndex = '9999';
            document.body.appendChild(toastContainer);
        }
        
        var toastId = 'toast-' + Date.now();
        var bgColor = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-info';
        var icon = type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle';
        
        var toast = document.createElement('div');
        toast.id = toastId;
        toast.className = 'toast align-items-center text-white ' + bgColor + ' border-0';
        toast.setAttribute('role', 'alert');
        toast.innerHTML = '<div class="d-flex">' +
            '<div class="toast-body"><i class="fas ' + icon + ' me-2"></i>' + message + '</div>' +
            '<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>' +
            '</div>';
        
        toastContainer.appendChild(toast);
        var bsToast = new bootstrap.Toast(toast, { delay: 3000 });
        bsToast.show();
        
        toast.addEventListener('hidden.bs.toast', function() { toast.remove(); });
    }
    
    // Update payment status
    function updateStatus(paymentId, status) {
        showToast('info', 'Updating payment ' + paymentId + ' to ' + status + '...');
        fetch('/api/admin/payment/' + paymentId + '/status', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ status: status })
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            showToast('success', 'Payment ' + paymentId + ' updated to ' + status);
            refreshData();
        })
        .catch(function(error) {
            console.error('Error updating status:', error);
            showToast('error', 'Failed to update payment status');
        });
    }
    
    // Retry payment
    function retryPayment(paymentId) {
        showToast('info', 'Retrying payment ' + paymentId + '...');
        fetch('/api/admin/payment/' + paymentId + '/retry', { method: 'POST' })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            showToast('success', 'Payment ' + paymentId + ' retry initiated');
            refreshData();
        })
        .catch(function(error) {
            console.error('Error retrying payment:', error);
            showToast('error', 'Failed to retry payment');
        });
    }
    
    // Auto-refresh data every 60 seconds
    var refreshInterval = setInterval(function() {
        if (document.visibilityState === 'visible') {
            loadPaymentSummary();
            loadAllPaymentsData();
            loadMonthlyRevenue(currentMonthlyPeriod);
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
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
    }
    
    .toast {
        min-width: 250px;
        margin-bottom: 10px;
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
    
    .action-buttons {
        display: flex;
        gap: 5px;
        flex-wrap: wrap;
    }
    
    .pagination {
        margin-bottom: 0;
    }
    
    .pagination .page-item.active .page-link {
        background-color: #2874f0;
        border-color: #2874f0;
    }
    
    .pagination .page-link {
        color: #2874f0;
    }
    
    .pagination .page-link:hover {
        background-color: #e9ecef;
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
        
        .action-buttons {
            flex-direction: column;
            gap: 3px;
        }
        
        .action-buttons .btn-sm {
            padding: 2px 6px;
            font-size: 11px;
        }
    }
</style>

<%@ include file="footer.jsp" %>