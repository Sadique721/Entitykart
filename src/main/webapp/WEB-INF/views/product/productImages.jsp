<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.grownited.entity.ProductImageEntity" %>
<%@ page import="java.util.List" %>

<%-- VERSION: 2.0 - FIXED DATE FORMATTING --%>

<%
    // Create formatters at the top
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
    
    // Get data from request attributes
    com.grownited.entity.ProductEntity product = (com.grownited.entity.ProductEntity) request.getAttribute("product");
    List<ProductImageEntity> images = (List<ProductImageEntity>) request.getAttribute("images");
    ProductImageEntity primaryImage = (ProductImageEntity) request.getAttribute("primaryImage");
    Integer imageCount = (Integer) request.getAttribute("imageCount");
    if (imageCount == null) imageCount = 0;
%>

<!-- DEBUG INFO - Version 2.0 - This file was updated on <%= new java.util.Date() %> -->
<div class="alert alert-info">
    <strong>DEBUG:</strong> This is the FIXED version of productImages.jsp (v2.0)
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2><i class="fas fa-images me-2"></i>Product Images</h2>
                    <p class="text-muted">
                        <a href="/viewProduct?productId=<%= product != null ? product.getProductId() : "" %>" class="text-decoration-none">
                            <%= product != null ? product.getProductName() : "" %>
                        </a> 
                        <span class="mx-2">|</span> 
                        <span class="badge bg-info"><%= imageCount %> Image(s)</span>
                    </p>
                </div>
                <div>
                    <a href="/product/images/add?productId=<%= product != null ? product.getProductId() : "" %>" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Image
                    </a>
                    <a href="/admin/product/view/<%= product != null ? product.getProductId() : "" %>" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Product
                    </a>
                </div>
            </div>
            
            <!-- Success/Error Messages from Parameters -->
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= request.getParameter("success") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Flash Messages from Attributes -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= request.getAttribute("success") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Empty State -->
            <% if (images == null || images.isEmpty()) { %>
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076478.png" 
                         alt="No Images" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">No Images Found</h4>
                    <p class="text-muted">This product doesn't have any images yet.</p>
                    <a href="/product/images/add?productId=<%= product != null ? product.getProductId() : "" %>" class="btn btn-primary mt-2">
                        <i class="fas fa-plus me-2"></i>Upload First Image
                    </a>
                </div>
            <% } else { %>
                
                <!-- Primary Image Highlight -->
                <% if (primaryImage != null) { %>
                    <div class="card mb-4 border-primary">
                        <div class="card-header bg-primary text-white">
                            <i class="fas fa-star me-2"></i>Primary Image (Main Display)
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-3 text-center">
                                    <img src="<%= primaryImage.getImageURL() %>" alt="Primary" 
                                         class="img-fluid rounded" style="max-height: 150px;">
                                </div>
                                <div class="col-md-9">
                                    <p><strong>Image ID:</strong> <%= primaryImage.getProductImageId() %></p>
                                    <p><strong>Uploaded:</strong> 
                                        <%= primaryImage.getCreatedAt() != null ? 
                                            primaryImage.getCreatedAt().format(dateTimeFormatter) : "" %>
                                    </p>
                                    <p><strong>URL:</strong> 
                                        <a href="<%= primaryImage.getImageURL() %>" target="_blank" class="text-truncate d-block">
                                            <%= primaryImage.getImageURL() %>
                                        </a>
                                    </p>
                                    <a href="/product/images/delete?imageId=<%= primaryImage.getProductImageId() %>" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Are you sure you want to delete the primary image?')">
                                        <i class="fas fa-trash me-1"></i>Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
                
                <!-- Gallery Images -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-images me-2"></i>Image Gallery</h5>
                        <small class="text-muted">Drag and drop to reorder</small>
                    </div>
                    <div class="card-body">
                        <div class="row" id="imageGallery">
                            <% for (ProductImageEntity image : images) { 
                                if (!image.isPrimary()) { %>
                                    <div class="col-md-3 col-sm-6 mb-3 gallery-item" data-id="<%= image.getProductImageId() %>">
                                        <div class="card h-100">
                                            <div class="position-relative">
                                                <img src="<%= image.getImageURL() %>" class="card-img-top" 
                                                     alt="Product Image" style="height: 150px; object-fit: cover;">
                                                <span class="position-absolute top-0 start-0 badge bg-secondary m-2">
                                                    Order: <%= image.getDisplayOrder() %>
                                                </span>
                                            </div>
                                            <div class="card-body p-2">
                                                <div class="btn-group w-100" role="group">
                                                    <a href="/product/images/set-primary?imageId=<%= image.getProductImageId() %>" 
                                                       class="btn btn-sm btn-warning"
                                                       title="Set as Primary">
                                                        <i class="fas fa-star"></i>
                                                    </a>
                                                    <a href="/product/images/delete?imageId=<%= image.getProductImageId() %>" 
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Delete this image?')"
                                                       title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                                <small class="text-muted d-block text-center mt-1">
                                                    <%= image.getCreatedAt() != null ? 
                                                        image.getCreatedAt().format(dateFormatter) : "" %>
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                            <% } 
                            } %>
                        </div>
                    </div>
                </div>
                
                <!-- Reorder Instructions -->
                <div class="alert alert-info mt-3">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Tip:</strong> Drag and drop images to reorder them. The order determines how images appear on the product page.
                    <button class="btn btn-sm btn-primary ms-3" onclick="saveOrder()" id="saveOrderBtn" style="display: none;">
                        <i class="fas fa-save me-1"></i>Save Order
                    </button>
                </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Drag and Drop Script -->
<script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
<script>
    let sortable;
    
    document.addEventListener('DOMContentLoaded', function() {
        const gallery = document.getElementById('imageGallery');
        if (gallery) {
            sortable = new Sortable(gallery, {
                animation: 150,
                ghostClass: 'bg-light',
                onEnd: function() {
                    document.getElementById('saveOrderBtn').style.display = 'inline-block';
                }
            });
        }
    });
    
    function saveOrder() {
        const items = document.querySelectorAll('.gallery-item');
        const order = Array.from(items).map(item => item.dataset.id).join(',');
        
        if (!order) {
            alert('No images to reorder');
            return;
        }
        
        const btn = document.getElementById('saveOrderBtn');
        const originalText = btn.innerHTML;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Saving...';
        btn.disabled = true;
        
        fetch('/product/images/reorder', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'productId=<%= product != null ? product.getProductId() : "" %>&order=' + encodeURIComponent(order)
        })
        .then(response => response.text())
        .then(data => {
            if (data === 'SUCCESS') {
                alert('Order saved successfully!');
                location.reload();
            } else {
                alert('Error saving order: ' + data);
            }
        })
        .catch(error => {
            alert('Error: ' + error);
        })
        .finally(() => {
            btn.innerHTML = originalText;
            btn.disabled = false;
            btn.style.display = 'none';
        });
    }
    
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

<style>
    .gallery-item {
        cursor: move;
        transition: transform 0.2s;
    }
    
    .gallery-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .sortable-ghost {
        opacity: 0.4;
        background-color: #f8f9fa;
    }
</style>

<%@ include file="../footer.jsp" %>