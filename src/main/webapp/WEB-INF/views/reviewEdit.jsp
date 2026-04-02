<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/index">Home</a></li>
                    <li class="breadcrumb-item"><a href="/product/${product.productId}">${product.productName}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Edit Review</li>
                </ol>
            </nav>
            
            <div class="card">
                <div class="card-header bg-white">
                    <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Your Review</h4>
                </div>
                <div class="card-body">
                    
                    <!-- Product Info -->
                    <div class="d-flex align-items-center mb-4 p-3 bg-light rounded">
                        <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/80'}" 
                             width="80" height="80" class="rounded me-3" style="object-fit: cover;">
                        <div>
                            <h5>${product.productName}</h5>
                            <p class="text-muted mb-0">Edit your review for this product</p>
                        </div>
                    </div>
                    
                    <!-- Review Form -->
                    <form action="/review/update" method="post">
                        <input type="hidden" name="reviewId" value="${review.reviewId}">
                        
                        <!-- Rating Selection -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Your Rating <span class="text-danger">*</span></label>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="${i <= review.rating ? 'fas fa-star text-warning' : 'far fa-star'}" data-rating="${i}"></i>
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="rating" id="rating" value="${review.rating}" required>
                                <div id="ratingFeedback" class="text-muted mt-2"></div>
                            </div>
                        </div>
                        
                        <!-- Review Comment -->
                        <div class="mb-4">
                            <label for="comment" class="form-label fw-semibold">Your Review <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="comment" name="comment" rows="5" 
                                      placeholder="What did you like or dislike? What was your experience with this product?" 
                                      required maxlength="1000">${review.comment}</textarea>
                            <div class="text-end mt-1">
                                <small class="text-muted"><span id="charCount">${review.comment.length()}</span>/1000 characters</small>
                            </div>
                        </div>
                        
                        <!-- Form Buttons -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary flex-grow-1">
                                <i class="fas fa-save me-2"></i>Update Review
                            </button>
                            <a href="/product/reviews/${product.productId}" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Rating star interaction
    document.addEventListener('DOMContentLoaded', function() {
        const stars = document.querySelectorAll('.rating-stars i');
        const ratingInput = document.getElementById('rating');
        const ratingFeedback = document.getElementById('ratingFeedback');
        
        // Set initial feedback
        showFeedback(ratingInput.value);
        
        stars.forEach(star => {
            star.addEventListener('mouseenter', function() {
                const rating = this.getAttribute('data-rating');
                highlightStars(rating);
                showFeedback(rating);
            });
            
            star.addEventListener('mouseleave', function() {
                const currentRating = ratingInput.value;
                highlightStars(currentRating);
                showFeedback(currentRating);
            });
            
            star.addEventListener('click', function() {
                const rating = this.getAttribute('data-rating');
                ratingInput.value = rating;
                highlightStars(rating);
                showFeedback(rating);
            });
        });
        
        function highlightStars(rating) {
            stars.forEach(star => {
                const starRating = star.getAttribute('data-rating');
                if (starRating <= rating) {
                    star.className = 'fas fa-star text-warning';
                } else {
                    star.className = 'far fa-star';
                }
            });
        }
        
        function showFeedback(rating) {
            const messages = {
                1: 'Poor - Not satisfied at all',
                2: 'Fair - Could be better',
                3: 'Good - Met expectations',
                4: 'Very Good - Better than expected',
                5: 'Excellent - Outstanding!'
            };
            ratingFeedback.textContent = messages[rating] || '';
        }
    });
    
    // Character counter
    document.getElementById('comment').addEventListener('input', function() {
        const count = this.value.length;
        document.getElementById('charCount').textContent = count;
        
        if (count > 950) {
            document.getElementById('charCount').classList.add('text-warning');
        } else {
            document.getElementById('charCount').classList.remove('text-warning');
        }
        
        if (count >= 1000) {
            document.getElementById('charCount').classList.add('text-danger');
        }
    });
</script>

<style>
    .rating-stars {
        font-size: 2rem;
        cursor: pointer;
    }
    
    .rating-stars i {
        margin-right: 5px;
        transition: transform 0.2s;
    }
    
    .rating-stars i:hover {
        transform: scale(1.2);
    }
</style>

<%@ include file="footer.jsp" %>