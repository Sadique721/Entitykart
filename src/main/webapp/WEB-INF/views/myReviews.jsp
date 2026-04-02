<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-star me-2 text-warning"></i>My Reviews</h2>
                <div>
                    <a href="/index" class="btn btn-outline-primary">
                        <i class="fas fa-shopping-bag me-2"></i>Continue Shopping
                    </a>
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
            
            <!-- User Review Statistics -->
            <c:if test="${not empty avgRating}">
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted">Your Average Rating</h6>
                                <h2 class="text-warning">${avgRating}</h2>
                            </div>
                            <i class="fas fa-star fa-2x text-warning"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted">Total Reviews</h6>
                                <h2 class="text-primary">${totalReviews}</h2>
                            </div>
                            <i class="fas fa-list fa-2x text-primary"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted">Reviews This Page</h6>
                                <h2 class="text-success">${totalElements}</h2>
                            </div>
                            <i class="fas fa-file-alt fa-2x text-success"></i>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Reviews List -->
            <c:if test="${empty reviews}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" 
                         alt="No Reviews" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">You haven't written any reviews yet</h4>
                    <p class="text-muted">Share your experience with products you've purchased!</p>
                    <a href="/listProduct" class="btn btn-primary mt-2">
                        <i class="fas fa-shopping-bag me-2"></i>Browse Products
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty reviews}">
                <div class="row">
                    <c:forEach var="item" items="${reviews}">
                        <c:set var="review" value="${item.review}" />
                        <c:set var="product" value="${item.product}" />
                        
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">
                                        <i class="fas fa-box me-2 text-primary"></i>
                                        <a href="/viewProduct?productId=${product.productId}" class="text-decoration-none">
                                            ${product.productName}
                                        </a>
                                    </h5>
                                    <span class="badge ${review.rating >= 4 ? 'bg-success' : (review.rating >= 3 ? 'bg-warning' : 'bg-danger')}">
                                        ${review.rating} ★
                                    </span>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="me-3">
                                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/60'}" 
                                                 alt="${product.productName}" 
                                                 class="rounded" 
                                                 style="width: 60px; height: 60px; object-fit: cover;">
                                        </div>
                                        <div>
                                            <div class="mb-2">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:if test="${i <= review.rating}">
                                                        <i class="fas fa-star text-warning"></i>
                                                    </c:if>
                                                    <c:if test="${i > review.rating}">
                                                        <i class="far fa-star text-warning"></i>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <p class="mb-0 text-muted small">
                                                <i class="fas fa-clock me-1"></i>
                                                <!-- FIXED: Using getCreatedAtAsDate() for JSTL formatting -->
                                                <fmt:formatDate value="${review.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                            </p>
                                        </div>
                                    </div>
                                    
                                    <div class="review-content p-3 bg-light rounded">
                                        <p class="mb-0">${review.comment}</p>
                                    </div>
                                    
                                    <div class="mt-3 text-end">
                                        <a href="/review/edit/${review.reviewId}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                        <a href="/review/delete/${review.reviewId}" 
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Delete this review?')">
                                            <i class="fas fa-trash me-1"></i>Delete
                                        </a>
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
                                <a class="page-link" href="/my-reviews?page=${currentPage-1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${totalPages-1}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="/my-reviews?page=${i}">${i+1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="/my-reviews?page=${currentPage+1}">Next</a>
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
    .stat-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        transition: transform 0.2s;
    }
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    .review-content {
        border-left: 3px solid #ffc107;
    }
    .card {
        transition: transform 0.2s;
    }
    .card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .badge {
        font-size: 1rem;
        padding: 8px 12px;
    }
</style>

<%@ include file="footer.jsp" %>