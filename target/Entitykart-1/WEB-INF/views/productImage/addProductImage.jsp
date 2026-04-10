<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ page import="com.grownited.entity.ProductEntity" %>

<%
    // Get product from request attribute
    ProductEntity product = (ProductEntity) request.getAttribute("product");
    Integer nextOrder = (Integer) request.getAttribute("nextOrder");
    if (nextOrder == null) nextOrder = 1;
%>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-cloud-upload-alt me-2"></i>Upload Product Image</h4>
                    <a href="/product/images?productId=<%= product != null ? product.getProductId() : "" %>" class="btn btn-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i> Back to Images
                    </a>
                </div>
                <div class="card-body">
                    
                    <!-- Success/Error Messages -->
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i><%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i><%= request.getAttribute("success") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <!-- Product Info -->
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Product:</strong> <%= product != null ? product.getProductName() : "" %> (ID: <%= product != null ? product.getProductId() : "" %>)
                    </div>
                    
                    <!-- Upload Form -->
                    <form action="/product/images/upload" method="post" enctype="multipart/form-data" id="uploadForm">
                        
                        <input type="hidden" name="productId" value="<%= product != null ? product.getProductId() : "" %>">
                        
                        <!-- File Input -->
                        <div class="mb-3">
                            <label class="form-label">Select Image <span class="text-danger">*</span></label>
                            <input type="file" name="imageFile" id="imageFile" 
                                   class="form-control" accept="image/*" required
                                   onchange="previewImage(event)">
                            <small class="text-muted">Allowed: JPG, PNG, GIF, WEBP (Max 5MB)</small>
                        </div>
                        
                        <!-- Image Preview -->
                        <div class="mb-3 text-center" id="previewContainer" style="display: none;">
                            <label class="form-label">Preview:</label>
                            <div>
                                <img id="imagePreview" src="#" alt="Preview" 
                                     style="max-width: 300px; max-height: 300px; border: 1px solid #ddd; padding: 5px;">
                            </div>
                        </div>
                        
                        <!-- Set as Primary -->
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="isPrimary" id="isPrimary" value="true">
                                <label class="form-check-label" for="isPrimary">
                                    <i class="fas fa-star text-warning me-1"></i>
                                    Set as primary image (main product display)
                                </label>
                            </div>
                        </div>
                        
                        <!-- Display Order -->
                        <div class="mb-3">
                            <label class="form-label">Display Order</label>
                            <input type="number" name="displayOrder" class="form-control" 
                                   value="<%= nextOrder %>" min="1" placeholder="Leave empty for automatic ordering">
                            <small class="text-muted">Lower numbers appear first. Leave empty to append at end.</small>
                        </div>
                        
                        <!-- Upload Progress -->
                        <div class="mb-3" id="progressContainer" style="display: none;">
                            <label class="form-label">Uploading...</label>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                     id="uploadProgress" style="width: 0%">0%</div>
                            </div>
                        </div>
                        
                        <!-- Submit Buttons -->
                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-upload me-2"></i>Upload Image
                            </button>
                            <a href="/product/images?productId=<%= product != null ? product.getProductId() : "" %>" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
                    
                    <!-- Bulk Upload Section -->
                    <hr class="my-4">
                    
                    <h5 class="mb-3"><i class="fas fa-layer-group me-2"></i>Bulk Upload</h5>
                    <p class="text-muted">Select multiple images to upload at once (max 10 files)</p>
                    
                    <form action="/product/images/bulk-upload" method="post" enctype="multipart/form-data" id="bulkUploadForm">
                        <input type="hidden" name="productId" value="<%= product != null ? product.getProductId() : "" %>">
                        
                        <div class="mb-3">
                            <input type="file" name="imageFiles" id="imageFiles" 
                                   class="form-control" accept="image/*" multiple required
                                   onchange="updateFileCount()">
                            <small class="text-muted" id="fileCount">No files selected</small>
                        </div>
                        
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-cloud-upload-alt me-2"></i>Upload All
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Preview single image
    function previewImage(event) {
        const file = event.target.files[0];
        const previewContainer = document.getElementById('previewContainer');
        const imagePreview = document.getElementById('imagePreview');
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                previewContainer.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            previewContainer.style.display = 'none';
        }
    }
    
    // Update file count for bulk upload
    function updateFileCount() {
        const files = document.getElementById('imageFiles').files;
        document.getElementById('fileCount').textContent = files.length + ' file(s) selected';
    }
    
    // Show progress bar on form submit
    document.getElementById('uploadForm').addEventListener('submit', function() {
        document.getElementById('submitBtn').disabled = true;
        document.getElementById('progressContainer').style.display = 'block';
        
        // Simulate progress (actual progress would need AJAX with XMLHttpRequest)
        let progress = 0;
        const interval = setInterval(function() {
            progress += 5;
            if (progress <= 90) {
                document.getElementById('uploadProgress').style.width = progress + '%';
                document.getElementById('uploadProgress').textContent = progress + '%';
            } else {
                clearInterval(interval);
            }
        }, 200);
    });
    
    // Auto-hide alerts
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            if (alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }
        });
    }, 5000);
</script>

<%@ include file="../footer.jsp" %>