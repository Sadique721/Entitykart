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
                <h2><i class="fas fa-edit me-2 text-primary"></i>Edit Product: ${product.productName}</h2>
                <div>
                    <a href="/admin/products" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to Products
                    </a>
                    <a href="/admin/product/view/${product.productId}" class="btn btn-outline-info">
                        <i class="fas fa-eye me-2"></i>View Product
                    </a>
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
            
            <!-- Edit Product Form -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Edit Product Information</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/product/update" method="post" enctype="multipart/form-data" id="productForm">
                        <input type="hidden" name="productId" value="${product.productId}">
                        
                        <!-- Basic Information -->
                        <div class="row mb-4">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="form-label required-field">Product Name</label>
                                    <input type="text" class="form-control" name="productName" 
                                           value="${product.productName}" required maxlength="200">
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" name="brand" 
                                           value="${product.brand}" maxlength="100">
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="4">${product.description}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Category Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label required-field">Category</label>
                                    <select class="form-select" name="categoryId" required id="categorySelect">
                                        <option value="">Select Category</option>
                                        <c:forEach var="category" items="${categoryList}">
                                            <option value="${category.categoryId}" 
                                                ${product.categoryId == category.categoryId ? 'selected' : ''}>
                                                ${category.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sub Category</label>
                                    <select class="form-select" name="subCategoryId" id="subCategorySelect">
                                        <option value="">Select Sub Category</option>
                                        <c:forEach var="sub" items="${subCategories}">
                                            <option value="${sub.subCategoryId}" 
                                                data-category="${sub.categoryId}"
                                                ${product.subCategoryId == sub.subCategoryId.toString() ? 'selected' : ''}>
                                                ${sub.childCategory}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pricing Section -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label required-field">Price (₹)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="price" 
                                               value="${product.price}" step="0.01" min="0" required 
                                               onchange="calculateDiscount()" id="price">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label">MRP (₹)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="mrp" 
                                               value="${product.mrp}" step="0.01" min="0" 
                                               onchange="calculateDiscount()" id="mrp">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label">Discount %</label>
                                    <input type="text" class="form-control" id="discountPercent" 
                                           value="${product.discountPercent}%" readonly>
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label required-field">Stock Quantity</label>
                                    <input type="number" class="form-control" name="stockQuantity" 
                                           value="${product.stockQuantity}" min="0" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">SKU (Stock Keeping Unit)</label>
                                    <input type="text" class="form-control" name="sku" 
                                           value="${product.sku}" maxlength="50">
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status">
                                        <option value="Available" ${product.status == 'Available' ? 'selected' : ''}>Available</option>
                                        <option value="Out of Stock" ${product.status == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                        <option value="Discontinued" ${product.status == 'Discontinued' ? 'selected' : ''}>Discontinued</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Current Images Section -->
                        <c:if test="${not empty productImages}">
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="mb-3"><i class="fas fa-images me-2 text-primary"></i>Current Images</h6>
                                    <div class="current-images-grid">
                                        <c:forEach var="image" items="${productImages}">
                                            <div class="current-image-item ${image.isPrimary ? 'border-primary' : ''}">
                                                <c:if test="${image.isPrimary}">
                                                    <span class="badge bg-primary">Primary</span>
                                                </c:if>
                                                <img src="${image.imageURL}" alt="Product Image">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <small class="text-muted mt-2 d-block">
                                        <i class="fas fa-info-circle me-1"></i>
                                        To manage images, go to <a href="/product/images?productId=${product.productId}">Image Manager</a>
                                    </small>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Update Main Image Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Update Main Image (Optional)</label>
                                    <div class="image-upload-area" onclick="document.getElementById('mainImage').click()">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <p>Click to upload new main image</p>
                                        <small>Leave empty to keep current image</small>
                                    </div>
                                    <input type="file" class="d-none" id="mainImage" name="mainImage" 
                                           accept="image/*" onchange="previewMainImage(this)">
                                    <div class="image-preview" id="mainImagePreview"></div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Form Actions -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <a href="/admin/product/view/${product.productId}" class="btn btn-outline-info">
                                    <i class="fas fa-eye me-2"></i>View
                                </a>
                            </div>
                            <div>
                                <a href="/admin/products" class="btn btn-secondary me-2">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Update Product
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;"></div>

<script>
    $(document).ready(function() {
        // Initialize Select2
        $('#categorySelect').select2({
            theme: 'bootstrap-5',
            width: '100%',
            placeholder: 'Select Category'
        });
        
        $('#subCategorySelect').select2({
            theme: 'bootstrap-5',
            width: '100%',
            placeholder: 'Select Sub Category'
        });
        
        // Filter subcategories based on selected category
        $('#categorySelect').on('change', function() {
            const categoryId = $(this).val();
            const currentSubId = '${product.subCategoryId}';
            
            $('#subCategorySelect option').each(function() {
                const $option = $(this);
                if ($option.val() === '') {
                    $option.show();
                } else if ($option.data('category') == categoryId) {
                    $option.show();
                    if ($option.val() == currentSubId) {
                        $option.prop('selected', true);
                    }
                } else {
                    $option.hide();
                }
            });
            
            $('#subCategorySelect').trigger('change');
        });
    });

    function calculateDiscount() {
        const price = parseFloat(document.getElementById('price').value) || 0;
        const mrp = parseFloat(document.getElementById('mrp').value) || 0;
        const discountField = document.getElementById('discountPercent');
        
        if (mrp > 0 && price > 0 && mrp > price) {
            const discount = ((mrp - price) / mrp * 100).toFixed(2);
            discountField.value = discount + '%';
        } else {
            discountField.value = '';
        }
    }

    function previewMainImage(input) {
        const preview = document.getElementById('mainImagePreview');
        preview.innerHTML = '';
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                const previewItem = document.createElement('div');
                previewItem.className = 'preview-item';
                previewItem.innerHTML = `
                    <img src="${e.target.result}" alt="New Main Image">
                    <button type="button" class="remove-btn" onclick="removeMainImage()">
                        <i class="fas fa-times"></i>
                    </button>
                `;
                preview.appendChild(previewItem);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    function removeMainImage() {
        document.getElementById('mainImage').value = '';
        document.getElementById('mainImagePreview').innerHTML = '';
    }

    document.getElementById('productForm').addEventListener('submit', function(e) {
        const price = parseFloat(document.getElementById('price').value) || 0;
        const mrp = parseFloat(document.getElementById('mrp').value) || 0;
        const stock = parseFloat(document.querySelector('[name="stockQuantity"]').value) || 0;
        
        if (price < 0) {
            e.preventDefault();
            showToast('error', 'Price cannot be negative');
            return;
        }
        
        if (mrp < 0) {
            e.preventDefault();
            showToast('error', 'MRP cannot be negative');
            return;
        }
        
        if (stock < 0) {
            e.preventDefault();
            showToast('error', 'Stock quantity cannot be negative');
            return;
        }
        
        if (mrp > 0 && price > mrp) {
            if (!confirm('Price is higher than MRP. Continue?')) {
                e.preventDefault();
                return;
            }
        }
    });

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
    .required-field::after {
        content: " *";
        color: #dc3545;
    }
    
    .image-upload-area {
        border: 2px dashed #dee2e6;
        border-radius: 8px;
        padding: 30px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        background: #f8f9fa;
    }
    
    .image-upload-area:hover {
        border-color: #0d6efd;
        background: #f0f7ff;
    }
    
    .image-upload-area i {
        font-size: 48px;
        color: #6c757d;
        margin-bottom: 15px;
    }
    
    .image-upload-area p {
        margin: 0;
        color: #6c757d;
    }
    
    .image-upload-area small {
        color: #adb5bd;
    }
    
    .image-preview {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin-top: 20px;
    }
    
    .preview-item {
        position: relative;
        width: 100px;
        height: 100px;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        overflow: hidden;
    }
    
    .preview-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .preview-item .remove-btn {
        position: absolute;
        top: 5px;
        right: 5px;
        width: 25px;
        height: 25px;
        background: rgba(220, 53, 69, 0.9);
        border: none;
        border-radius: 50%;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 12px;
        transition: all 0.3s;
    }
    
    .preview-item .remove-btn:hover {
        background: #dc3545;
        transform: scale(1.1);
    }
    
    .current-images-grid {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin-bottom: 15px;
    }
    
    .current-image-item {
        position: relative;
        width: 100px;
        height: 100px;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        overflow: hidden;
    }
    
    .current-image-item.border-primary {
        border-color: #0d6efd;
    }
    
    .current-image-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .current-image-item .badge {
        position: absolute;
        top: 5px;
        left: 5px;
        font-size: 10px;
    }
    
    .toast-container {
        z-index: 9999;
    }
</style>

<%@ include file="footer.jsp" %>