<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | EntityKart</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html, body {
            height: 100%;
            width: 100%;
        }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            padding: 20px;
        }
        
        .forgot-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            padding: 40px;
            width: 100%;
            max-width: 480px;
            transition: all 0.3s ease;
        }
        
        .forgot-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 35px 60px -15px rgba(0, 0, 0, 0.3);
        }
        
        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .icon-wrapper {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .icon-wrapper i {
            font-size: 40px;
            color: white;
        }
        
        .card-title {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }
        
        .card-subtitle {
            color: #718096;
            font-size: 16px;
            line-height: 1.5;
        }
        
        .alert-container {
            margin-bottom: 25px;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 16px;
            font-size: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .alert i {
            font-size: 18px;
        }
        
        .instruction-box {
            background: #f8fafc;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        
        .instruction-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .instruction-title i {
            color: #667eea;
        }
        
        .instruction-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .instruction-list li {
            color: #4a5568;
            margin-bottom: 10px;
            padding-left: 26px;
            position: relative;
            line-height: 1.5;
        }
        
        .instruction-list li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #667eea;
            font-weight: bold;
        }
        
        .instruction-list li:last-child {
            margin-bottom: 0;
        }
        
        .form-group {
            margin-bottom: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
        }
        
        .form-label i {
            color: #667eea;
            font-size: 18px;
        }
        
        .input-group {
            border-radius: 12px;
            overflow: hidden;
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        
        .input-group:focus-within {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.15);
            transform: translateY(-2px);
        }
        
        .form-control {
            border: none;
            padding: 16px;
            font-size: 16px;
            background: #f8fafc;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            background: white;
            box-shadow: none;
            outline: none;
        }
        
        .form-control::placeholder {
            color: #a0aec0;
        }
        
        .input-group-text {
            background: #f8fafc;
            border: none;
            color: #667eea;
            padding: 16px;
            transition: all 0.3s ease;
        }
        
        .input-group-text i {
            font-size: 18px;
        }
        
        .invalid-feedback {
            font-size: 14px;
            color: #e53e3e;
            margin-top: 5px;
            display: none;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 18px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
        }
        
        .btn-submit:active {
            transform: translateY(-1px);
        }
        
        .btn-submit i {
            font-size: 18px;
        }
        
        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none !important;
        }
        
        .back-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e2e8f0;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
        }
        
        .back-link a:hover {
            color: #764ba2;
            gap: 12px;
            text-decoration: underline;
        }
        
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .timer-display {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            color: #718096;
            display: none;
        }
        
        .timer-display i {
            color: #667eea;
            margin-right: 8px;
        }
        
        .countdown {
            font-family: monospace;
            font-weight: 600;
            color: #2d3748;
            background: #f8fafc;
            padding: 2px 8px;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .main-container {
                padding: 15px;
            }
            
            .forgot-card {
                padding: 30px;
                max-width: 100%;
            }
            
            .icon-wrapper {
                width: 80px;
                height: 80px;
            }
            
            .icon-wrapper i {
                font-size: 36px;
            }
            
            .card-title {
                font-size: 28px;
            }
            
            .card-subtitle {
                font-size: 15px;
            }
            
            .instruction-box {
                padding: 20px;
            }
        }
        
        @media (max-width: 576px) {
            .forgot-card {
                padding: 25px;
            }
            
            .icon-wrapper {
                width: 70px;
                height: 70px;
            }
            
            .icon-wrapper i {
                font-size: 32px;
            }
            
            .card-title {
                font-size: 24px;
            }
            
            .card-subtitle {
                font-size: 14px;
            }
            
            .instruction-list li {
                font-size: 14px;
            }
        }
        
        @media (max-height: 700px) {
            body {
                align-items: flex-start;
                padding-top: 30px;
                padding-bottom: 30px;
            }
        }
    </style>
</head>
<body>
    <!-- Main Container -->
    <div class="main-container">
        <!-- Forgot Password Card -->
        <div class="forgot-card">
            
            <!-- Header Section -->
            <div class="header-section">
                <div class="icon-wrapper">
                    <i class="bi bi-key"></i>
                </div>
                <h1 class="card-title">Reset Password</h1>
                <p class="card-subtitle">Enter your email to receive reset instructions</p>
            </div>
            
            <!-- Alert Messages -->
            <div class="alert-container">
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-check-circle-fill me-3"></i>
                            <div>${success}</div>
                            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-exclamation-triangle-fill me-3"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </div>
                </c:if>
            </div>
            
            <!-- Instructions Box -->
            <div class="instruction-box">
                <div class="instruction-title">
                    <i class="bi bi-info-circle"></i>
                    <span>Instructions:</span>
                </div>
                <ul class="instruction-list">
                    <li>Enter the email address associated with your account</li>
                    <li>Check your email for a password reset link</li>
                    <li>The reset link will expire in 15 minutes for security</li>
                    <li>If you don't receive an email, check your spam folder</li>
                </ul>
            </div>
            
            <!-- Forgot Password Form -->
            <form id="forgotPasswordForm" action="send-otp" method="post" novalidate>
                <!-- Email Field -->
                <div class="form-group">
                    <label class="form-label" for="email">
                        <i class="bi bi-envelope"></i> Email Address
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-at"></i>
                        </span>
                        <input type="email" 
                               name="email"
                               id="email" 
                               class="form-control" 
                               placeholder="you@example.com" 
                               required 
                               autocomplete="email"
                               autofocus>
                    </div>
                    <div class="invalid-feedback" id="emailError">Please enter a valid email address.</div>
                </div>
                
                <!-- Submit Button -->
                <button type="submit" class="btn-submit" id="submitButton">
                    <i class="bi bi-send"></i>
                    <span id="buttonText">Send Reset Link</span>
                    <span class="spinner" id="loadingSpinner" style="display: none;"></span>
                </button>
                
                <!-- Back to Login Link -->
                <div class="back-link">
                    <a href="login">
                        <i class="bi bi-arrow-left"></i> Back to Login
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus on email field
            setTimeout(function() {
                const emailInput = document.getElementById('email');
                emailInput.focus();
                emailInput.select();
            }, 100);
            
            // Get form elements
            const forgotPasswordForm = document.getElementById('forgotPasswordForm');
            const emailInput = document.getElementById('email');
            const submitButton = document.getElementById('submitButton');
            const buttonText = document.getElementById('buttonText');
            const loadingSpinner = document.getElementById('loadingSpinner');
            
            // Email validation function
            function validateEmail() {
                const email = emailInput.value.trim();
                const emailError = document.getElementById('emailError');
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                
                if (!email) {
                    emailError.textContent = 'Email address is required';
                    emailError.style.display = 'block';
                    emailInput.classList.add('is-invalid');
                    return false;
                }
                
                if (!emailRegex.test(email)) {
                    emailError.textContent = 'Please enter a valid email address';
                    emailError.style.display = 'block';
                    emailInput.classList.add('is-invalid');
                    return false;
                }
                
                emailError.style.display = 'none';
                emailInput.classList.remove('is-invalid');
                return true;
            }
            
            // Remove validation error when user starts typing
            emailInput.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    this.classList.remove('is-invalid');
                    document.getElementById('emailError').style.display = 'none';
                }
            });
            
            // Form submission handler
            forgotPasswordForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Validate email
                const isEmailValid = validateEmail();
                
                if (isEmailValid) {
                    // Show loading state
                    buttonText.textContent = 'Sending...';
                    loadingSpinner.style.display = 'inline-block';
                    submitButton.disabled = true;
                    
                    // Submit the form after a short delay (for UX)
                    setTimeout(function() {
                        forgotPasswordForm.submit();
                    }, 1500);
                }
            });
            
            // Show notification
            function showNotification(message, type) {
                // Create notification element
                const notification = document.createElement('div');
                notification.className = 'alert alert-' + (type === 'error' ? 'danger' : type) + 
                                         ' alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3';
                notification.style.zIndex = '9999';
                notification.style.minWidth = '300px';
                
                const iconClass = type === 'success' ? 'check-circle' : 
                                 type === 'error' ? 'exclamation-triangle' : 'info-circle';
                
                notification.innerHTML = `
                    <div class="d-flex align-items-center">
                        <i class="bi bi-${iconClass}-fill me-2"></i>
                        <span>${message}</span>
                        <button type="button" class="btn-close ms-auto" onclick="this.parentElement.parentElement.remove()"></button>
                    </div>
                `;
                
                document.body.appendChild(notification);
                
                // Auto-remove after 5 seconds
                setTimeout(function() {
                    if (notification.parentElement) {
                        notification.remove();
                    }
                }, 5000);
            }
            
            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl + Enter to submit form
                if (e.ctrlKey && e.key === 'Enter') {
                    submitButton.click();
                }
                
                // Escape to clear form
                if (e.key === 'Escape') {
                    if (confirm('Clear email field?')) {
                        emailInput.value = '';
                        emailInput.focus();
                    }
                }
            });
            
            // Auto-validate email on blur
            emailInput.addEventListener('blur', validateEmail);
            
            // Auto-validate email on input (with debounce)
            let emailValidationTimeout;
            emailInput.addEventListener('input', function() {
                clearTimeout(emailValidationTimeout);
                emailValidationTimeout = setTimeout(validateEmail, 500);
            });
        });
        
        // Email validation on form submit
        function validateForm() {
            const emailInput = document.getElementById('email');
            const email = emailInput.value.trim();
            const emailError = document.getElementById('emailError');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!email) {
                emailError.textContent = 'Email address is required';
                emailError.style.display = 'block';
                emailInput.classList.add('is-invalid');
                emailInput.focus();
                return false;
            }
            
            if (!emailRegex.test(email)) {
                emailError.textContent = 'Please enter a valid email address';
                emailError.style.display = 'block';
                emailInput.classList.add('is-invalid');
                emailInput.focus();
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>