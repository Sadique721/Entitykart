<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | EntityKart</title>
    
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
        
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            padding: 40px;
            width: 100%;
            max-width: 440px;
            transition: all 0.3s ease;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 35px 60px -15px rgba(0, 0, 0, 0.3);
        }
        
        .brand-section {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .logo-container {
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
        
        .logo-container i {
            font-size: 40px;
            color: white;
        }
        
        .brand-title {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }
        
        .brand-subtitle {
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
        
        .form-group {
            margin-bottom: 24px;
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
            cursor: pointer;
            color: #667eea;
            padding: 16px;
            transition: all 0.3s ease;
        }
        
        .input-group-text:hover {
            background: #e2e8f0;
        }
        
        .input-group-text i {
            font-size: 18px;
        }
        
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-check-input {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        
        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .form-check-label {
            color: #4a5568;
            font-weight: 500;
            cursor: pointer;
            user-select: none;
        }
        
        .forgot-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .forgot-link:hover {
            color: #764ba2;
            text-decoration: underline;
            gap: 8px;
        }
        
        .btn-login {
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
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
        }
        
        .btn-login:active {
            transform: translateY(-1px);
        }
        
        .btn-login i {
            font-size: 18px;
        }
        
        .register-section {
            text-align: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e2e8f0;
        }
        
        .register-text {
            color: #718096;
            font-size: 15px;
            margin-bottom: 0;
        }
        
        .register-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 700;
            margin-left: 8px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .register-link:hover {
            color: #764ba2;
            gap: 8px;
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .main-container {
                padding: 15px;
            }
            
            .login-card {
                padding: 30px;
                max-width: 100%;
            }
            
            .logo-container {
                width: 80px;
                height: 80px;
            }
            
            .logo-container i {
                font-size: 36px;
            }
            
            .brand-title {
                font-size: 28px;
            }
            
            .brand-subtitle {
                font-size: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .login-card {
                padding: 25px;
            }
            
            .form-options {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .logo-container {
                width: 70px;
                height: 70px;
            }
            
            .logo-container i {
                font-size: 32px;
            }
            
            .brand-title {
                font-size: 24px;
            }
        }
        
        @media (max-height: 700px) {
            body {
                align-items: flex-start;
                padding-top: 30px;
                padding-bottom: 30px;
            }
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
    </style>
</head>
<body>
    <!-- Main Container -->
    <div class="main-container">
        <!-- Login Card -->
        <div class="login-card">
            
            <!-- Brand/Logo Section -->
            <div class="brand-section">
                <div class="logo-container">
                    <i class="bi bi-shop"></i>
                </div>
                <h1 class="brand-title">EntityKart</h1>
                <p class="brand-subtitle">Welcome back! Please sign in to continue</p>
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
            
            <!-- Login Form -->
            <form id="loginForm" action="authenticate" method="post" novalidate>
                <!-- Email Field -->
                <div class="form-group">
                    <label class="form-label" for="email">
                        <i class="bi bi-envelope"></i> Email Address
                    </label>
                    <div class="input-group">
                        <input type="email" 
                               name="email" 
                               id="email" 
                               class="form-control" 
                               placeholder="you@example.com" 
                               required 
                               autocomplete="email"
                               autofocus>
                        <span class="input-group-text">
                            <i class="bi bi-at"></i>
                        </span>
                    </div>
                    <div class="invalid-feedback" id="emailError">Please enter a valid email address.</div>
                </div>
                
                <!-- Password Field -->
                <div class="form-group">
                    <label class="form-label" for="password">
                        <i class="bi bi-lock"></i> Password
                    </label>
                    <div class="input-group">
                        <input type="password" 
                               name="password" 
                               id="password" 
                               class="form-control" 
                               placeholder="Enter your password" 
                               required 
                               autocomplete="current-password">
                        <span class="input-group-text" onclick="togglePassword('password')" title="Show/Hide Password">
                            <i class="bi bi-eye-slash" id="passwordIcon"></i>
                        </span>
                    </div>
                    <div class="invalid-feedback" id="passwordError">Please enter your password.</div>
                </div>
                
                <!-- Remember Me & Forgot Password -->
                <div class="form-options">
                    <div class="remember-me">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                        <label class="form-check-label" for="rememberMe">
                            Remember me
                        </label>
                    </div>
                    <a href="fp" class="forgot-link">
                        <i class="bi bi-question-circle"></i> Forgot password?
                    </a>
                </div>
                
                <!-- Submit Button -->
                <button type="submit" class="btn-login" id="loginButton">
                    <i class="bi bi-box-arrow-in-right"></i>
                    <span id="buttonText">Sign In</span>
                    <span class="spinner" id="loadingSpinner" style="display: none;"></span>
                </button>
                
                <!-- Registration Link -->
                <div class="register-section">
                    <p class="register-text">
                        Don't have an account?
                        <a href="signup" class="register-link">
                            <i class="bi bi-person-plus"></i> Create account
                        </a>
                    </p>
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
            // Auto-focus on email field with delay
            setTimeout(function() {
                document.getElementById('email').focus();
            }, 100);
            
            // Get form elements
            const loginForm = document.getElementById('loginForm');
            const emailInput = document.getElementById('email');
            const passwordInput = document.getElementById('password');
            const loginButton = document.getElementById('loginButton');
            const buttonText = document.getElementById('buttonText');
            const loadingSpinner = document.getElementById('loadingSpinner');
            
            // Toggle password visibility
            window.togglePassword = function(fieldId) {
                const field = document.getElementById(fieldId);
                const icon = document.getElementById('passwordIcon');
                
                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                } else {
                    field.type = 'password';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
                
                // Keep focus on the password field
                field.focus();
            };
            
            // Real-time email validation
            emailInput.addEventListener('blur', function() {
                validateEmail();
            });
            
            // Real-time password validation
            passwordInput.addEventListener('blur', function() {
                validatePassword();
            });
            
            // Form submission handler
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Validate form
                const isEmailValid = validateEmail();
                const isPasswordValid = validatePassword();
                
                if (isEmailValid && isPasswordValid) {
                    // Show loading state
                    buttonText.textContent = 'Signing In...';
                    loadingSpinner.style.display = 'inline-block';
                    loginButton.disabled = true;
                    
                    // Submit the form after a short delay (for UX)
                    setTimeout(function() {
                        loginForm.submit();
                    }, 1500);
                } else {
                    // Highlight invalid fields
                    if (!isEmailValid) {
                        emailInput.classList.add('is-invalid');
                        document.getElementById('emailError').style.display = 'block';
                    }
                    if (!isPasswordValid) {
                        passwordInput.classList.add('is-invalid');
                        document.getElementById('passwordError').style.display = 'block';
                    }
                }
            });
            
            // Remove validation styling when user starts typing
            emailInput.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    this.classList.remove('is-invalid');
                    document.getElementById('emailError').style.display = 'none';
                }
            });
            
            passwordInput.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    this.classList.remove('is-invalid');
                    document.getElementById('passwordError').style.display = 'none';
                }
            });
            
            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl + Enter to submit form
                if (e.ctrlKey && e.key === 'Enter') {
                    loginButton.click();
                }
                
                // Escape to clear form
                if (e.key === 'Escape') {
                    if (confirm('Clear all fields?')) {
                        loginForm.reset();
                    }
                }
            });
        });
        
        // Email validation function
        function validateEmail() {
            const emailInput = document.getElementById('email');
            const emailError = document.getElementById('emailError');
            const email = emailInput.value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!email) {
                emailError.textContent = 'Email is required';
                return false;
            }
            
            if (!emailRegex.test(email)) {
                emailError.textContent = 'Please enter a valid email address';
                return false;
            }
            
            emailError.textContent = '';
            return true;
        }
        
        // Password validation function
        function validatePassword() {
            const passwordInput = document.getElementById('password');
            const passwordError = document.getElementById('passwordError');
            const password = passwordInput.value;
            
            if (!password) {
                passwordError.textContent = 'Password is required';
                return false;
            }
            
            if (password.length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters';
                return false;
            }
            
            passwordError.textContent = '';
            return true;
        }
        
        // Show toast notification
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
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
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
    </script>
</body>
</html>