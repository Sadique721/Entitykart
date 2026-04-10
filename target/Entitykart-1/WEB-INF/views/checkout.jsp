<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-credit-card me-2"></i>Checkout</h2>
                <c:if test="${empty directBuy}">
                    <a href="/cart" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Cart
                    </a>
                </c:if>
                <c:if test="${not empty directBuy}">
                    <a href="/product/${productId}" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Product
                    </a>
                </c:if>
            </div>
            
            <c:if test="${empty addresses}">
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    No address found! Please <a href="/address" class="alert-link">add an address</a> to continue.
                </div>
            </c:if>
            
            <form action="/order/place" method="post" id="checkoutForm">
                <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="quantity" value="${quantity}">
                
                <div class="row">
                    <!-- Left Column - Delivery & Payment -->
                    <div class="col-lg-8">
                        <!-- Delivery Address -->
                        <div class="card mb-3">
                            <div class="card-header bg-white">
                                <h5 class="mb-0"><i class="fas fa-map-marker-alt me-2 text-primary"></i>Delivery Address</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty addresses}">
                                    <div class="row">
                                        <c:forEach var="addr" items="${addresses}" varStatus="loop">
                                            <div class="col-md-6 mb-3">
                                                <div class="card address-card ${addr.isDefault ? 'border-primary' : ''}">
                                                    <div class="card-body">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" 
                                                                   name="addressId" id="address${addr.addressId}" 
                                                                   value="${addr.addressId}" 
                                                                   ${addr.isDefault ? 'checked' : ''} required>
                                                            <label class="form-check-label w-100" for="address${addr.addressId}">
                                                                <div class="d-flex justify-content-between">
                                                                    <strong>${addr.fullName}</strong>
                                                                    <c:if test="${addr.isDefault}">
                                                                        <span class="badge bg-primary">Default</span>
                                                                    </c:if>
                                                                </div>
                                                                <span class="badge bg-light text-dark mt-1">${addr.addressType}</span>
                                                                <p class="mt-2 mb-1">${addr.addressLine1}</p>
                                                                <p class="mb-1">${addr.city}, ${addr.state} - ${addr.pincode}</p>
                                                                <p class="mb-0"><i class="fas fa-phone me-1"></i>${addr.mobileNo}</p>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        
                                        <div class="col-12">
                                            <a href="/address" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-plus me-2"></i>Add New Address
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div class="card mb-3">
                            <div class="card-header bg-white">
                                <h5 class="mb-0"><i class="fas fa-credit-card me-2 text-primary"></i>Payment Method</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <!-- COD -->
                                    <div class="col-md-6 mb-3">
                                        <div class="card payment-card">
                                            <div class="card-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" 
                                                           name="paymentMode" id="cod" value="COD" checked>
                                                    <label class="form-check-label w-100" for="cod">
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-money-bill-wave fa-2x me-3 text-success"></i>
                                                            <div>
                                                                <strong>Cash on Delivery</strong>
                                                                <p class="mb-0 small text-muted">Pay when you receive</p>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Credit/Debit Card -->
                                    <div class="col-md-6 mb-3">
                                        <div class="card payment-card">
                                            <div class="card-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" 
                                                           name="paymentMode" id="card" value="CARD">
                                                    <label class="form-check-label w-100" for="card">
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-credit-card fa-2x me-3 text-primary"></i>
                                                            <div>
                                                                <strong>Credit/Debit Card</strong>
                                                                <p class="mb-0 small text-muted">Visa, Mastercard, RuPay</p>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <!-- Card details fields - initially hidden -->
                                                <div id="cardFields" style="display: none; margin-top: 15px;">
                                                    <div class="row g-2">
                                                        <div class="col-12">
                                                            <label class="form-label small">Card Number</label>
                                                            <input type="text" name="cardNumber" class="form-control form-control-sm"
                                                                   placeholder="1234 5678 9012 3456" maxlength="19" pattern="[0-9 ]{16,19}">
                                                        </div>
                                                        <div class="col-8">
                                                            <label class="form-label small">Card Holder Name</label>
                                                            <input type="text" name="cardHolderName" class="form-control form-control-sm"
                                                                   placeholder="Name on card">
                                                        </div>
                                                        <div class="col-4">
                                                            <label class="form-label small">CVV</label>
                                                            <input type="text" name="cvv" class="form-control form-control-sm"
                                                                   placeholder="123" maxlength="3" pattern="[0-9]{3}">
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small">Expiry Month</label>
                                                            <select name="expiryMonth" class="form-select form-select-sm">
                                                                <option value="">MM</option>
                                                                <option value="01">01</option>
                                                                <option value="02">02</option>
                                                                <option value="03">03</option>
                                                                <option value="04">04</option>
                                                                <option value="05">05</option>
                                                                <option value="06">06</option>
                                                                <option value="07">07</option>
                                                                <option value="08">08</option>
                                                                <option value="09">09</option>
                                                                <option value="10">10</option>
                                                                <option value="11">11</option>
                                                                <option value="12">12</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small">Expiry Year</label>
                                                            <select name="expiryYear" class="form-select form-select-sm">
                                                                <option value="">YYYY</option>
                                                                <option value="2024">2024</option>
                                                                <option value="2025">2025</option>
                                                                <option value="2026">2026</option>
                                                                <option value="2027">2027</option>
                                                                <option value="2028">2028</option>
                                                                <option value="2029">2029</option>
                                                                <option value="2030">2030</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- UPI -->
                                    <div class="col-md-6 mb-3">
                                        <div class="card payment-card">
                                            <div class="card-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" 
                                                           name="paymentMode" id="upi" value="UPI">
                                                    <label class="form-check-label w-100" for="upi">
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-mobile-alt fa-2x me-3 text-info"></i>
                                                            <div>
                                                                <strong>UPI</strong>
                                                                <p class="mb-0 small text-muted">Google Pay, PhonePe, Paytm</p>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <!-- UPI ID field (optional) - initially hidden -->
                                                <div id="upiFields" style="display: none; margin-top: 15px;">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <label class="form-label small">UPI ID</label>
                                                            <input type="text" name="upiId" class="form-control form-control-sm"
                                                                   placeholder="example@okhdfcbank">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Net Banking -->
                                    <div class="col-md-6 mb-3">
                                        <div class="card payment-card">
                                            <div class="card-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" 
                                                           name="paymentMode" id="netbanking" value="NET_BANKING">
                                                    <label class="form-check-label w-100" for="netbanking">
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-university fa-2x me-3 text-warning"></i>
                                                            <div>
                                                                <strong>Net Banking</strong>
                                                                <p class="mb-0 small text-muted">All major banks</p>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <!-- Net banking fields (optional) -->
                                                <div id="netbankingFields" style="display: none; margin-top: 15px;">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <label class="form-label small">Select Bank</label>
                                                            <select name="bankName" class="form-select form-select-sm">
                                                                <option value="">Select Bank</option>
                                                                <option value="SBI">State Bank of India</option>
                                                                <option value="HDFC">HDFC Bank</option>
                                                                <option value="ICICI">ICICI Bank</option>
                                                                <option value="Axis">Axis Bank</option>
                                                                <option value="PNB">Punjab National Bank</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Items -->
                        <div class="card mb-3">
                            <div class="card-header bg-white">
                                <h5 class="mb-0"><i class="fas fa-box me-2 text-primary"></i>Order Items (${itemCount})</h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Product</th>
                                                <th>Price</th>
                                                <th>Qty</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${not empty directBuy}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/50'}" 
                                                                 width="50" height="50" class="rounded me-3" style="object-fit: cover;">
                                                            <div>
                                                                <h6 class="mb-0">${product.productName}</h6>
                                                                <small class="text-muted">#${product.productId}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                                                    <td>${quantity}</td>
                                                    <td><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${product.price * quantity}" pattern="#,##0.00"/></td>
                                                </tr>
                                            </c:if>
                                            
                                            <c:if test="${empty directBuy}">
    											<c:forEach var="cartItem" items="${cartItems}">
        										<!-- cartItem is a CartEntity, so access its properties -->
        										<c:set var="prodName" value="${productMap[cartItem.productId]}" />  <!-- You'll need a map of product names -->
        										<c:set var="prodImage" value="${productImageMap[cartItem.productId]}" />
        										<c:set var="stockQty" value="${productStockMap[cartItem.productId]}" />
        										...
    											</c:forEach>
										</c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column - Order Summary -->
                    <div class="col-lg-4">
                        <div class="card sticky-top" style="top: 20px;">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Price Details</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <td>Subtotal (${itemCount} items)</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></td>
                                    </tr>
                                    <tr>
                                        <td>Shipping</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${shipping}" pattern="#,##0.00"/></td>
                                    </tr>
                                    <tr>
                                        <td>Tax (18% GST)</td>
                                        <td class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${tax}" pattern="#,##0.00"/></td>
                                    </tr>
                                    <tr class="border-top">
                                        <th>Total</th>
                                        <th class="text-end"><i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="${total}" pattern="#,##0.00"/></th>
                                    </tr>
                                </table>
                                
                                <hr>
                                
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label small" for="terms">
                                        I agree to the <a href="#" class="text-primary">Terms & Conditions</a> and 
                                        <a href="#" class="text-primary">Return Policy</a>
                                    </label>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg" id="placeOrderBtn" disabled>
                                        <i class="fas fa-lock me-2"></i>Place Order
                                    </button>
                                </div>
                                
                                <div class="mt-3 small text-muted text-center">
                                    <i class="fas fa-shield-alt me-1"></i> Your information is secure
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Enable place order button only when terms are checked and address selected
    document.getElementById('terms').addEventListener('change', function() {
        const addressSelected = document.querySelector('input[name="addressId"]:checked');
        document.getElementById('placeOrderBtn').disabled = !this.checked || !addressSelected;
    });
    
    // Also check address selection
    document.querySelectorAll('input[name="addressId"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const termsChecked = document.getElementById('terms').checked;
            document.getElementById('placeOrderBtn').disabled = !termsChecked;
        });
    });
    
    // Form validation
    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
        const addressSelected = document.querySelector('input[name="addressId"]:checked');
        if (!addressSelected) {
            e.preventDefault();
            alert('Please select a delivery address');
        }
    });
    
    // Payment card hover effect
    document.querySelectorAll('.payment-card').forEach(card => {
        card.addEventListener('click', function() {
            const radio = this.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;
                // Trigger change event to show/hide fields
                const event = new Event('change');
                radio.dispatchEvent(event);
            }
        });
    });
    
    // Toggle additional fields based on selected payment method
    const paymentRadios = document.querySelectorAll('input[name="paymentMode"]');
    const cardFields = document.getElementById('cardFields');
    const upiFields = document.getElementById('upiFields');
    const netbankingFields = document.getElementById('netbankingFields');
    
    function togglePaymentFields() {
        const selected = document.querySelector('input[name="paymentMode"]:checked');
        if (!selected) return;
        
        // Hide all fields first
        if (cardFields) cardFields.style.display = 'none';
        if (upiFields) upiFields.style.display = 'none';
        if (netbankingFields) netbankingFields.style.display = 'none';
        
        // Show relevant fields based on selected mode
        if (selected.value === 'CARD') {
            if (cardFields) cardFields.style.display = 'block';
        } else if (selected.value === 'UPI') {
            if (upiFields) upiFields.style.display = 'block';
        } else if (selected.value === 'NET_BANKING') {
            if (netbankingFields) netbankingFields.style.display = 'block';
        }
    }
    
    // Add event listeners to payment radios
    paymentRadios.forEach(radio => {
        radio.addEventListener('change', togglePaymentFields);
    });
    
    // Call once on page load to set initial state
    togglePaymentFields();
    
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    .address-card {
        cursor: pointer;
        transition: all 0.2s;
    }
    .address-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .address-card.border-primary {
        border-width: 2px;
    }
    .payment-card {
        cursor: pointer;
        transition: all 0.2s;
    }
    .payment-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        border-color: #007bff;
    }
    .sticky-top {
        z-index: 100;
    }
    @media (max-width: 768px) {
        .sticky-top {
            position: relative !important;
            top: 0 !important;
        }
    }
</style>

<%@ include file="footer.jsp" %>