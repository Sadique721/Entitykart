<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>Product Details</h4>
                    <a href="/listProduct" class="btn btn-secondary">Back to List</a>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <img src="${productEntity.mainImageURL != null ? productEntity.mainImageURL : 'https://via.placeholder.com/300'}" 
                                 class="img-fluid rounded" alt="${productEntity.productName}">
                        </div>
                        <div class="col-md-8">
                            <table class="table table-bordered">
                                <tr>
                                    <th style="width: 200px;">Product ID</th>
                                    <td>${productEntity.productId}</td>
                                </tr>
                                <tr>
                                    <th>Product Name</th>
                                    <td>${productEntity.productName}</td>
                                </tr>
                                <tr>
                                    <th>Brand</th>
                                    <td>${productEntity.brand}</td>
                                </tr>
                                <tr>
                                    <th>Description</th>
                                    <td>${productEntity.description}</td>
                                </tr>
                                <tr>
                                    <th>Category</th>
                                    <td>
                                        <c:forEach var="cat" items="${categoryList}">
                                            <c:if test="${cat.categoryId == productEntity.categoryId}">
                                                ${cat.categoryName}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Sub Category</th>
                                    <td>
                                        <c:forEach var="sub" items="${subCategories}">
                                            <c:if test="${sub.subCategoryId == productEntity.subCategoryId}">
                                                ${sub.childCategory}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Price</th>
                                    <td><i class="fas fa-rupee-sign"></i> ${productEntity.price}</td>
                                </tr>
                                <tr>
                                    <th>MRP</th>
                                    <td><i class="fas fa-rupee-sign"></i> ${productEntity.mrp}</td>
                                </tr>
                                <tr>
                                    <th>Stock Quantity</th>
                                    <td>${productEntity.stockQuantity}</td>
                                </tr>
                                <tr>
                                    <th>SKU</th>
                                    <td>${productEntity.sku}</td>
                                </tr>
                                <tr>
                                    <th>Status</th>
                                    <td>
                                        <span class="badge ${productEntity.status == 'Available' ? 'bg-success' : 'bg-warning'}">
                                            ${productEntity.status}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Created At</th>
                                    <td>${productEntity.createdAt}</td>
                                </tr>
                            </table>
                            
                            <!-- Action Buttons -->
                            <div class="mt-3">
                                <c:if test="${productEntity.stockQuantity > 0}">
                                    <a href="/cart/add?productId=${productEntity.productId}" class="btn btn-primary">
                                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                    </a>
                                    <a href="/checkout?productId=${productEntity.productId}&quantity=1" class="btn btn-success">
                                        <i class="fas fa-bolt me-2"></i>Buy Now
                                    </a>
                                </c:if>
                                <c:if test="${productEntity.stockQuantity <= 0}">
                                    <button class="btn btn-secondary" disabled>
                                        <i class="fas fa-times-circle me-2"></i>Out of Stock
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Product Images Tab -->
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-12">
            <ul class="nav nav-tabs" id="productTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="details-tab" data-bs-toggle="tab" 
                            data-bs-target="#details" type="button" role="tab">Product Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="images-tab" data-bs-toggle="tab" 
                            data-bs-target="#images" type="button" role="tab">
                        <i class="fas fa-images me-1"></i>Images 
                        <span class="badge bg-primary" id="imageCount">0</span>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" 
                            data-bs-target="#reviews" type="button" role="tab">
                        <i class="fas fa-star me-1"></i>Reviews
                        <span class="badge bg-warning" id="reviewCount">0</span>
                    </button>
                </li>
            </ul>
            
            <div class="tab-content p-3 border border-top-0 rounded-bottom" id="productTabsContent">
                <!-- Details Tab -->
                <div class="tab-pane fade show active" id="details" role="tabpanel">
                    <!-- Product details already shown above -->
                    <p class="text-muted">Product details are shown in the table above.</p>
                </div>
                
                <!-- Images Tab -->
                <div class="tab-pane fade" id="images" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5><i class="fas fa-images me-2"></i>Product Gallery</h5>
                        <a href="/product/images?productId=${productEntity.productId}" class="btn btn-sm btn-primary">
                            <i class="fas fa-edit me-1"></i>Manage Images
                        </a>
                    </div>
                    
                    <!-- Image Gallery will be loaded via AJAX -->
                    <div id="imageGalleryContainer" class="text-center py-4">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
                
                <!-- Reviews Tab -->
                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <!-- Review Section (Moved inside tab) -->
                    <div class="mt-2">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5><i class="fas fa-star me-2"></i>Customer Reviews</h5>
                            <a href="/product/reviews/${productEntity.productId}" class="btn btn-outline-primary btn-sm">
                                View All Reviews <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                        
                        <!-- Review Summary -->
                        <div class="row mb-4" id="reviewSummary">
                            <div class="col-md-3 text-center">
                                <h1 class="display-4 text-warning" id="avgRating">-</h1>
                                <div id="starRating" class="mb-2"></div>
                                <p class="text-muted" id="totalReviews">- reviews</p>
                            </div>
                            <div class="col-md-9" id="ratingDistribution"></div>
                        </div>
                        
                        <!-- Recent Reviews -->
                        <div id="recentReviews"></div>
                        
                        <!-- Write Review Button -->
                        <div class="text-center mt-3">
                            <a href="/review/write/${productEntity.productId}" class="btn btn-primary">
                                <i class="fas fa-pen me-2"></i>Write a Review
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Load images when tab is clicked
    document.getElementById('images-tab').addEventListener('click', function() {
        loadProductImages(${productEntity.productId});
    });
    
    // Load reviews when tab is clicked
    document.getElementById('reviews-tab').addEventListener('click', function() {
        loadReviewSummary();
        loadRecentReviews();
    });
    
    function loadProductImages(productId) {
        fetch('/api/product/' + productId + '/images')
            .then(response => response.json())
            .then(data => {
                const container = document.getElementById('imageGalleryContainer');
                const countBadge = document.getElementById('imageCount');
                
                countBadge.textContent = data.length;
                
                if (data.length === 0) {
                    container.innerHTML = '<p class="text-muted">No images available for this product.</p>';
                    return;
                }
                
                let html = '<div class="row">';
                data.forEach(image => {
                    html += `
                        <div class="col-md-3 col-sm-4 mb-3">
                            <div class="card">
                                <img src="\${image.imageURL}" class="card-img-top" 
                                     style="height: 150px; object-fit: cover;">
                                <div class="card-body p-2 text-center">
                                    ${image.primary ? '<span class="badge bg-warning text-dark">Primary</span>' : ''}
                                    <small class="text-muted d-block mt-1">
                                        Order: \${image.displayOrder}
                                    </small>
                                </div>
                            </div>
                        </div>
                    `;
                });
                html += '</div>';
                container.innerHTML = html;
            })
            .catch(error => {
                document.getElementById('imageGalleryContainer').innerHTML = 
                    '<p class="text-danger">Error loading images: ' + error + '</p>';
            });
    }
    
    function loadReviewSummary() {
        fetch('/api/product/${productEntity.productId}/rating')
            .then(response => response.json())
            .then(data => {
                document.getElementById('avgRating').textContent = data.avgRating;
                document.getElementById('totalReviews').textContent = data.totalReviews + ' reviews';
                document.getElementById('reviewCount').textContent = data.totalReviews;
                
                // Generate star rating
                const starRating = document.getElementById('starRating');
                starRating.innerHTML = '';
                const avg = parseFloat(data.avgRating);
                for (let i = 1; i <= 5; i++) {
                    if (i <= avg) {
                        starRating.innerHTML += '<i class="fas fa-star text-warning"></i>';
                    } else if (i - avg < 1 && i - avg > 0) {
                        starRating.innerHTML += '<i class="fas fa-star-half-alt text-warning"></i>';
                    } else {
                        starRating.innerHTML += '<i class="far fa-star text-warning"></i>';
                    }
                }
                
                // Generate distribution
                const dist = document.getElementById('ratingDistribution');
                dist.innerHTML = '';
                for (let i = 5; i >= 1; i--) {
                    const count = data.distribution[i] || 0;
                    const percentage = data.totalReviews > 0 ? (count / data.totalReviews * 100) : 0;
                    dist.innerHTML += `
                        <div class="row align-items-center mb-2">
                            <div class="col-md-2 text-end">${i} star</div>
                            <div class="col-md-8">
                                <div class="progress" style="height: 20px;">
                                    <div class="progress-bar bg-warning" role="progressbar" 
                                         style="width: ${percentage}%" 
                                         aria-valuenow="${percentage}" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100">
                                        ${count}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">${count}</div>
                        </div>
                    `;
                }
            })
            .catch(error => console.error('Error loading review summary:', error));
    }
    
    function loadRecentReviews() {
        fetch('/api/product/${productEntity.productId}/recent-reviews')
            .then(response => response.json())
            .then(reviews => {
                const container = document.getElementById('recentReviews');
                if (reviews.length === 0) {
                    container.innerHTML = '<p class="text-muted text-center">No reviews yet. Be the first to review!</p>';
                    return;
                }
                
                container.innerHTML = '';
                reviews.forEach(review => {
                    let stars = '';
                    for (let i = 1; i <= 5; i++) {
                        stars += i <= review.rating ? 
                            '<i class="fas fa-star text-warning"></i>' : 
                            '<i class="far fa-star text-warning"></i>';
                    }
                    
                    container.innerHTML += `
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-2">
                                    <img src="\${review.userPic || 'https://via.placeholder.com/40'}" 
                                         class="rounded-circle me-2" width="40" height="40" style="object-fit: cover;">
                                    <div>
                                        <h6 class="mb-0">\${review.userName}</h6>
                                        <small class="text-muted">\${review.date}</small>
                                    </div>
                                </div>
                                <div class="mb-2">\${stars}</div>
                                <p class="mb-0">\${review.comment}</p>
                            </div>
                        </div>
                    `;
                });
            })
            .catch(error => console.error('Error loading recent reviews:', error));
    }
    
    // Load reviews by default if the reviews tab is active
    document.addEventListener('DOMContentLoaded', function() {
        // Check if reviews tab is active (you can set a parameter to control this)
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('tab') === 'reviews') {
            document.getElementById('reviews-tab').click();
        }
    });
</script>

<style>
    .display-4 {
        font-size: 3.5rem;
        font-weight: 300;
        line-height: 1.2;
    }
    
    .progress {
        height: 20px;
        border-radius: 10px;
        background-color: #e9ecef;
    }
    
    .progress-bar {
        border-radius: 10px;
        background-color: #ffc107;
        color: #212529;
        font-weight: 500;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .nav-tabs .nav-link {
        color: #495057;
        font-weight: 500;
    }
    
    .nav-tabs .nav-link.active {
        color: var(--primary-blue);
        font-weight: 600;
        border-bottom: 2px solid var(--primary-blue);
    }
    
    .rating-stars i {
        font-size: 1.2rem;
        margin-right: 2px;
    }
    
    .btn-primary {
        background-color: var(--primary-blue);
        border-color: var(--primary-blue);
    }
    
    .btn-primary:hover {
        background-color: #1e5fd8;
        border-color: #1e5fd8;
    }
    
    .btn-success {
        background-color: var(--primary-orange);
        border-color: var(--primary-orange);
    }
    
    .btn-success:hover {
        background-color: #e55a17;
        border-color: #e55a17;
    }
    
    .badge.bg-warning {
        color: #212529 !important;
    }
    
    /* Card hover effect for reviews */
    .card {
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .display-4 {
            font-size: 2.5rem;
        }
        
        .col-md-3.text-center {
            margin-bottom: 20px;
        }
    }
</style>

<%@ include file="footer.jsp" %>