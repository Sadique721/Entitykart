<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-star me-2 text-warning"></i>Reviews for ${product.productName}</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/product/${product.productId}" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to Product
                    </a>
                    <c:if test="${sessionScope.user != null}">
                        <c:set var="userHasReviewed" value="false" />
                        <c:forEach var="reviewRow" items="${reviews}">
                            <c:if test="${reviewRow[0].customerId == sessionScope.user.userId}">
                                <c:set var="userHasReviewed" value="true" />
                            </c:if>
                        </c:forEach>
                        <c:if test="${!userHasReviewed}">
                            <a href="/review/write/${product.productId}" class="btn btn-primary">
                                <i class="fas fa-pen me-2"></i>Write a Review
                            </a>
                        </c:if>
                        <c:if test="${userHasReviewed}">
                            <span class="badge bg-success p-2">You've reviewed this product</span>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.user == null}">
                        <a href="/login" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Login to Review
                        </a>
                    </c:if>
                </div>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>
            
            <!-- Rating Summary -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h1 class="display-1 text-warning">${avgRating}</h1>
                            <div class="mb-2">
                                <c:set var="avgRatingNum" value="${empty avgRating ? 0 : (avgRating.getClass().name eq 'java.lang.String' ? Double.parseDouble(avgRating) : avgRating)}" />
                                <c:forEach begin="1" end="5" var="i">
                                    <c:if test="${i <= avgRatingNum}">
                                        <i class="fas fa-star text-warning fa-2x"></i>
                                    </c:if>
                                    <c:if test="${i > avgRatingNum && (i - avgRatingNum) > 0.5}">
                                        <i class="far fa-star text-warning fa-2x"></i>
                                    </c:if>
                                    <c:if test="${i > avgRatingNum && (i - avgRatingNum) <= 0.5 && (i - avgRatingNum) > 0}">
                                        <i class="fas fa-star-half-alt text-warning fa-2x"></i>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <p class="lead">${totalReviews} review<c:if test="${totalReviews != 1}">s</c:if></p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">Rating Distribution</h5>
                        </div>
                        <div class="card-body">
                            <!-- FIXED: Using separate loops for each star rating instead of step="-1" -->
                            <!-- 5 Star Rating -->
                            <div class="row align-items-center mb-2">
                                <div class="col-md-2 text-end">
                                    <strong>5 stars</strong>
                                </div>
                                <div class="col-md-8">
                                    <div class="progress">
                                        <c:set var="percentage5" value="${totalReviews > 0 ? (ratingCount[5] * 100 / totalReviews) : 0}" />
                                        <div class="progress-bar bg-warning" role="progressbar" 
                                             style="width: ${percentage5}%"
                                             aria-valuenow="${ratingCount[5]}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="${totalReviews}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="text-muted">${ratingCount[5]} review<c:if test="${ratingCount[5] != 1}">s</c:if></span>
                                </div>
                            </div>
                            
                            <!-- 4 Star Rating -->
                            <div class="row align-items-center mb-2">
                                <div class="col-md-2 text-end">
                                    <strong>4 stars</strong>
                                </div>
                                <div class="col-md-8">
                                    <div class="progress">
                                        <c:set var="percentage4" value="${totalReviews > 0 ? (ratingCount[4] * 100 / totalReviews) : 0}" />
                                        <div class="progress-bar bg-warning" role="progressbar" 
                                             style="width: ${percentage4}%"
                                             aria-valuenow="${ratingCount[4]}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="${totalReviews}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="text-muted">${ratingCount[4]} review<c:if test="${ratingCount[4] != 1}">s</c:if></span>
                                </div>
                            </div>
                            
                            <!-- 3 Star Rating -->
                            <div class="row align-items-center mb-2">
                                <div class="col-md-2 text-end">
                                    <strong>3 stars</strong>
                                </div>
                                <div class="col-md-8">
                                    <div class="progress">
                                        <c:set var="percentage3" value="${totalReviews > 0 ? (ratingCount[3] * 100 / totalReviews) : 0}" />
                                        <div class="progress-bar bg-warning" role="progressbar" 
                                             style="width: ${percentage3}%"
                                             aria-valuenow="${ratingCount[3]}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="${totalReviews}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="text-muted">${ratingCount[3]} review<c:if test="${ratingCount[3] != 1}">s</c:if></span>
                                </div>
                            </div>
                            
                            <!-- 2 Star Rating -->
                            <div class="row align-items-center mb-2">
                                <div class="col-md-2 text-end">
                                    <strong>2 stars</strong>
                                </div>
                                <div class="col-md-8">
                                    <div class="progress">
                                        <c:set var="percentage2" value="${totalReviews > 0 ? (ratingCount[2] * 100 / totalReviews) : 0}" />
                                        <div class="progress-bar bg-warning" role="progressbar" 
                                             style="width: ${percentage2}%"
                                             aria-valuenow="${ratingCount[2]}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="${totalReviews}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="text-muted">${ratingCount[2]} review<c:if test="${ratingCount[2] != 1}">s</c:if></span>
                                </div>
                            </div>
                            
                            <!-- 1 Star Rating -->
                            <div class="row align-items-center mb-2">
                                <div class="col-md-2 text-end">
                                    <strong>1 star</strong>
                                </div>
                                <div class="col-md-8">
                                    <div class="progress">
                                        <c:set var="percentage1" value="${totalReviews > 0 ? (ratingCount[1] * 100 / totalReviews) : 0}" />
                                        <div class="progress-bar bg-warning" role="progressbar" 
                                             style="width: ${percentage1}%"
                                             aria-valuenow="${ratingCount[1]}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="${totalReviews}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="text-muted">${ratingCount[1]} review<c:if test="${ratingCount[1] != 1}">s</c:if></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reviews List -->
            <c:if test="${empty reviews}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" 
                         alt="No Reviews" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">No Reviews Yet</h4>
                    <p class="text-muted">Be the first to review this product!</p>
                    <c:if test="${sessionScope.user != null}">
                        <a href="/review/write/${product.productId}" class="btn btn-primary mt-2">
                            <i class="fas fa-pen me-2"></i>Write a Review
                        </a>
                    </c:if>
                </div>
            </c:if>
            
            <c:if test="${not empty reviews}">
                <div class="row">
                    <c:forEach var="row" items="${reviews}" varStatus="status">
                        <c:set var="review" value="${row[0]}" />
                        <c:set var="userName" value="${row[1]}" />
                        <c:set var="userPic" value="${row[2]}" />
                        
                        <div class="col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1 text-center">
                                            <img src="${userPic != null ? userPic : 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'}" 
                                                 class="rounded-circle img-fluid mb-2" 
                                                 style="width: 60px; height: 60px; object-fit: cover; border: 2px solid #dee2e6;"
                                                 alt="${userName}">
                                            <h6 class="mb-0">${userName}</h6>
                                        </div>
                                        <div class="col-md-11">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="w-100">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <div>
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <c:if test="${i <= review.rating}">
                                                                    <i class="fas fa-star text-warning"></i>
                                                                </c:if>
                                                                <c:if test="${i > review.rating}">
                                                                    <i class="far fa-star text-warning"></i>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                        <div>
                                                            <!-- Edit/Delete buttons for user's own reviews -->
                                                            <c:if test="${sessionScope.user != null && sessionScope.user.userId == review.customerId}">
                                                                <a href="/review/edit/${review.reviewId}" class="btn btn-sm btn-outline-primary me-1">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <a href="/review/delete/${review.reviewId}" class="btn btn-sm btn-outline-danger" 
                                                                   onclick="return confirm('Delete this review?')">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </c:if>
                                                            <!-- Admin delete button -->
                                                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN' && sessionScope.user.userId != review.customerId}">
                                                                <a href="/admin/review/delete?reviewId=${review.reviewId}" 
                                                                   class="btn btn-sm btn-outline-danger"
                                                                   onclick="return confirm('Delete this review?')">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <p class="mb-2">${review.comment}</p>
                                                    <p class="text-muted small mb-0">
                                                        <i class="fas fa-clock me-1"></i>
                                                        Reviewed on <fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy, hh:mm a"/>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="/product/reviews/${product.productId}?page=${currentPage-1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${totalPages-1}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="/product/reviews/${product.productId}?page=${i}">${i+1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="/product/reviews/${product.productId}?page=${currentPage+1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

<!-- Auto-hide alerts -->
<script>
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            try {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            } catch(e) {
                console.error('Error closing alert:', e);
            }
        });
    }, 5000);
</script>

<style>
    .progress {
        height: 25px;
        border-radius: 12.5px;
        background-color: #f0f0f0;
    }
    .progress-bar {
        border-radius: 12.5px;
        background-color: #ffc107;
    }
    .display-1 {
        font-size: 5rem;
        line-height: 1.2;
    }
    .fa-star, .fa-star-half-alt {
        margin-right: 2px;
    }
    .card {
        transition: transform 0.2s;
    }
    .card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
</style>

<%@ include file="footer.jsp" %>