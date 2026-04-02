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
                <h2><i class="fas fa-box me-2 text-primary"></i>Product Management</h2>
                <div>
                    <a href="/admin/product/add" class="btn btn-primary me-2">
                        <i class="fas fa-plus me-2"></i>Add New Product
                    </a>
                    <button class="btn btn-outline-primary" onclick="refreshStats()">
                        <i class="fas fa-sync-alt me-2"></i>Refresh
                    </button>
                </div>
            </div>

            <!-- Action Buttons (Export) -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/export/products/excel" class="btn btn-success">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/export/products/word" class="btn btn-primary">
                                <i class="fas fa-file-word"></i> Export to Word
                            </a>
                            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#emailReportModal" data-report-type="products">
                                <i class="fas fa-envelope"></i> Email Report
                            </button>
                            <button class="btn btn-outline-primary" onclick="refreshStats()">
                                <i class="fas fa-sync-alt"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Product Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Total Products</p>
                                <h3 class="mb-0" id="totalProducts">${totalItems}</h3>
                            </div>
                            <div class="stat-icon bg-primary">
                                <i class="fas fa-box-open"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">In Stock</p>
                                <h3 class="mb-0 text-success" id="inStockCount">${inStockCount}</h3>
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
                                <p class="text-muted mb-1">Low Stock</p>
                                <h3 class="mb-0 text-warning" id="lowStockCount">${lowStockCount}</h3>
                            </div>
                            <div class="stat-icon bg-warning">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted mb-1">Total Images</p>
                                <h3 class="mb-0 text-info" id="totalImages">${totalImages}</h3>
                            </div>
                            <div class="stat-icon bg-info">
                                <i class="fas fa-images"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick View Tabs -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Product Overview</h5>
                </div>
                <div class="card-body">
                    <ul class="nav nav-pills mb-3" id="productViewTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="all-tab" data-bs-toggle="pill" data-bs-target="#all" type="button" role="tab">
                                <i class="fas fa-list me-2"></i>All Products
                                <span class="badge bg-primary ms-2">${totalItems}</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="inStock-tab" data-bs-toggle="pill" data-bs-target="#inStock" type="button" role="tab">
                                <i class="fas fa-check-circle text-success me-2"></i>In Stock
                                <span class="badge bg-success ms-2">${inStockCount}</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="lowStock-tab" data-bs-toggle="pill" data-bs-target="#lowStock" type="button" role="tab">
                                <i class="fas fa-exclamation-triangle text-warning me-2"></i>Low Stock
                                <span class="badge bg-warning ms-2">${lowStockCount}</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="outOfStock-tab" data-bs-toggle="pill" data-bs-target="#outOfStock" type="button" role="tab">
                                <i class="fas fa-times-circle text-danger me-2"></i>Out of Stock
                                <span class="badge bg-danger ms-2">${outOfStockCount}</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="recent-tab" data-bs-toggle="pill" data-bs-target="#recent" type="button" role="tab">
                                <i class="fas fa-clock text-info me-2"></i>Recently Added
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="topSelling-tab" data-bs-toggle="pill" data-bs-target="#topSelling" type="button" role="tab">
                                <i class="fas fa-crown text-warning me-2"></i>Top Selling
                            </button>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- Filter Section (Collapsible) -->
            <div class="card mb-4">
                <div class="card-header bg-white" data-bs-toggle="collapse" data-bs-target="#filterCollapse" style="cursor: pointer;">
                    <h5 class="mb-0">
                        <i class="fas fa-filter me-2 text-primary"></i>Filter Products
                        <i class="fas fa-chevron-down float-end"></i>
                    </h5>
                </div>
                <div class="collapse show" id="filterCollapse">
                    <div class="card-body">
                        <form action="/admin/products" method="get" id="filterForm" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Search</label>
                                <input type="text" class="form-control" name="search" 
                                       placeholder="Product name..." value="${param.search}">
                            </div>
                            
                            <div class="col-md-2">
                                <label class="form-label">Category</label>
                                <select class="form-select" name="categoryId" id="filterCategory">
                                    <option value="">All Categories</option>
                                    <c:forEach var="cat" items="${categoryList}">
                                        <option value="${cat.categoryId}" ${param.categoryId == cat.categoryId ? 'selected' : ''}>
                                            ${cat.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="col-md-2">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="status" id="filterStatus">
                                    <option value="">All Status</option>
                                    <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Available</option>
                                    <option value="Out of Stock" ${param.status == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                    <option value="Discontinued" ${param.status == 'Discontinued' ? 'selected' : ''}>Discontinued</option>
                                </select>
                            </div>
                            
                            <div class="col-md-2">
                                <label class="form-label">Stock Filter</label>
                                <select class="form-select" name="stockFilter" id="filterStock">
                                    <option value="">All</option>
                                    <option value="low" ${param.stockFilter == 'low' ? 'selected' : ''}>Low Stock (≤10)</option>
                                    <option value="medium" ${param.stockFilter == 'medium' ? 'selected' : ''}>Medium (11-50)</option>
                                    <option value="high" ${param.stockFilter == 'high' ? 'selected' : ''}>High (50+)</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-search me-2"></i>Apply
                                </button>
                                <a href="/admin/products" class="btn btn-secondary">
                                    <i class="fas fa-redo me-2"></i>Reset
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Tab Content -->
            <div class="tab-content" id="productViewTabsContent">
                <!-- All Products Tab -->
                <div class="tab-pane fade show active" id="all" role="tabpanel">
                    <!-- Products Table -->
                    <div class="table-container">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>All Products List</h6>
                            <span class="badge bg-primary">Total: ${totalItems}</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th>Stock</th>
                                        <th>Status</th>
                                        <th>Images</th>
                                        <th style="min-width: 120px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr id="product-row-${product.productId}">
                                            <td><strong>#${product.productId}</strong></td>
                                            <td>
                                                <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/50'}" 
                                                     width="50" height="50" class="rounded" style="object-fit: cover;"
                                                     onerror="this.src='https://via.placeholder.com/50?text=No+Image'">
                                            </td>
                                            <td>
                                                <div>
                                                    <strong>${product.productName}</strong>
                                                    <c:if test="${not empty product.brand}">
                                                        <br><small class="text-muted">${product.brand}</small>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty categoryList}">
                                                        <c:forEach var="cat" items="${categoryList}">
                                                            <c:if test="${cat.categoryId == product.categoryId}">
                                                                ${cat.categoryName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div>
                                                    <strong><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></strong>
                                                    <c:if test="${product.mrp != null && product.mrp > product.price}">
                                                        <br><small class="text-muted text-decoration-line-through">
                                                            <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.mrp}" pattern="#,##0"/>
                                                        </small>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.stockQuantity > 50}">
                                                        <span class="badge bg-success">${product.stockQuantity}</span>
                                                    </c:when>
                                                    <c:when test="${product.stockQuantity > 10}">
                                                        <span class="badge bg-warning">${product.stockQuantity}</span>
                                                    </c:when>
                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <span class="badge bg-danger">${product.stockQuantity}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">0</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge 
                                                    <c:choose>
                                                        <c:when test="${product.status == 'Available'}">bg-success</c:when>
                                                        <c:when test="${product.status == 'Out of Stock'}">bg-danger</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                    ${product.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:set var="imageCount" value="${imageCountMap[product.productId] != null ? imageCountMap[product.productId] : 0}" />
                                                <span class="badge bg-info">
                                                    <i class="fas fa-image me-1"></i> ${imageCount}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="/admin/product/view/${product.productId}" 
                                                       class="btn btn-sm btn-outline-info" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="/admin/product/edit/${product.productId}" 
                                                       class="btn btn-sm btn-outline-primary" title="Edit Product">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="/product/images?productId=${product.productId}" 
                                                       class="btn btn-sm btn-outline-warning" title="Manage Images">
                                                        <i class="fas fa-images"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmDelete(${product.productId}, '${fn:escapeXml(product.productName)}')"
                                                            title="Delete Product">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty products}">
                                        <tr>
                                            <td colspan="9" class="text-center py-5">
                                                <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                                                <h5 class="text-muted">No Products Found</h5>
                                                <p class="text-muted mb-3">Try adjusting your filters or add a new product</p>
                                                <a href="/admin/product/add" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Add New Product
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                        <a class="page-link" href="<c:url value='/admin/products'>
                                            <c:param name='page' value='${currentPage-1}'/>
                                            <c:param name='size' value='${size}'/>
                                            <c:param name='search' value='${param.search}'/>
                                            <c:param name='categoryId' value='${param.categoryId}'/>
                                            <c:param name='status' value='${param.status}'/>
                                            <c:param name='stockFilter' value='${param.stockFilter}'/>
                                        </c:url>">
                                            Previous
                                        </a>
                                    </li>
                                    
                                    <c:forEach begin="0" end="${totalPages-1}" var="i">
                                        <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="<c:url value='/admin/products'>
                                                    <c:param name='page' value='${i}'/>
                                                    <c:param name='size' value='${size}'/>
                                                    <c:param name='search' value='${param.search}'/>
                                                    <c:param name='categoryId' value='${param.categoryId}'/>
                                                    <c:param name='status' value='${param.status}'/>
                                                    <c:param name='stockFilter' value='${param.stockFilter}'/>
                                                </c:url>">
                                                    ${i+1}
                                                </a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                        <a class="page-link" href="<c:url value='/admin/products'>
                                            <c:param name='page' value='${currentPage+1}'/>
                                            <c:param name='size' value='${size}'/>
                                            <c:param name='search' value='${param.search}'/>
                                            <c:param name='categoryId' value='${param.categoryId}'/>
                                            <c:param name='status' value='${param.status}'/>
                                            <c:param name='stockFilter' value='${param.stockFilter}'/>
                                        </c:url>">
                                            Next
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                            
                            <!-- Page Info -->
                            <div class="text-center text-muted mt-2">
                                <small>
                                    Showing ${currentPage * size + 1} to 
                                    <c:choose>
                                        <c:when test="${(currentPage * size + size) > totalItems}">
                                            ${totalItems}
                                        </c:when>
                                        <c:otherwise>
                                            ${currentPage * size + size}
                                        </c:otherwise>
                                    </c:choose>
                                    of ${totalItems} total products
                                </small>
                            </div>
                        </c:if>
                        
                        <c:if test="${totalPages <= 1 && not empty products}">
                            <div class="text-center text-muted mt-3">
                                <small>Showing ${fn:length(products)} of ${totalItems} total products</small>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <!-- In Stock Tab -->
                <div class="tab-pane fade" id="inStock" role="tabpanel">
                    <div class="table-container">
                        <div class="text-center p-4" id="inStockLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="inStockContent" style="display: none;"></div>
                    </div>
                </div>
                
                <!-- Low Stock Tab -->
                <div class="tab-pane fade" id="lowStock" role="tabpanel">
                    <div class="table-container">
                        <div class="text-center p-4" id="lowStockLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="lowStockContent" style="display: none;"></div>
                    </div>
                </div>
                
                <!-- Out of Stock Tab -->
                <div class="tab-pane fade" id="outOfStock" role="tabpanel">
                    <div class="table-container">
                        <div class="text-center p-4" id="outOfStockLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="outOfStockContent" style="display: none;"></div>
                    </div>
                </div>
                
                <!-- Recently Added Tab -->
                <div class="tab-pane fade" id="recent" role="tabpanel">
                    <div class="table-container">
                        <div class="text-center p-4" id="recentLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="recentContent" style="display: none;"></div>
                    </div>
                </div>
                
                <!-- Top Selling Tab -->
                <div class="tab-pane fade" id="topSelling" role="tabpanel">
                    <div class="table-container">
                        <div class="text-center p-4" id="topSellingLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div id="topSellingContent" style="display: none;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                    Confirm Delete
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete <strong id="deleteProductName"></strong>?</p>
                <p class="text-danger mb-0">
                    <small>
                        <i class="fas fa-info-circle me-1"></i>
                        This action cannot be undone. All associated images will also be deleted.
                    </small>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Cancel
                </button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="fas fa-trash me-2"></i>Delete
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Toast Container -->
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

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

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

// Global chart instances
let categoryChart = null;
let subcategoryChart = null;

// Load charts on page load
document.addEventListener('DOMContentLoaded', function() {
    loadChartData();
});

function loadChartData() {
    // Load category distribution
    fetch('/api/admin/products/category-distribution')
        .then(response => response.json())
        .then(data => {
            document.getElementById('categoryCount').textContent = data.length + ' Categories';
            renderCategoryChart(data);
        })
        .catch(error => console.error('Error loading category distribution:', error));
    
    // Load subcategory distribution
    fetch('/api/admin/products/subcategory-distribution')
        .then(response => response.json())
        .then(data => {
            document.getElementById('subcategoryCount').textContent = data.length + ' Subcategories';
            renderSubcategoryChart(data);
        })
        .catch(error => console.error('Error loading subcategory distribution:', error));
}

function renderCategoryChart(data) {
    const ctx = document.getElementById('categoryPieChart').getContext('2d');
    
    // Destroy existing chart if it exists
    if (categoryChart) {
        categoryChart.destroy();
    }
    
    const labels = data.map(item => item.name);
    const values = data.map(item => item.count);
    const colors = generateColors(data.length);
    
    categoryChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: colors,
                borderColor: 'white',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.raw || 0;
                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                            const percentage = ((value / total) * 100).toFixed(1);
                            return `${label}: ${value} products (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });
    
    // Generate legend
    generateLegend('categoryLegend', labels, colors, values);
}

function renderSubcategoryChart(data) {
    const ctx = document.getElementById('subcategoryPieChart').getContext('2d');
    
    // Destroy existing chart if it exists
    if (subcategoryChart) {
        subcategoryChart.destroy();
    }
    
    // Limit to top 10 subcategories for readability
    const topData = data.slice(0, 10);
    const otherCount = data.slice(10).reduce((sum, item) => sum + item.count, 0);
    
    let labels = topData.map(item => item.name);
    let values = topData.map(item => item.count);
    
    if (otherCount > 0) {
        labels.push('Others');
        values.push(otherCount);
    }
    
    const colors = generateColors(labels.length);
    
    subcategoryChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: colors,
                borderColor: 'white',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.raw || 0;
                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                            const percentage = ((value / total) * 100).toFixed(1);
                            return `${label}: ${value} products (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });
    
    // Generate legend
    generateLegend('subcategoryLegend', labels, colors, values);
}

function generateColors(count) {
    const colors = [
        '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b',
        '#5a5c69', '#6f42c1', '#fd7e14', '#20c9a6', '#858796',
        '#5a5c69', '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e'
    ];
    
    // If we need more colors, generate them
    while (colors.length < count) {
        const hue = Math.floor(Math.random() * 360);
        colors.push(`hsl(${hue}, 70%, 60%)`);
    }
    
    return colors.slice(0, count);
}

function generateLegend(containerId, labels, colors, values) {
    const container = document.getElementById(containerId);
    container.innerHTML = '';
    
    const total = values.reduce((a, b) => a + b, 0);
    
    labels.forEach((label, index) => {
        const percentage = ((values[index] / total) * 100).toFixed(1);
        
        const legendItem = document.createElement('div');
        legendItem.className = 'legend-item';
        legendItem.innerHTML = `
            <span class="legend-color" style="background-color: ${colors[index]}"></span>
            <span class="legend-label">${label}</span>
            <span class="legend-value">${values[index]} (${percentage}%)</span>
        `;
        container.appendChild(legendItem);
    });
}

function refreshStats() {
    fetch('/api/admin/product-stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('totalProducts').textContent = data.totalProducts || 0;
            document.getElementById('inStockCount').textContent = data.inStockCount || 0;
            document.getElementById('lowStockCount').textContent = data.lowStockCount || 0;
            document.getElementById('totalImages').textContent = data.totalImages || 0;
            document.getElementById('outOfStockCount').textContent = data.outOfStockCount || 0;
            
            // Update tab badges
            const allTabBadge = document.querySelector('#all-tab .badge');
            if (allTabBadge) allTabBadge.textContent = data.totalProducts || 0;
            
            const inStockTabBadge = document.querySelector('#inStock-tab .badge');
            if (inStockTabBadge) inStockTabBadge.textContent = data.inStockCount || 0;
            
            const lowStockTabBadge = document.querySelector('#lowStock-tab .badge');
            if (lowStockTabBadge) lowStockTabBadge.textContent = data.lowStockCount || 0;
            
            const outOfStockTabBadge = document.querySelector('#outOfStock-tab .badge');
            if (outOfStockTabBadge) outOfStockTabBadge.textContent = data.outOfStockCount || 0;
        })
        .catch(error => console.error('Error refreshing stats:', error));
    
    // Reload chart data
    loadChartData();
}

function confirmDelete(productId, productName) {
    document.getElementById('deleteProductName').textContent = productName;
    document.getElementById('confirmDeleteBtn').href = '/admin/product/delete/' + productId;
    
    var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
    modal.show();
}

function showToast(type, message) {
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
    
    document.getElementById('toastContainer').appendChild(toast);
    
    const bsToast = new bootstrap.Toast(toast, { delay: 3000 });
    bsToast.show();
    
    toast.addEventListener('hidden.bs.toast', function() {
        toast.remove();
    });
}

// Load tab data
document.querySelectorAll('#productViewTabs button').forEach(tab => {
    tab.addEventListener('shown.bs.tab', function(event) {
        const targetId = event.target.getAttribute('data-bs-target').replace('#', '');
        loadTabData(targetId);
    });
});

function loadTabData(tabId) {
    const loadingEl = document.getElementById(tabId + 'Loading');
    const contentEl = document.getElementById(tabId + 'Content');
    
    if (!contentEl || contentEl.innerHTML.trim() !== '') return;
    
    loadingEl.style.display = 'block';
    
    let url = '';
    switch(tabId) {
        case 'inStock':
            url = '/api/admin/products?status=inStock';
            break;
        case 'lowStock':
            url = '/api/admin/products?status=lowStock';
            break;
        case 'outOfStock':
            url = '/api/admin/products?status=outOfStock';
            break;
        case 'recent':
            url = '/api/admin/products?sort=recent';
            break;
        case 'topSelling':
            url = '/api/admin/products?sort=topSelling';
            break;
    }
    
    if (url) {
        fetch(url)
            .then(response => response.json())
            .then(data => {
                loadingEl.style.display = 'none';
                contentEl.style.display = 'block';
                
                if (data.length === 0) {
                    contentEl.innerHTML = '<div class="text-center p-4"><p class="text-muted">No products found</p></div>';
                } else {
                    let html = '<div class="table-responsive"><table class="table table-hover"><thead><tr>' +
                              '<th>ID</th><th>Image</th><th>Product Name</th><th>Category</th>' +
                              '<th>Price</th><th>Stock</th><th>Status</th><th>Images</th><th>Actions</th>' +
                              '</tr></thead><tbody>';
                    
                    data.forEach(product => {
                        let imageUrl = product.mainImageURL || 'https://via.placeholder.com/50';
                        let stockClass = product.stockQuantity > 50 ? 'bg-success' : 
                                       product.stockQuantity > 10 ? 'bg-warning' : 
                                       product.stockQuantity > 0 ? 'bg-danger' : 'bg-secondary';
                        let statusClass = product.status === 'Available' ? 'bg-success' : 
                                         product.status === 'Out of Stock' ? 'bg-danger' : 'bg-secondary';
                        
                        html += '<tr>' +
                            '<td>#' + product.productId + '</td>' +
                            '<td><img src="' + imageUrl + '" width="50" height="50" class="rounded" style="object-fit: cover;" onerror="this.src=\'https://via.placeholder.com/50?text=No+Image\'"></td>' +
                            '<td><strong>' + escapeHtml(product.productName) + '</strong>' + (product.brand ? '<br><small>' + escapeHtml(product.brand) + '</small>' : '') + '</td>' +
                            '<td>' + (product.categoryName || '-') + '</td>' +
                            '<td><i class="fas fa-rupee-sign"></i> ' + product.price.toFixed(2) + '</td>' +
                            '<td><span class="badge ' + stockClass + '">' + product.stockQuantity + '</span></td>' +
                            '<td><span class="badge ' + statusClass + '">' + (product.status || 'Unknown') + '</span></td>' +
                            '<td><span class="badge bg-info"><i class="fas fa-image me-1"></i> ' + (product.imageCount || 0) + '</span></td>' +
                            '<td><div class="action-buttons">' +
                            '<a href="/admin/product/view/' + product.productId + '" class="btn btn-sm btn-outline-info"><i class="fas fa-eye"></i></a>' +
                            '<a href="/admin/product/edit/' + product.productId + '" class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i></a>' +
                            '<a href="/product/images?productId=' + product.productId + '" class="btn btn-sm btn-outline-warning"><i class="fas fa-images"></i></a>' +
                            '<button class="btn btn-sm btn-outline-danger" onclick="confirmDelete(' + product.productId + ', \'' + escapeJs(product.productName) + '\')"><i class="fas fa-trash"></i></button>' +
                            '</div></td></tr>';
                    });
                    
                    html += '</tbody></table></div>';
                    contentEl.innerHTML = html;
                }
            })
            .catch(error => {
                loadingEl.style.display = 'none';
                contentEl.innerHTML = '<div class="text-center p-4 text-danger">Error loading data</div>';
            });
    }
}

// Helper functions for escaping
function escapeHtml(text) {
    if (!text) return '';
    return text.replace(/[&<>"]/g, function(match) {
        if (match === '&') return '&amp;';
        if (match === '<') return '&lt;';
        if (match === '>') return '&gt;';
        if (match === '"') return '&quot;';
        return match;
    });
}

function escapeJs(text) {
    if (!text) return '';
    return text.replace(/'/g, "\\'").replace(/"/g, '&quot;');
}

// Auto-hide alerts
setTimeout(function() {
    document.querySelectorAll('.alert').forEach(function(alert) {
        try {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        } catch(e) {}
    });
}, 5000);

// Refresh stats every 30 seconds
setInterval(refreshStats, 30000);
</script>

<style>
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        height: 100%;
        transition: transform 0.2s;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.12);
    }
    
    .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
    }
    
    .stat-icon.bg-primary { background: linear-gradient(135deg, #667eea, #764ba2); }
    .stat-icon.bg-success { background: linear-gradient(135deg, #43e97b, #38f9d7); }
    .stat-icon.bg-warning { background: linear-gradient(135deg, #fa709a, #fee140); }
    .stat-icon.bg-info { background: linear-gradient(135deg, #3b8dff, #6b8cff); }
    
    /* Charts Static Section - FIXED POSITIONING */
    .charts-static-section {
        position: relative;
        margin-bottom: 1.5rem !important;
        clear: both;
    }
    
    .chart-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        height: 100%;
        margin-bottom: 0;
    }
    
    .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .chart-body {
        width: 100%;
    }
    
    .chart-wrapper {
        position: relative;
        height: 250px;
        width: 100%;
        margin-bottom: 15px;
    }
    
    .chart-legend {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 15px !important;
        padding-top: 10px;
        border-top: 1px solid #e9ecef;
    }
    
    .legend-item {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 5px 10px;
        background: #f8f9fa;
        border-radius: 20px;
        font-size: 12px;
    }
    
    .legend-color {
        width: 12px;
        height: 12px;
        border-radius: 3px;
    }
    
    .legend-label {
        font-weight: 500;
    }
    
    .legend-value {
        color: #6c757d;
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        margin-top: 0;
        clear: both;
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
    
    .table td {
        vertical-align: middle;
    }
    
    .toast-container {
        z-index: 9999;
    }
    
    .pagination {
        margin-top: 20px;
    }
    
    .nav-pills .nav-link {
        color: #495057;
        font-weight: 500;
    }
    
    .nav-pills .nav-link.active {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
    }
    
    .nav-pills .nav-link .badge {
        font-size: 10px;
    }
    
    /* Ensure proper spacing */
    .mb-4 {
        margin-bottom: 1.5rem !important;
    }
    
    @media (max-width: 768px) {
        .stat-card {
            margin-bottom: 15px;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .action-buttons .btn {
            width: 100%;
        }
        
        .nav-pills {
            flex-direction: column;
        }
        
        .nav-pills .nav-link {
            text-align: left;
        }
        
        .chart-card {
            margin-bottom: 20px;
        }
        
        .legend-item {
            width: 100%;
        }
        
        .charts-static-section .row > div {
            margin-bottom: 20px;
        }
        
        .charts-static-section .row > div:last-child {
            margin-bottom: 0;
        }
    }
</style>

<%@ include file="footer.jsp" %>