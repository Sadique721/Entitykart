<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-address-book me-2"></i>My Addresses</h2>
                <a href="/address" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Address
                </a>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>
            
            <!-- Address List -->
            <c:if test="${empty addressList}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076478.png" 
                         alt="No Address" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-3 text-muted">No Address Found</h4>
                    <p class="text-muted">You haven't added any address yet.</p>
                    <a href="/address" class="btn btn-primary mt-2">
                        <i class="fas fa-plus me-2"></i>Add Your First Address
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty addressList}">
                <div class="row">
                    <c:forEach var="address" items="${addressList}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100 ${address.isDefault ? 'border-primary' : ''}">
                                <c:if test="${address.isDefault}">
                                    <div class="position-absolute top-0 end-0 m-2">
                                        <span class="badge bg-primary">
                                            <i class="fas fa-check-circle me-1"></i>Default
                                        </span>
                                    </div>
                                </c:if>
                                
                                <div class="card-body">
                                    <!-- Address Type Badge -->
                                    <div class="mb-3">
                                        <c:choose>
                                            <c:when test="${address.addressType == 'HOME'}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-home me-1"></i>Home
                                                </span>
                                            </c:when>
                                            <c:when test="${address.addressType == 'OFFICE'}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="fas fa-briefcase me-1"></i>Office
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info">
                                                    <i class="fas fa-map-pin me-1"></i>Other
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <!-- Address Details -->
                                    <h5 class="card-title mb-1">${address.fullName}</h5>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-phone me-1"></i>${address.mobileNo}
                                    </p>
                                    
                                    <div class="address-details mb-3">
                                        <p class="mb-1">
                                            <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                                            ${address.addressLine1}
                                        </p>
                                        <p class="mb-1">
                                            ${address.city}, ${address.state} - ${address.pincode}
                                        </p>
                                    </div>
                                    
                                    <!-- Action Buttons -->
                                    <div class="btn-group w-100" role="group">
                                        <a href="/editAddress?id=${address.addressId}" 
                                           class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                        <c:if test="${!address.isDefault}">
                                            <a href="/setDefaultAddress?id=${address.addressId}" 
                                               class="btn btn-sm btn-success">
                                                <i class="fas fa-check me-1"></i>Set Default
                                            </a>
                                        </c:if>
                                        <a href="/deleteAddress?id=${address.addressId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirmDelete('address')">
                                            <i class="fas fa-trash me-1"></i>Delete
                                        </a>
                                    </div>
                                </div>
                                
                                <!-- Address Footer -->
                                <div class="card-footer text-muted small">
                                    <i class="fas fa-clock me-1"></i>
                                    Added on: <fmt:formatDate value="${address.createdAt}" pattern="dd MMM yyyy" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Confirmation dialog for delete actions
    function confirmDelete(entityName) {
        return confirm('Are you sure you want to delete this ' + entityName + '?');
    }
    
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    .card {
        transition: transform 0.2s, box-shadow 0.2s;
        border-radius: 10px;
    }
    
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .border-primary {
        border: 2px solid #007bff !important;
    }
    
    .btn-group .btn {
        border-radius: 0;
    }
    
    .btn-group .btn:first-child {
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
    }
    
    .btn-group .btn:last-child {
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
    }
    
    .address-details {
        min-height: 80px;
    }
    
    @media (max-width: 768px) {
        .btn-group {
            flex-direction: column;
        }
        
        .btn-group .btn {
            border-radius: 5px !important;
            margin-bottom: 5px;
        }
    }
</style>

<%@ include file="footer.jsp" %>