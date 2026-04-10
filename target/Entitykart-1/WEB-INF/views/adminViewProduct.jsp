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
                <h2><i class="fas fa-eye me-2 text-primary"></i>Product Details</h2>
                <div>
                    <a href="/admin/products" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to Products
                    </a>
                    <a href="/admin/product/edit/${product.productId}" class="btn btn-primary me-2">
                        <i class="fas fa-edit me-2"></i>Edit
                    </a>
                    <button class="btn btn-danger" onclick="confirmDelete(${product.productId}, '${product.productName}')">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
                </div>
            </div>
            
            <!-- Product Information -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-box me-2 text-primary"></i>${product.productName}</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <!-- Product Images -->
                        <div class="col-md-4">
                            <div class="product-gallery">
                                <div class="main-image-container mb-3">
                                    <a href="${product.mainImageURL}" data-lightbox="product-gallery" data-title="${product.productName}">
                                        <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/300'}" 
                                             class="img-fluid rounded" style="max-height: 300px; width: 100%; object-fit: contain;">
                                    </a>
                                </div>
                                
                                <c:if test="${not empty productImages}">
                                    <div class="image-grid">
                                        <c:forEach var="image" items="${productImages}" varStatus="status">
                                            <a href="${image.imageURL}" data-lightbox="product-gallery" 
                                               data-title="${product.productName} - Image ${status.index + 1}">
                                                <img src="${image.imageURL}" class="img-thumbnail" 
                                                     style="width: 70px; height: 70px; object-fit: cover;">
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- Product Details -->
                        <div class="col-md-8">
                            <table class="table table-bordered">
                                <tr>
                                    <th style="width: 200px;">Product ID</th>
                                    <td><strong>#${product.productId}</strong></td>
                                </tr>
                                <tr>
                                    <th>Product Name</th>
                                    <td>${product.productName}</td>
                                </tr>
                                <tr>
                                    <th>Brand</th>
                                    <td>${product.brand}</td>
                                </tr>
                                <tr>
                                    <th>Description</th>
                                    <td>${product.description}</td>
                                </tr>
                                <tr>
                                    <th>Category</th>
                                    <td>${categoryName}</td>
                                </tr>
                                <tr>
                                    <th>Sub Category</th>
                                    <td>${subCategoryName}</td>
                                </tr>
                                <tr>
                                    <th>Price</th>
                                    <td>
                                        <span class="h5 text-primary">
                                            <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                                        </span>
                                        <c:if test="${product.mrp > product.price}">
                                            <span class="text-muted text-decoration-line-through ms-2">
                                                <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.mrp}" pattern="#,##0"/>
                                            </span>
                                            <span class="badge bg-success ms-2">${product.discountPercent}% off</span>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Stock Quantity</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.stockQuantity > 50}">
                                                <span class="badge bg-success">${product.stockQuantity} units</span>
                                            </c:when>
                                            <c:when test="${product.stockQuantity > 10}">
                                                <span class="badge bg-warning">${product.stockQuantity} units</span>
                                            </c:when>
                                            <c:when test="${product.stockQuantity > 0}">
                                                <span class="badge bg-danger">${product.stockQuantity} units</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>SKU</th>
                                    <td>${product.sku}</td>
                                </tr>
                                <tr>
                                    <th>Status</th>
                                    <td>
                                        <span class="badge 
                                            ${product.status == 'Available' ? 'bg-success' : 
                                              product.status == 'Out of Stock' ? 'bg-danger' : 'bg-secondary'}">
                                            ${product.status}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Added By</th>
                                    <td>Admin (ID: ${product.userId})</td>
                                </tr>
                                <tr>
                                    <th>Created Date</th>
                                    <td>${product.createdAt}</td>
                                </tr>
                                <tr>
                                    <th>Total Images</th>
                                    <td>${fn:length(productImages)}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Additional Information -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Additional Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <p class="text-muted mb-1">Product ID</p>
                            <p class="fw-bold">${product.productId}</p>
                        </div>
                        <div class="col-md-3">
                            <p class="text-muted mb-1">SKU</p>
                            <p class="fw-bold">${product.sku}</p>
                        </div>
                        <div class="col-md-3">
                            <p class="text-muted mb-1">Created At</p>
                            <p class="fw-bold">${product.createdAt}</p>
                        </div>
                        <div class="col-md-3">
                            <p class="text-muted mb-1">Image Count</p>
                            <p class="fw-bold">${fn:length(productImages)}</p>
                        </div>
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

<script>
    // Lightbox configuration
    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true,
        'albumLabel': 'Image %1 of %2'
    });

    function confirmDelete(productId, productName) {
        document.getElementById('deleteProductName').textContent = productName;
        document.getElementById('confirmDeleteBtn').href = '/admin/product/delete/' + productId;
        
        var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        modal.show();
    }

    function showToast(type, message) {
        const toastId = 'toast-' + Date.now();
        const bgColor = type === 'success' ? 'bg-success' : 'bg-danger';
        const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
        
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

    // Image error handling
    document.querySelectorAll('img').forEach(function(img) {
        img.onerror = function() {
            this.src = 'https://via.placeholder.com/300?text=Image+Not+Found';
        };
    });

    // Auto-hide alerts
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            try {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            } catch(e) {}
        });
    }, 5000);
</script>

<style>
    .main-image-container {
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 20px;
        background: #f8f9fa;
    }
    
    .image-grid {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }
    
    .image-grid a {
        display: block;
        width: 70px;
        height: 70px;
    }
    
    .image-grid img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        cursor: pointer;
        transition: transform 0.2s;
    }
    
    .image-grid img:hover {
        transform: scale(1.1);
        border-color: #0d6efd;
    }
    
    .table th {
        background-color: #f8f9fa;
    }
    
    .toast-container {
        z-index: 9999;
    }
</style>

<!-- Lightbox CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/css/lightbox.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/js/lightbox.min.js"></script>

<%@ include file="footer.jsp" %>