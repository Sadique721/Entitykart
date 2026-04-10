<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.grownited.entity.UserEntity, com.grownited.entity.AddressEntity" %>

<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<!-- Page Content -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <!-- Error Alert if userEntity is null -->
            <c:if test="${empty userEntity}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Error:</strong> User not found. The user may have been deleted or you don't have permission to edit this user.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Success Message from Session -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <!-- Error Message from Session -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <c:if test="${not empty userEntity}">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4><i class="fas fa-user-edit me-2"></i>Edit User Profile</h4>
                        <div>
                            <a href="${pageContext.request.contextPath}/viewUser?userId=${userEntity.userId}" class="btn btn-info btn-sm me-2">
                                <i class="fas fa-eye me-1"></i> View
                            </a>
                            <a href="${pageContext.request.contextPath}/index" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left me-1"></i> Back to List
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Profile Image Section -->
                            <div class="col-md-3 text-center mb-4">
                                <div class="profile-image-container p-3 border rounded bg-light">
                                    <img src="${userEntity.profilePicURL != null ? userEntity.profilePicURL : 'https://via.placeholder.com/200'}" 
                                         class="img-fluid rounded-circle mb-3" alt="Profile" 
                                         style="width: 150px; height: 150px; object-fit: cover; border: 4px solid #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1);"
                                         id="profilePreview">
                                    <h5>${userEntity.name}</h5>
                                    <p class="text-muted mb-2">User ID: #${userEntity.userId}</p>
                                    <span class="badge ${userEntity.role == 'ADMIN' ? 'bg-danger' : userEntity.role == 'PARTICIPANT' ? 'bg-info' : 'bg-secondary'}">
                                        ${userEntity.role}
                                    </span>
                                    <span class="badge ${userEntity.active ? 'bg-success' : 'bg-danger'} ms-2">
                                        ${userEntity.active ? 'Active' : 'Inactive'}
                                    </span>
                                </div>
                            </div>

                            <!-- Edit Form Section -->
                            <div class="col-md-9">
                                <form action="${pageContext.request.contextPath}/updateUser" method="post" enctype="multipart/form-data" id="editUserForm">
                                    <input type="hidden" name="userId" value="${userEntity.userId}">
                                    <input type="hidden" name="addressId" value="${address.addressId}">

                                    <!-- Personal Information -->
                                    <h5 class="mb-3" style="color: #007bff; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                                        <i class="fas fa-user-circle me-2"></i>Personal Information
                                    </h5>
                                    <div class="row mb-3">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                            <input type="text" name="name" class="form-control form-control-sm" value="${userEntity.name}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email Address <span class="text-danger">*</span></label>
                                            <input type="email" name="email" class="form-control form-control-sm" value="${userEntity.email}" required>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Contact Number</label>
                                            <input type="text" name="contactNum" class="form-control form-control-sm" value="${userEntity.contactNum}" pattern="[0-9]{10}" title="Please enter a valid 10-digit number">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Gender</label>
                                            <select name="gender" class="form-select form-select-sm">
                                                <option value="Male" ${userEntity.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${userEntity.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${userEntity.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Role</label>
                                            <select name="role" class="form-select form-select-sm">
                                                <option value="PARTICIPANT" ${userEntity.role == 'PARTICIPANT' ? 'selected' : ''}>Participant</option>
                                                <option value="ADMIN" ${userEntity.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                            </select>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label class="form-label">Profile Picture</label>
                                            <input type="file" class="form-control form-control-sm" name="profilePic" accept="image/*" id="profilePic">
                                            <small class="text-muted">Leave empty to keep current profile picture. Max size: 5MB. Allowed: JPG, PNG, GIF</small>
                                        </div>
                                    </div>

                                    <!-- Address Details -->
                                    <h5 class="mb-3" style="color: #28a745; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                                        <i class="fas fa-map-marker-alt me-2"></i>Address Details
                                    </h5>
                                    <div class="row mb-3">
                                        <div class="col-12 mb-3">
                                            <label class="form-label">Address Line 1</label>
                                            <input type="text" name="addressLine1" class="form-control form-control-sm" value="${address.addressLine1}" placeholder="House no, Street, Area">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">City</label>
                                            <input type="text" name="city" class="form-control form-control-sm" value="${address.city}">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">State</label>
                                            <input type="text" name="state" class="form-control form-control-sm" value="${address.state}">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Pincode</label>
                                            <input type="text" name="pincode" class="form-control form-control-sm" value="${address.pincode}" pattern="[0-9]{6}" title="Please enter a valid 6-digit pincode">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Address Type</label>
                                            <div class="mt-2">
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="addressType" id="home" value="Home" ${address.addressType == 'Home' ? 'checked' : ''}>
                                                    <label class="form-check-label" for="home">Home</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="addressType" id="office" value="Office" ${address.addressType == 'Office' ? 'checked' : ''}>
                                                    <label class="form-check-label" for="office">Office</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="addressType" id="other" value="Other" ${address.addressType == 'Other' ? 'checked' : ''}>
                                                    <label class="form-check-label" for="other">Other</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Set as Default</label>
                                            <div class="mt-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="isDefault" id="isDefault" value="true" ${address.isDefault ? 'checked' : ''}>
                                                    <label class="form-check-label" for="isDefault">
                                                        Make this my default address
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Account Status -->
                                    <h5 class="mb-3" style="color: #ffc107; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                                        <i class="fas fa-shield-alt me-2"></i>Account Status
                                    </h5>
                                    <div class="row mb-3">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Account Status</label>
                                            <select name="active" class="form-select form-select-sm">
                                                <option value="true" ${userEntity.active ? 'selected' : ''}>Active</option>
                                                <option value="false" ${!userEntity.active ? 'selected' : ''}>Inactive</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Form Buttons -->
                                    <div class="row mt-4">
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary btn-sm">
                                                <i class="fas fa-save me-2"></i>Update User
                                            </button>
                                            <a href="${pageContext.request.contextPath}/listUser" class="btn btn-secondary btn-sm">
                                                <i class="fas fa-times me-2"></i>Cancel
                                            </a>
                                            <button type="button" class="btn btn-warning btn-sm" onclick="resetForm()">
                                                <i class="fas fa-undo me-2"></i>Reset
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Additional Information Card -->
                <div class="card mt-3">
                    <div class="card-header py-2">
                        <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Account Timeline</h5>
                    </div>
                    <div class="card-body py-2">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Created At:</strong> ${userEntity.createdAt != null ? userEntity.createdAt : 'Not available'}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Last Updated:</strong> ${userEntity.updatedAt != null ? userEntity.updatedAt : 'Not updated yet'}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Image preview functionality
    document.getElementById('profilePic')?.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                alert('File size exceeds 5MB. Please choose a smaller image.');
                this.value = '';
                return;
            }
            
            // Validate file type
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Invalid file type. Please select JPG, PNG, or GIF.');
                this.value = '';
                return;
            }
            
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('profilePreview').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });

    // Form validation
    document.getElementById('editUserForm')?.addEventListener('submit', function(e) {
        const name = document.querySelector('input[name="name"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const contactNum = document.querySelector('input[name="contactNum"]').value.trim();
        const pincode = document.querySelector('input[name="pincode"]').value.trim();
        
        if (!name) {
            e.preventDefault();
            alert('Please enter full name');
            return false;
        }
        
        if (!email) {
            e.preventDefault();
            alert('Please enter email address');
            return false;
        }
        
        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            alert('Please enter a valid email address');
            return false;
        }
        
        // Contact number validation (if provided)
        if (contactNum && !/^\d{10}$/.test(contactNum)) {
            e.preventDefault();
            alert('Please enter a valid 10-digit contact number');
            return false;
        }
        
        // Pincode validation (if provided)
        if (pincode && !/^\d{6}$/.test(pincode)) {
            e.preventDefault();
            alert('Please enter a valid 6-digit pincode');
            return false;
        }
    });

    // Reset form function
    function resetForm() {
        if (confirm('Are you sure you want to reset all changes?')) {
            document.getElementById('editUserForm').reset();
            // Reset profile image to original
            document.getElementById('profilePreview').src = '${userEntity.profilePicURL != null ? userEntity.profilePicURL : 'https://via.placeholder.com/200'}';
        }
    }

    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<%@ include file="footer.jsp" %>