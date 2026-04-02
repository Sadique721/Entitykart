<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .password-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            animation: slideIn 0.5s ease;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .password-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .password-header h2 {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .password-header p {
            color: #666;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 500;
            color: #444;
            margin-bottom: 5px;
            display: block;
        }
        .form-control {
            border: 2px solid #e1e1e1;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        .password-strength {
            margin-top: 5px;
            height: 5px;
            border-radius: 3px;
            background: #e1e1e1;
            overflow: hidden;
        }
        .strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
        }
        .strength-text {
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }
        .btn-update {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-update:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        .alert {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            display: none;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .password-requirements {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            font-size: 13px;
        }
        .password-requirements ul {
            margin: 5px 0 0 20px;
            padding: 0;
            color: #666;
        }
        .password-requirements li {
            margin: 5px 0;
        }
        .password-requirements .valid {
            color: #28a745;
        }
        .password-requirements .invalid {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="password-card">
        <div class="password-header">
            <h2>Update Password</h2>
            <p>Please enter your current password and choose a new one</p>
        </div>

        <!-- Alert Messages -->
        <div id="successAlert" class="alert alert-success">
            <i class="fas fa-check-circle"></i> Password updated successfully!
        </div>
        <div id="errorAlert" class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> <span id="errorMessage">An error occurred. Please try again.</span>
        </div>

        <form id="passwordForm" action="${pageContext.request.contextPath}/update-password" method="POST">
            <div class="form-group">
                <label class="form-label" for="currentPassword">
                    <i class="fas fa-lock"></i> Current Password
                </label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword" 
                       placeholder="Enter your current password" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="newPassword">
                    <i class="fas fa-key"></i> New Password
                </label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" 
                       placeholder="Enter new password" required onkeyup="checkPasswordStrength()">
                <div class="password-strength">
                    <div class="strength-bar" id="strengthBar"></div>
                </div>
                <span class="strength-text" id="strengthText"></span>
            </div>

            <div class="form-group">
                <label class="form-label" for="confirmPassword">
                    <i class="fas fa-check-circle"></i> Confirm New Password
                </label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                       placeholder="Confirm your new password" required onkeyup="validatePasswordMatch()">
                <small id="passwordMatchMessage" style="color: #dc3545; display: none;">Passwords do not match</small>
            </div>

            <div class="password-requirements">
                <strong>Password Requirements:</strong>
                <ul>
                    <li id="lengthCheck" class="invalid">✗ At least 8 characters</li>
                    <li id="uppercaseCheck" class="invalid">✗ At least one uppercase letter</li>
                    <li id="lowercaseCheck" class="invalid">✗ At least one lowercase letter</li>
                    <li id="numberCheck" class="invalid">✗ At least one number</li>
                    <li id="specialCheck" class="invalid">✗ At least one special character</li>
                </ul>
            </div>

            <button type="submit" class="btn-update" id="submitBtn">
                <i class="fas fa-sync-alt"></i> Update Password
            </button>
        </form>

        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/dashboard" style="color: #667eea; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/your-kit-code.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            // Check requirements
            const lengthValid = password.length >= 8;
            const uppercaseValid = /[A-Z]/.test(password);
            const lowercaseValid = /[a-z]/.test(password);
            const numberValid = /[0-9]/.test(password);
            const specialValid = /[!@#$%^&*(),.?":{}|<>]/.test(password);
            
            // Update requirement checks
            document.getElementById('lengthCheck').innerHTML = (lengthValid ? '✓' : '✗') + ' At least 8 characters';
            document.getElementById('lengthCheck').className = lengthValid ? 'valid' : 'invalid';
            
            document.getElementById('uppercaseCheck').innerHTML = (uppercaseValid ? '✓' : '✗') + ' At least one uppercase letter';
            document.getElementById('uppercaseCheck').className = uppercaseValid ? 'valid' : 'invalid';
            
            document.getElementById('lowercaseCheck').innerHTML = (lowercaseValid ? '✓' : '✗') + ' At least one lowercase letter';
            document.getElementById('lowercaseCheck').className = lowercaseValid ? 'valid' : 'invalid';
            
            document.getElementById('numberCheck').innerHTML = (numberValid ? '✓' : '✗') + ' At least one number';
            document.getElementById('numberCheck').className = numberValid ? 'valid' : 'invalid';
            
            document.getElementById('specialCheck').innerHTML = (specialValid ? '✓' : '✗') + ' At least one special character';
            document.getElementById('specialCheck').className = specialValid ? 'valid' : 'invalid';
            
            // Calculate strength
            let strength = 0;
            if (lengthValid) strength++;
            if (uppercaseValid) strength++;
            if (lowercaseValid) strength++;
            if (numberValid) strength++;
            if (specialValid) strength++;
            
            // Update strength bar
            const percentage = (strength / 5) * 100;
            strengthBar.style.width = percentage + '%';
            
            if (strength <= 2) {
                strengthBar.style.background = '#dc3545';
                strengthText.textContent = 'Weak Password';
                strengthText.style.color = '#dc3545';
            } else if (strength <= 4) {
                strengthBar.style.background = '#ffc107';
                strengthText.textContent = 'Medium Password';
                strengthText.style.color = '#ffc107';
            } else {
                strengthBar.style.background = '#28a745';
                strengthText.textContent = 'Strong Password';
                strengthText.style.color = '#28a745';
            }
            
            validateForm();
        }
        
        function validatePasswordMatch() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchMessage = document.getElementById('passwordMatchMessage');
            
            if (confirmPassword) {
                if (newPassword !== confirmPassword) {
                    matchMessage.style.display = 'block';
                } else {
                    matchMessage.style.display = 'none';
                }
            } else {
                matchMessage.style.display = 'none';
            }
            
            validateForm();
        }
        
        function validateForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const submitBtn = document.getElementById('submitBtn');
            
            // Check all requirements
            const lengthValid = newPassword.length >= 8;
            const uppercaseValid = /[A-Z]/.test(newPassword);
            const lowercaseValid = /[a-z]/.test(newPassword);
            const numberValid = /[0-9]/.test(newPassword);
            const specialValid = /[!@#$%^&*(),.?":{}|<>]/.test(newPassword);
            const passwordsMatch = newPassword === confirmPassword;
            
            const isValid = lengthValid && uppercaseValid && lowercaseValid && 
                           numberValid && specialValid && passwordsMatch && 
                           confirmPassword.length > 0;
            
            submitBtn.disabled = !isValid;
        }
        
        // Handle form submission
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Hide any existing alerts
            document.getElementById('successAlert').style.display = 'none';
            document.getElementById('errorAlert').style.display = 'none';
            
            const formData = new FormData(this);
            
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('successAlert').style.display = 'block';
                    this.reset();
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                    }, 2000);
                } else {
                    document.getElementById('errorMessage').textContent = data.message || 'Failed to update password';
                    document.getElementById('errorAlert').style.display = 'block';
                }
            })
            .catch(error => {
                document.getElementById('errorMessage').textContent = 'An error occurred. Please try again.';
                document.getElementById('errorAlert').style.display = 'block';
            });
        });
    </script>
</body>
</html>