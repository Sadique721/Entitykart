<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-edit me-2"></i>Edit Address</h4>
                    <a href="/listAddress" class="btn btn-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i> Back to Addresses
                    </a>
                </div>
                <div class="card-body">
                    
                    <form action="/updateAddress" method="post" id="addressForm">
                        
                        <input type="hidden" name="addressId" value="${address.addressId}">
                        
                        <!-- Personal Information -->
                        <h5 class="mb-3" style="color: #007bff; border-bottom: 2px solid #dee2e6; padding-bottom: 10px;">
                            <i class="fas fa-user-circle me-2"></i>Contact Information
                        </h5>
                        
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                <input type="text" name="fullName" class="form-control" 
                                       value="${address.fullName}" required
                                       placeholder="Enter recipient's full name">
                                <div class="invalid-feedback">Please enter full name.</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                                <input type="tel" name="mobileNo" class="form-control" 
                                       value="${address.mobileNo}" required
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
                                          placeholder="House No., Building, Street, Area" required>${address.addressLine1}</textarea>
                                <div class="invalid-feedback">Please enter address details.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City <span class="text-danger">*</span></label>
                                <input type="text" name="city" class="form-control" 
                                       value="${address.city}" placeholder="Enter city" required>
                                <div class="invalid-feedback">Please enter city.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State <span class="text-danger">*</span></label>
                                <select name="state" class="form-select" required>
                                    <option value="">Select State</option>
                                    <option value="Andhra Pradesh" ${address.state == 'Andhra Pradesh' ? 'selected' : ''}>Andhra Pradesh</option>
                                    <option value="Bihar" ${address.state == 'Bihar' ? 'selected' : ''}>Bihar</option>
                                    <option value="Delhi" ${address.state == 'Delhi' ? 'selected' : ''}>Delhi</option>
                                    <option value="Gujarat" ${address.state == 'Gujarat' ? 'selected' : ''}>Gujarat</option>
                                    <option value="Karnataka" ${address.state == 'Karnataka' ? 'selected' : ''}>Karnataka</option>
                                    <option value="Maharashtra" ${address.state == 'Maharashtra' ? 'selected' : ''}>Maharashtra</option>
                                    <option value="Madhya Pradesh" ${address.state == 'Madhya Pradesh' ? 'selected' : ''}>Madhya Pradesh</option>
                                    <option value="Punjab" ${address.state == 'Punjab' ? 'selected' : ''}>Punjab</option>
                                    <option value="Rajasthan" ${address.state == 'Rajasthan' ? 'selected' : ''}>Rajasthan</option>
                                    <option value="Tamil Nadu" ${address.state == 'Tamil Nadu' ? 'selected' : ''}>Tamil Nadu</option>
                                    <option value="Telangana" ${address.state == 'Telangana' ? 'selected' : ''}>Telangana</option>
                                    <option value="Uttar Pradesh" ${address.state == 'Uttar Pradesh' ? 'selected' : ''}>Uttar Pradesh</option>
                                    <option value="West Bengal" ${address.state == 'West Bengal' ? 'selected' : ''}>West Bengal</option>
                                    <option value="Other" ${address.state == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                                <div class="invalid-feedback">Please select state.</div>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Pincode <span class="text-danger">*</span></label>
                                <input type="text" name="pincode" class="form-control" 
                                       value="${address.pincode}" placeholder="6-digit pincode" 
                                       required pattern="[0-9]{6}" maxlength="6"
                                       title="Please enter a valid 6-digit pincode">
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
                                               id="home" value="HOME" ${address.addressType == 'HOME' ? 'checked' : ''}>
                                        <label class="form-check-label" for="home">
                                            <i class="fas fa-home me-1"></i>Home
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addressType" 
                                               id="office" value="OFFICE" ${address.addressType == 'OFFICE' ? 'checked' : ''}>
                                        <label class="form-check-label" for="office">
                                            <i class="fas fa-briefcase me-1"></i>Office
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addressType" 
                                               id="other" value="OTHER" ${address.addressType == 'OTHER' ? 'checked' : ''}>
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
                                               name="isDefault" id="isDefault" value="true" ${address.isDefault ? 'checked' : ''}>
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
                                    <i class="fas fa-save me-2"></i>Update Address
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
</script>

<%@ include file="footer.jsp" %>