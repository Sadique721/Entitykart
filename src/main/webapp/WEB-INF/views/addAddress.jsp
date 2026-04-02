<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-plus-circle me-2"></i>Add New Address</h4>
                    <a href="/listAddress" class="btn btn-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i> Back to Addresses
                    </a>
                </div>
                <div class="card-body">
                    
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
                    
                    <form action="/saveAddress" method="post" id="addressForm">
                        
                        <!-- Personal Information -->
                        <h5 class="mb-3" style="color: #007bff; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                            <i class="fas fa-user-circle me-2"></i>Contact Information
                        </h5>
                        
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                <input type="text" name="fullName" class="form-control" 
                                       value="${currentUser.name}" required
                                       placeholder="Enter recipient's full name">
                                <div class="invalid-feedback">Please enter full name.</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                                <input type="tel" name="mobileNo" class="form-control" 
                                       value="${currentUser.contactNum}" required
                                       placeholder="10-digit mobile number" pattern="[0-9]{10}"
                                       maxlength="10" title="Please enter a valid 10-digit number">
                                <div class="invalid-feedback">Please enter a valid 10-digit mobile number.</div>
                            </div>
                        </div>
                        
                        <!-- Address Details -->
                        <h5 class="mb-3" style="color: #28a745; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                            <i class="fas fa-map-marker-alt me-2"></i>Address Details
                        </h5>
                        
                        <div class="row mb-3">
                            <div class="col-12 mb-3">
                                <label class="form-label">Address Line 1 <span class="text-danger">*</span></label>
                                <textarea name="addressLine1" class="form-control" rows="2" 
                                          placeholder="House No., Building, Street, Area" required></textarea>
                                <div class="invalid-feedback">Please enter address details.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City <span class="text-danger">*</span></label>
                                <input type="text" name="city" class="form-control" 
                                       placeholder="Enter city" required>
                                <div class="invalid-feedback">Please enter city.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State <span class="text-danger">*</span></label>
                                <select name="state" class="form-select" required>
                                    <option value="">Select State</option>
                                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                                    <option value="Bihar">Bihar</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Gujarat">Gujarat</option>
                                    <option value="Karnataka">Karnataka</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                                    <option value="Punjab">Punjab</option>
                                    <option value="Rajasthan">Rajasthan</option>
                                    <option value="Tamil Nadu">Tamil Nadu</option>
                                    <option value="Telangana">Telangana</option>
                                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                                    <option value="West Bengal">West Bengal</option>
                                    <option value="Other">Other</option>
                                </select>
                                <div class="invalid-feedback">Please select state.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Pincode <span class="text-danger">*</span></label>
                                <input type="text" name="pincode" class="form-control" 
                                       placeholder="6-digit pincode" required pattern="[0-9]{6}"
                                       maxlength="6" title="Please enter a valid 6-digit pincode">
                                <div class="invalid-feedback">Please enter a valid 6-digit pincode.</div>
                            </div>
                        </div>
                        
                        <!-- Address Type & Default -->
                        <h5 class="mb-3" style="color: #ffc107; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                            <i class="fas fa-tag me-2"></i>Address Preferences
                        </h5>
                        
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Address Type <span class="text-danger">*</span></label>
                                <div class="mt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addressType" 
                                               id="home" value="HOME" checked>
                                        <label class="form-check-label" for="home">
                                            <i class="fas fa-home me-1"></i>Home
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addressType" 
                                               id="office" value="OFFICE">
                                        <label class="form-check-label" for="office">
                                            <i class="fas fa-briefcase me-1"></i>Office
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addressType" 
                                               id="other" value="OTHER">
                                        <label class="form-check-label" for="other">
                                            <i class="fas fa-map-pin me-1"></i>Other
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Default Address</label>
                                <div class="mt-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" 
                                               name="isDefault" id="isDefault" value="true">
                                        <label class="form-check-label" for="isDefault">
                                            <i class="fas fa-check-circle me-1"></i>
                                            Set as my default shipping address
                                        </label>
                                    </div>
                                    <small class="text-muted">If checked, this will become your primary address</small>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Form Buttons -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Save Address
                                </button>
                                <button type="button" class="btn btn-warning" onclick="resetForm()">
                                    <i class="fas fa-undo me-2"></i>Reset
                                </button>
                                <a href="/listAddress" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    document.getElementById('addressForm')?.addEventListener('submit', function(e) {
        const fullName = document.querySelector('input[name="fullName"]').value.trim();
        const mobileNo = document.querySelector('input[name="mobileNo"]').value.trim();
        const addressLine1 = document.querySelector('textarea[name="addressLine1"]').value.trim();
        const city = document.querySelector('input[name="city"]').value.trim();
        const state = document.querySelector('select[name="state"]').value;
        const pincode = document.querySelector('input[name="pincode"]').value.trim();
        
        if (!fullName) {
            e.preventDefault();
            alert('Please enter full name');
            return false;
        }
        
        if (!mobileNo || !/^\d{10}$/.test(mobileNo)) {
            e.preventDefault();
            alert('Please enter a valid 10-digit mobile number');
            return false;
        }
        
        if (!addressLine1) {
            e.preventDefault();
            alert('Please enter address');
            return false;
        }
        
        if (!city) {
            e.preventDefault();
            alert('Please enter city');
            return false;
        }
        
        if (!state) {
            e.preventDefault();
            alert('Please select state');
            return false;
        }
        
        if (!pincode || !/^\d{6}$/.test(pincode)) {
            e.preventDefault();
            alert('Please enter a valid 6-digit pincode');
            return false;
        }
    });
    
    // Mobile number formatting
    document.querySelector('input[name="mobileNo"]')?.addEventListener('input', function() {
        this.value = this.value.replace(/\D/g, '').slice(0, 10);
    });
    
    // Pincode formatting
    document.querySelector('input[name="pincode"]')?.addEventListener('input', function() {
        this.value = this.value.replace(/\D/g, '').slice(0, 6);
    });
    
    // Reset form function
    function resetForm() {
        if (confirm('Are you sure you want to reset all fields?')) {
            document.getElementById('addressForm').reset();
            document.getElementById('home').checked = true;
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