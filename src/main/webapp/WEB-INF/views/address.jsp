<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Address | EntityKart</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%);
            --warning-gradient: linear-gradient(135deg, #f6ad55 0%, #ed8936 100%);
            --shadow-lg: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }
        
        .address-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            margin: 30px auto;
            max-width: 900px;
            transition: var(--transition);
        }
        
        .address-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }
        
        .card-header {
            background: var(--primary-gradient);
            padding: 30px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1%, transparent 1%);
            background-size: 20px 20px;
            opacity: 0.3;
        }
        
        .card-header h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }
        
        .card-header p {
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }
        
        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            transition: var(--transition);
            font-size: 16px;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-label {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .field-icon {
            color: #667eea;
            font-size: 18px;
        }
        
        .input-group {
            border-radius: 10px;
            overflow: hidden;
            border: 2px solid #e2e8f0;
            transition: var(--transition);
        }
        
        .input-group:focus-within {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .input-group .form-control {
            border: none;
        }
        
        .input-group-text {
            background: #f8fafc;
            border: none;
            color: #667eea;
        }
        
        .btn-save {
            background: var(--success-gradient);
            border: none;
            border-radius: 12px;
            padding: 16px 32px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(86, 171, 47, 0.3);
        }
        
        .btn-update {
            background: var(--warning-gradient);
            border: none;
            border-radius: 12px;
            padding: 16px 32px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(246, 173, 85, 0.3);
        }
        
        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-text {
            font-size: 12px;
            color: #718096;
            margin-top: 5px;
        }
        
        .address-type-selector {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 8px;
        }
        
        .address-type-btn {
            padding: 12px 24px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            background: white;
            color: #4a5568;
            font-weight: 500;
            transition: var(--transition);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .address-type-btn:hover {
            border-color: #667eea;
            color: #667eea;
        }
        
        .address-type-btn.active {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }
        
        .default-address-check {
            padding: 20px;
            background: #f8fafc;
            border-radius: 10px;
            border-left: 4px solid #667eea;
            margin-top: 20px;
        }
        
        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .form-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e2e8f0;
        }
        
        .btn-reset {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 500;
            color: #4a5568;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-reset:hover {
            background: #e2e8f0;
        }
        
        .back-link {
            text-align: center;
            padding: 20px;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
        
        .invalid-feedback {
            font-size: 14px;
            color: #e53e3e;
        }
        
        .pincode-status {
            font-size: 14px;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .pincode-valid {
            color: #38a169;
        }
        
        .pincode-invalid {
            color: #e53e3e;
        }
        
        @media (max-width: 768px) {
            .address-card {
                margin: 16px;
            }
            
            .card-header {
                padding: 20px;
            }
            
            .card-header h1 {
                font-size: 24px;
            }
            
            .form-footer {
                flex-direction: column;
                gap: 15px;
            }
            
            .btn-save, .btn-update, .btn-reset {
                width: 100%;
                justify-content: center;
            }
            
            .address-type-selector {
                flex-direction: column;
            }
            
            .address-type-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4 mt-lg-5">
        <div class="row justify-content-center">
            <div class="col-xl-8 col-lg-10 col-md-12">
                <div class="address-card">
                    <!-- Header -->
                    <div class="card-header">
                        <h1>Add New Address</h1>
                        <p>Save your delivery address for faster checkout</p>
                    </div>

                    <!-- Address Form -->
                    <div class="card-body p-4 p-lg-5">
                        <form action="saveAddress" method="post" id="addressForm" novalidate>
                            
                            <!-- Recipient Information Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-person-circle"></i> Recipient Information
                                </h3>
                                
                                <div class="row g-3">
                                    <!-- Full Name -->
                                    <div class="col-md-12">
                                        <label class="form-label">
                                            <i class="bi bi-person field-icon"></i> Full Name
                                        </label>
                                        <input type="text" name="fullName" class="form-control" 
                                               placeholder="Enter recipient's full name" required>
                                        <div class="invalid-feedback">Please enter the recipient's full name.</div>
                                    </div>

                                    <!-- Mobile Number -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-phone field-icon"></i> Mobile Number
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-telephone"></i>
                                            </span>
                                            <input type="tel" name="mobileNo" class="form-control" 
                                                   pattern="[0-9]{10}" placeholder="9876543210" required>
                                        </div>
                                        <div class="form-text">Enter 10-digit mobile number without country code</div>
                                        <div class="invalid-feedback">Please enter a valid 10-digit mobile number.</div>
                                    </div>

                                    <!-- Pincode -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-mailbox field-icon"></i> Pincode
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-pin-map"></i>
                                            </span>
                                            <input type="text" name="pincode" id="pincode" class="form-control" 
                                                   pattern="[0-9]{6}" placeholder="560001" required>
                                            <button class="btn btn-outline-secondary" type="button" 
                                                    id="checkPincode">
                                                <i class="bi bi-check-lg"></i> Check
                                            </button>
                                        </div>
                                        <div class="pincode-status" id="pincodeStatus">
                                            <i class="bi bi-info-circle"></i>
                                            <span>Enter pincode to check service availability</span>
                                        </div>
                                        <div class="invalid-feedback">Please enter a valid 6-digit pincode.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Address Details Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-house-door"></i> Address Details
                                </h3>

                                <div class="row g-3">
                                    <!-- Address Line 1 -->
                                    <div class="col-md-12">
                                        <label class="form-label">
                                            <i class="bi bi-house field-icon"></i> Address Line 1
                                        </label>
                                        <textarea name="addressLine1" class="form-control" 
                                                  placeholder="House no, Building, Street, Area" 
                                                  rows="3" required></textarea>
                                        <div class="invalid-feedback">Please enter your address details.</div>
                                    </div>

                                    <!-- City -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-building field-icon"></i> City
                                        </label>
                                        <input type="text" name="city" class="form-control" 
                                               placeholder="Enter city" required>
                                        <div class="invalid-feedback">Please enter your city.</div>
                                    </div>

                                    <!-- State -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-geo field-icon"></i> State
                                        </label>
                                        <select name="state" class="form-select" required>
                                            <option value="">Select State</option>
                                            <option value="Delhi">Delhi</option>
                                            <option value="Maharashtra">Maharashtra</option>
                                            <option value="Karnataka">Karnataka</option>
                                            <option value="Tamil Nadu">Tamil Nadu</option>
                                            <option value="Uttar Pradesh">Uttar Pradesh</option>
                                            <option value="Gujarat">Gujarat</option>
                                            <option value="Rajasthan">Rajasthan</option>
                                            <option value="West Bengal">West Bengal</option>
                                            <option value="Other">Other</option>
                                        </select>
                                        <div class="invalid-feedback">Please select your state.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Address Type Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-tag"></i> Address Type
                                </h3>

                                <div class="address-type-selector">
                                    <input type="hidden" name="addressType" id="addressType" value="HOME" required>
                                    
                                    <div class="address-type-btn" data-type="HOME" onclick="selectAddressType('HOME')">
                                        <i class="bi bi-house"></i>
                                        <span>Home</span>
                                    </div>
                                    
                                    <div class="address-type-btn" data-type="WORK" onclick="selectAddressType('WORK')">
                                        <i class="bi bi-briefcase"></i>
                                        <span>Work</span>
                                    </div>
                                    
                                    <div class="address-type-btn" data-type="OTHER" onclick="selectAddressType('OTHER')">
                                        <i class="bi bi-geo-alt"></i>
                                        <span>Other</span>
                                    </div>
                                </div>
                                <div class="invalid-feedback">Please select an address type.</div>
                            </div>

                            <!-- Default Address Section -->
                            <div class="default-address-check">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" 
                                           name="isDefault" id="isDefault" value="true">
                                    <label class="form-check-label" for="isDefault">
                                        <strong>Set as default address</strong>
                                        <div class="form-text">
                                            This address will be used as your primary shipping address
                                        </div>
                                    </label>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="form-footer">
                                <button type="button" class="btn-reset" onclick="resetForm()">
                                    <i class="bi bi-arrow-clockwise"></i> Reset Form
                                </button>
                                <button type="submit" class="btn-save" id="submitBtn">
                                    <i class="bi bi-save"></i> Save Address
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Back Link -->
                    <div class="back-link">
                        <p class="mb-0">
                            <a href="addresses">
                                <i class="bi bi-arrow-left"></i> Back to Address List
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Address Form JavaScript -->
    <script>
        // Initialize when document is ready
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('addressForm');
            const pincodeInput = document.getElementById('pincode');
            const pincodeStatus = document.getElementById('pincodeStatus');
            const checkPincodeBtn = document.getElementById('checkPincode');
            
            // Set Home as default address type
            selectAddressType('HOME');
            
            // Pincode validation
            checkPincodeBtn.addEventListener('click', function() {
                const pincode = pincodeInput.value.trim();
                
                if (!/^\d{6}$/.test(pincode)) {
                    pincodeStatus.innerHTML = `<i class="bi bi-x-circle pincode-invalid"></i>
                                              <span class="pincode-invalid">Invalid pincode format</span>`;
                    pincodeInput.classList.add('is-invalid');
                    return;
                }
                
                // Simulate pincode check with loading state
                pincodeStatus.innerHTML = `<span class="spinner-border spinner-border-sm me-2"></span> Checking pincode...`;
                
                // Mock API call
                setTimeout(() => {
                    // This is a mock response - in real app, you'd make an API call
                    const isValid = Math.random() > 0.1; // 90% success rate for demo
                    
                    if (isValid) {
                        pincodeStatus.innerHTML = `<i class="bi bi-check-circle pincode-valid"></i>
                                                  <span class="pincode-valid">Service available in this area</span>`;
                        pincodeInput.classList.remove('is-invalid');
                        pincodeInput.classList.add('is-valid');
                    } else {
                        pincodeStatus.innerHTML = `<i class="bi bi-x-circle pincode-invalid"></i>
                                                  <span class="pincode-invalid">Service not available in this area</span>`;
                        pincodeInput.classList.add('is-invalid');
                    }
                }, 1000);
            });
            
            // Auto-validate pincode on input change
            pincodeInput.addEventListener('input', function() {
                if (this.value.length === 6 && /^\d+$/.test(this.value)) {
                    pincodeStatus.innerHTML = `<i class="bi bi-info-circle"></i>
                                              <span>Press check button to verify service availability</span>`;
                    this.classList.remove('is-invalid');
                }
            });
            
            // Form Submission
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Validate form
                if (!form.checkValidity()) {
                    e.stopPropagation();
                    form.classList.add('was-validated');
                    
                    // Show all invalid fields
                    const invalidFields = form.querySelectorAll(':invalid');
                    invalidFields.forEach(field => {
                        field.classList.add('is-invalid');
                    });
                    return false;
                }
                
                // Validate mobile number format
                const mobileNo = form.querySelector('input[name="mobileNo"]');
                if (!/^\d{10}$/.test(mobileNo.value)) {
                    mobileNo.classList.add('is-invalid');
                    mobileNo.focus();
                    return false;
                }
                
                // Validate pincode format
                if (!/^\d{6}$/.test(pincodeInput.value)) {
                    pincodeInput.classList.add('is-invalid');
                    pincodeInput.focus();
                    return false;
                }
                
                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Saving Address...';
                submitBtn.disabled = true;
                
                // Submit form after delay
                setTimeout(() => {
                    form.submit();
                }, 1000);
            });
            
            // Auto-validate on blur
            form.querySelectorAll('[required]').forEach(input => {
                input.addEventListener('blur', function() {
                    if (!this.checkValidity()) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
            });
            
            // Mobile number formatting
            const mobileInput = form.querySelector('input[name="mobileNo"]');
            mobileInput.addEventListener('input', function() {
                this.value = this.value.replace(/\D/g, '').slice(0, 10);
            });
            
            // Pincode formatting
            pincodeInput.addEventListener('input', function() {
                this.value = this.value.replace(/\D/g, '').slice(0, 6);
            });
        });
        
        // Select address type
        function selectAddressType(type) {
            // Update hidden input
            document.getElementById('addressType').value = type;
            
            // Update button styles
            document.querySelectorAll('.address-type-btn').forEach(btn => {
                btn.classList.remove('active');
                if (btn.getAttribute('data-type') === type) {
                    btn.classList.add('active');
                }
            });
        }
        
        // Reset form
        function resetForm() {
            if (confirm('Are you sure you want to reset all fields?')) {
                document.getElementById('addressForm').reset();
                selectAddressType('HOME');
                
                // Clear all validation states
                const form = document.getElementById('addressForm');
                form.classList.remove('was-validated');
                form.querySelectorAll('.is-invalid, .is-valid').forEach(el => {
                    el.classList.remove('is-invalid', 'is-valid');
                });
                
                // Reset pincode status
                document.getElementById('pincodeStatus').innerHTML = 
                    `<i class="bi bi-info-circle"></i>
                     <span>Enter pincode to check service availability</span>`;
            }
        }
        
        // Show toast notification
        function showToast(message, type = 'info') {
            // Create toast element
            const toast = document.createElement('div');
            toast.className = `position-fixed bottom-0 end-0 p-3`;
            toast.innerHTML = `
                <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-${type} text-white">
                        <strong class="me-auto">Notification</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                    </div>
                    <div class="toast-body">
                        ${message}
                    </div>
                </div>
            `;
            
            document.body.appendChild(toast);
            
            // Auto-remove after 3 seconds
            setTimeout(() => {
                if (toast.parentElement) {
                    toast.remove();
                }
            }, 3000);
        }
        
        // Simulate loading saved data for edit mode
        function loadAddressForEdit(addressData) {
            if (!addressData) return;
            
            // Fill form fields
            document.querySelector('input[name="fullName"]').value = addressData.fullName || '';
            document.querySelector('input[name="mobileNo"]').value = addressData.mobileNo || '';
            document.querySelector('textarea[name="addressLine1"]').value = addressData.addressLine1 || '';
            document.querySelector('input[name="city"]').value = addressData.city || '';
            document.querySelector('select[name="state"]').value = addressData.state || '';
            document.querySelector('input[name="pincode"]').value = addressData.pincode || '';
            
            // Set address type
            if (addressData.addressType) {
                selectAddressType(addressData.addressType);
            }
            
            // Set default address
            if (addressData.isDefault) {
                document.getElementById('isDefault').checked = true;
            }
            
            // Change button text
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.className = 'btn-update';
            submitBtn.innerHTML = '<i class="bi bi-pencil-square"></i> Update Address';
            
            // Change header
            document.querySelector('.card-header h1').textContent = 'Edit Address';
            document.querySelector('.card-header p').textContent = 'Update your delivery address details';
        }
        
        // Check if we're in edit mode (you can call this with actual data)
        // Example: loadAddressForEdit({fullName: "John Doe", mobileNo: "9876543210", ...});
    </script>
</body>
</html>