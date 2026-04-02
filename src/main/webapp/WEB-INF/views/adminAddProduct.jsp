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
                <h2><i class="fas fa-plus-circle me-2 text-primary"></i>Add New Product</h2>
                <a href="/admin/products" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Products
                </a>
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
            
            <!-- Product Form -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Product Information</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/product/save" method="post" enctype="multipart/form-data" id="productForm">
                        
                        <!-- Basic Information -->
                        <div class="row mb-4">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="form-label required-field">Product Name</label>
                                    <input type="text" class="form-control" name="productName" 
                                           placeholder="Enter product name" required 
                                           maxlength="200" onkeyup="updateCounter('productNameCounter', this, 200)">
                                    <div class="char-counter text-end mt-1" id="productNameCounter">0/200</div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" name="brand" 
                                           placeholder="Enter brand name" maxlength="100">
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="4" 
                                              placeholder="Enter product description" maxlength="1000"
                                              onkeyup="updateCounter('descCounter', this, 1000)"></textarea>
                                    <div class="char-counter text-end mt-1" id="descCounter">0/1000</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Category Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label required-field">Category</label>
                                    <select class="form-select" name="categoryId" id="categorySelect" required>
                                        <option value="">Select Category</option>
                                        <c:forEach var="category" items="${categoryList}">
                                            <option value="${category.categoryId}" ${category.categoryId == selectedCategoryId ? 'selected' : ''}>
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
                                        <c:forEach var="sub" items="${subCategoryList}">
                                            <option value="${sub.subCategoryId}">${sub.subCategoryName}</option>
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
                                               placeholder="0.00" step="0.01" min="0" required 
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
                                               placeholder="0.00" step="0.01" min="0" 
                                               onchange="calculateDiscount()" id="mrp">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label">Discount %</label>
                                    <input type="text" class="form-control" id="discountPercent" 
                                           placeholder="Auto-calculated" readonly>
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label required-field">Stock Quantity</label>
                                    <input type="number" class="form-control" name="stockQuantity" 
                                           placeholder="0" min="0" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">SKU (Stock Keeping Unit)</label>
                                    <input type="text" class="form-control" name="sku" 
                                           placeholder="e.g., PRD-001" maxlength="50">
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status">
                                        <option value="Available">Available</option>
                                        <option value="Out of Stock">Out of Stock</option>
                                        <option value="Discontinued">Discontinued</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Images Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label required-field">Main Image</label>
                                    <div class="image-upload-area" id="mainImageArea" onclick="document.getElementById('mainImage').click()">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <p>Click to upload main product image</p>
                                        <small>Supported: JPG, PNG, GIF (Max 5MB)</small>
                                    </div>
                                    <input type="file" class="d-none" id="mainImage" name="mainImage" 
                                           accept="image/*" required onchange="previewMainImage(this)">
                                    <div class="image-preview" id="mainImagePreview"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Additional Images (Optional)</label>
                                    <div class="image-upload-area" id="additionalImagesArea" onclick="document.getElementById('additionalImages').click()">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <p>Click to upload additional images</p>
                                        <small>Max 10 images, 5MB each</small>
                                    </div>
                                    <input type="file" class="d-none" id="additionalImages" name="additionalImages" 
                                           accept="image/*" multiple onchange="previewAdditionalImages(this)">
                                    <div class="image-preview" id="additionalImagesPreview"></div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- SEO Section (Optional) -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="mb-3"><i class="fas fa-search me-2 text-primary"></i>SEO Information (Optional)</h6>
                            </div>
                            
                            <div class="col-md-12">
                                <div class="mb-3">
                                    <label class="form-label">Meta Title</label>
                                    <input type="text" class="form-control" name="metaTitle" 
                                           placeholder="SEO title (defaults to product name)" maxlength="100">
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="mb-3">
                                    <label class="form-label">Meta Description</label>
                                    <textarea class="form-control" name="metaDescription" rows="3" 
                                              placeholder="SEO description" maxlength="200"></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Form Actions -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <input type="checkbox" class="form-check-input" id="draft" name="draft">
                                <label class="form-check-label ms-2" for="draft">Save as Draft</label>
                            </div>
                            <div>
                                <button type="reset" class="btn btn-secondary me-2">
                                    <i class="fas fa-undo me-2"></i>Reset
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Save Product
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
document.addEventListener('DOMContentLoaded', function () {
    var categorySelect = document.getElementById('categorySelect');
    var subSelect = document.getElementById('subCategorySelect');

    if (!categorySelect) {
        console.error("Category select not found!");
        return;
    }

    function loadSubcategories(categoryId) {
        // Reset dropdown
        subSelect.innerHTML = '<option value="">Select Sub Category</option>';
        if (!categoryId) return;

        fetch('${pageContext.request.contextPath}/category/' + categoryId + '/subcategories')
            .then(response => response.json())
            .then(data => {
                if (data && data.length) {
                    data.forEach(sub => {
                        var option = document.createElement('option');
                        option.value = sub.subCategoryId;
                        option.textContent = sub.subCategoryName;
                        subSelect.appendChild(option);
                    });
                } else {
                    var option = document.createElement('option');
                    option.value = "";
                    option.textContent = "No subcategories found";
                    option.disabled = true;
                    subSelect.appendChild(option);
                }
                // If using Select2, refresh it
                if (window.jQuery && jQuery.fn.select2) {
                    $(subSelect).trigger('change');
                }
            })
            .catch(error => {
                console.error("Error loading subcategories:", error);
                var option = document.createElement('option');
                option.value = "";
                option.textContent = "Failed to load";
                option.disabled = true;
                subSelect.appendChild(option);
            });
    }

    categorySelect.addEventListener('change', function () {
        loadSubcategories(this.value);
    });

    // If a category is already selected (e.g., after validation error)
    if (categorySelect.value) {
        loadSubcategories(categorySelect.value);
    }
});

    function updateCounter(elementId, input, maxLength) {
        const counter = document.getElementById(elementId);
        const length = input.value.length;
        counter.textContent = length + '/' + maxLength;
        
        if (length > maxLength * 0.9) {
            counter.classList.add('text-warning');
        } else if (length > maxLength * 0.95) {
            counter.classList.add('text-danger');
        } else {
            counter.classList.remove('text-warning', 'text-danger');
        }
    }

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
                    <img src="${e.target.result}" alt="Main Image">
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

    function previewAdditionalImages(input) {
        const preview = document.getElementById('additionalImagesPreview');
        preview.innerHTML = '';
        
        if (input.files) {
            if (input.files.length > 10) {
                showToast('warning', 'You can upload maximum 10 images');
                input.value = '';
                return;
            }
            
            for (let i = 0; i < input.files.length; i++) {
                const file = input.files[i];
                
                if (file.size > 5 * 1024 * 1024) {
                    showToast('warning', 'File ' + file.name + ' exceeds 5MB limit');
                    continue;
                }
                
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const previewItem = document.createElement('div');
                    previewItem.className = 'preview-item';
                    previewItem.innerHTML = `
                        <img src="${e.target.result}" alt="Additional Image ${i+1}">
                        <button type="button" class="remove-btn" onclick="removeAdditionalImage(this)">
                            <i class="fas fa-times"></i>
                        </button>
                    `;
                    preview.appendChild(previewItem);
                }
                
                reader.readAsDataURL(file);
            }
        }
    }

    function removeAdditionalImage(btn) {
        $(btn).closest('.preview-item').remove();
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
        const bgColor = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-warning';
        const icon = type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-exclamation-triangle';
        
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
    
    .char-counter {
        font-size: 12px;
        color: #6c757d;
    }
    
    .toast-container {
        z-index: 9999;
    }
</style>

<%@ include file="footer.jsp" %>