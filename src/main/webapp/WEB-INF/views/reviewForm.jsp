<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-star me-2"></i>Write a Review</h2>
                <a href="/viewProduct?productId=${productId}" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Product
                </a>
            </div>
            
            <!-- Product Summary -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2">
                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/100'}" 
                                 class="img-fluid rounded" alt="${product.productName}">
                        </div>
                        <div class="col-md-10">
                            <h5>${product.productName}</h5>
                            <p class="text-muted mb-1">Brand: ${product.brand}</p>
                            <p class="mb-0"><strong>Price:</strong> <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></p>
                            
                            <c:if test="${not empty order}">
                                <div class="alert alert-success mt-2 mb-0 py-2">
                                    <i class="fas fa-check-circle me-1"></i>
                                    You purchased this on <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Review Form -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Your Review</h5>
                </div>
                <div class="card-body">
                    <form action="/review/submit" method="post" id="reviewForm">
                        <input type="hidden" name="productId" value="${productId}">
                        <c:if test="${not empty orderItem}">
                            <input type="hidden" name="orderItemId" value="${orderItem.orderItemId}">
                        </c:if>
                        
                        <!-- Rating -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">Your Rating <span class="text-danger">*</span></label>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="far fa-star" data-rating="1"></i>
                                    <i class="far fa-star" data-rating="2"></i>
                                    <i class="far fa-star" data-rating="3"></i>
                                    <i class="far fa-star" data-rating="4"></i>
                                    <i class="far fa-star" data-rating="5"></i>
                                </div>
                                <input type="hidden" name="rating" id="ratingValue" required>
                                <div class="rating-text mt-2" id="ratingText"></div>
                            </div>
                        </div>
                        
                        <!-- Review Comment -->
                        <div class="mb-4">
                            <label for="comment" class="form-label fw-bold">Your Review <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="comment" name="comment" rows="5" 
                                      placeholder="Share your experience with this product... What did you like? What could be improved?" required></textarea>
                            <div class="form-text">Minimum 10 characters, maximum 500 characters.</div>
                        </div>
                        
                        <!-- Tips for writing a good review -->
                        <div class="alert alert-info mb-4">
                            <h6 class="alert-heading"><i class="fas fa-lightbulb me-2"></i>Tips for writing a helpful review:</h6>
                            <ul class="mb-0 small">
                                <li>Be specific about the product features</li>
                                <li>Share your experience using the product</li>
                                <li>Mention what you liked and what could be improved</li>
                                <li>Include information about quality, durability, etc.</li>
                            </ul>
                        </div>
                        
                        <!-- Submit Buttons -->
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-outline-secondary" onclick="history.back()">
                                <i class="fas fa-times me-2"></i>Cancel
                            </button>
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-paper-plane me-2"></i>Submit Review
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Rating stars functionality
    const stars = document.querySelectorAll('.rating-stars i');
    const ratingInput = document.getElementById('ratingValue');
    const ratingText = document.getElementById('ratingText');
    
    const ratingLabels = {
        1: 'Poor - Not satisfied at all',
        2: 'Fair - Could be better',
        3: 'Good - Met expectations',
        4: 'Very Good - Exceeded expectations',
        5: 'Excellent - Outstanding!'
    };
    
    stars.forEach(star => {
        star.addEventListener('mouseenter', function() {
            const rating = this.dataset.rating;
            highlightStars(rating);
        });
        
        star.addEventListener('mouseleave', function() {
            const currentRating = ratingInput.value;
            if (currentRating) {
                highlightStars(currentRating);
                updateRatingText(currentRating);
            } else {
                resetStars();
                ratingText.textContent = '';
            }
        });
        
        star.addEventListener('click', function() {
            const rating = this.dataset.rating;
            ratingInput.value = rating;
            highlightStars(rating);
            updateRatingText(rating);
            
            // Remove required attribute once rating is selected
            ratingInput.removeAttribute('required');
        });
    });
    
    function highlightStars(rating) {
        resetStars();
        for (let i = 1; i <= rating; i++) {
            document.querySelector(`.rating-stars i[data-rating="${i}"]`).className = 'fas fa-star';
        }
    }
    
    function resetStars() {
        stars.forEach(star => {
            star.className = 'far fa-star';
        });
    }
    
    function updateRatingText(rating) {
        ratingText.textContent = ratingLabels[rating] || '';
        ratingText.className = 'rating-text mt-2 fw-bold text-primary';
    }
    
    // Character counter for comment
    const commentInput = document.getElementById('comment');
    const charCounter = document.createElement('div');
    charCounter.className = 'text-end small mt-1';
    charCounter.id = 'charCounter';
    commentInput.parentNode.appendChild(charCounter);
    
    commentInput.addEventListener('input', function() {
        const length = this.value.length;
        charCounter.textContent = length + ' / 500 characters';
        
        if (length < 10) {
            charCounter.className = 'text-end small mt-1 text-danger';
        } else if (length > 450) {
            charCounter.className = 'text-end small mt-1 text-warning';
        } else {
            charCounter.className = 'text-end small mt-1 text-muted';
        }
        
        if (length > 500) {
            this.value = this.value.substring(0, 500);
        }
    });
    
    // Form validation
    document.getElementById('reviewForm').addEventListener('submit', function(e) {
        const rating = ratingInput.value;
        const comment = commentInput.value.trim();
        
        if (!rating) {
            e.preventDefault();
            alert('Please select a rating');
            return;
        }
        
        if (comment.length < 10) {
            e.preventDefault();
            alert('Please write at least 10 characters in your review');
            commentInput.focus();
            return;
        }
        
        // Show loading state
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Submitting...';
        submitBtn.disabled = true;
    });
</script>

<style>
    .rating-stars {
        font-size: 32px;
        color: #ffc107;
        cursor: pointer;
        display: inline-block;
    }
    
    .rating-stars i {
        margin-right: 8px;
        transition: all 0.2s;
    }
    
    .rating-stars i:hover {
        transform: scale(1.1);
    }
    
    .rating-text {
        font-size: 16px;
    }
    
    .alert-info {
        border-left: 4px solid var(--primary-blue);
    }
    
    .alert-success {
        border-left: 4px solid var(--success-green);
    }
</style>

<%@ include file="footer.jsp" %>