<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Password - Secure Access</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    /* [All existing CSS remains exactly the same as your previous file] */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    html, body {
        height: 100%;
        width: 100%;
        overflow: auto;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
    }

    /* Animated background elements */
    .circle {
        position: fixed;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%);
        animation: float 20s infinite;
        pointer-events: none;
    }

    .circle-1 {
        width: 600px;
        height: 600px;
        top: -200px;
        right: -200px;
        animation-delay: 0s;
    }

    .circle-2 {
        width: 400px;
        height: 400px;
        bottom: -100px;
        left: -100px;
        animation-delay: -5s;
    }

    .circle-3 {
        width: 300px;
        height: 300px;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        animation-delay: -10s;
    }

    @keyframes float {
        0%, 100% {
            transform: translate(0, 0) rotate(0deg);
        }
        25% {
            transform: translate(50px, 50px) rotate(90deg);
        }
        50% {
            transform: translate(0, 100px) rotate(180deg);
        }
        75% {
            transform: translate(-50px, 50px) rotate(270deg);
        }
    }

    .container {
        width: 100%;
        max-width: 500px;
        max-height: 90vh;
        position: relative;
        z-index: 1;
        animation: fadeInUp 0.8s ease;
        margin: auto;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .password-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.2);
        max-height: 85vh;
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: #667eea #f1f1f1;
    }

    .password-card::-webkit-scrollbar {
        width: 6px;
    }

    .password-card::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }

    .password-card::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 10px;
    }

    .header {
        text-align: center;
        margin-bottom: 20px;
    }

    .icon-wrapper {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        position: relative;
        animation: pulse 2s infinite;
    }

    .icon-wrapper i {
        font-size: 30px;
        color: white;
    }

    .header h2 {
        color: #333;
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 5px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .header p {
        color: #666;
        font-size: 13px;
        line-height: 1.5;
    }

    .email-display {
        background: linear-gradient(135deg, #f5f7fa 0%, #e9ecf2 100%);
        padding: 12px 15px;
        border-radius: 12px;
        margin: 15px 0;
        display: flex;
        align-items: center;
        gap: 10px;
        border-left: 4px solid #667eea;
    }

    .email-display i {
        color: #667eea;
        font-size: 16px;
        background: white;
        padding: 8px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .email-display span {
        color: #333;
        font-weight: 600;
        word-break: break-all;
        font-size: 14px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .label-wrapper {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 5px;
        color: #555;
        font-weight: 500;
        font-size: 13px;
    }

    .label-wrapper i {
        color: #667eea;
        font-size: 14px;
    }

    .password-input-wrapper {
        position: relative;
        display: flex;
        align-items: center;
    }

    .password-input-wrapper input {
        width: 100%;
        padding: 12px 45px 12px 15px;
        border: 2px solid #e1e1e1;
        border-radius: 12px;
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: white;
    }

    .password-input-wrapper input:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        outline: none;
    }

    .toggle-password {
        position: absolute;
        right: 12px;
        background: none;
        border: none;
        color: #999;
        cursor: pointer;
        font-size: 16px;
        padding: 5px;
        transition: all 0.3s ease;
        z-index: 2;
    }

    .toggle-password:hover {
        color: #667eea;
    }

    .strength-meter {
        margin-top: 8px;
    }

    .strength-bars {
        display: flex;
        gap: 4px;
        margin-bottom: 4px;
    }

    .strength-bar {
        height: 4px;
        flex: 1;
        background: #e1e1e1;
        border-radius: 4px;
        transition: all 0.3s ease;
    }

    .strength-bar.active {
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
    }

    .strength-text {
        font-size: 11px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .strength-value {
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 20px;
        background: #f0f3ff;
    }

    .password-requirements {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 15px;
        margin: 15px 0;
        border: 1px solid #e1e1e1;
    }

    .requirements-title {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 10px;
        color: #333;
        font-weight: 600;
        font-size: 13px;
    }

    .requirements-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
    }

    .requirement-item {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 11px;
        padding: 6px;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .requirement-item i {
        font-size: 10px;
    }

    .requirement-item.valid {
        color: #28a745;
        background: #d4edda;
    }

    .requirement-item.invalid {
        color: #666;
        background: #f8f9fa;
    }

    /* ========== BUTTON STYLING ========== */
    .btn-update {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 14px;
        font-weight: 600;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        position: relative;
        overflow: hidden;
        margin-top: 5px;
        pointer-events: auto;
        opacity: 1;
        z-index: 10;
    }

    /* Ensure the gradient background stays even when disabled */
    .btn-update:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
        pointer-events: none;
        /* background is unchanged */
    }

    .btn-update:hover:not(:disabled) {
        transform: translateY(-2px);
        box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
    }

    .btn-update i {
        font-size: 16px;
    }

    .alert {
        padding: 12px 15px;
        border-radius: 12px;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
        animation: slideInDown 0.5s ease;
        font-size: 13px;
    }

    @keyframes slideInDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
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

    .password-match {
        margin-top: 6px;
        padding: 6px 10px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 12px;
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .password-match.match {
        background: #d4edda;
        color: #155724;
    }

    .password-match.no-match {
        background: #f8d7da;
        color: #721c24;
    }

    .back-link {
        text-align: center;
        margin-top: 15px;
    }

    .back-link a {
        color: white;
        text-decoration: none;
        font-size: 13px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 20px;
        background: rgba(255, 255, 255, 0.15);
        border-radius: 25px;
        transition: all 0.3s ease;
        cursor: pointer;
        pointer-events: auto;
    }

    .back-link a:hover {
        background: rgba(255, 255, 255, 0.25);
        transform: translateX(-5px);
    }

    .spinner {
        display: none;
        width: 16px;
        height: 16px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        border-top-color: white;
        animation: spin 1s ease-in-out infinite;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        .password-card {
            padding: 20px;
        }
        .header h2 {
            font-size: 22px;
        }
        .requirements-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>
    <div class="circle circle-1"></div>
    <div class="circle circle-2"></div>
    <div class="circle circle-3"></div>

    <div class="container">
        <div class="password-card">
            <div class="header">
                <div class="icon-wrapper">
                    <i class="fas fa-lock"></i>
                </div>
                <h2>Create New Password</h2>
                <p>Your new password must be different from<br>previously used passwords</p>
            </div>

            <div class="email-display">
                <i class="fas fa-envelope"></i>
                <span>${email}</span>
            </div>

            <c:if test="${not empty param.error}">
                <div id="errorAlert" class="alert alert-danger" style="display: flex;">
                    <i class="fas fa-exclamation-circle"></i>
                    <span id="errorMessage">
                        <c:choose>
                            <c:when test="${param.error == 'weak'}">Password is too weak. Please choose a stronger password.</c:when>
                            <c:when test="${param.error == 'mismatch'}">Passwords do not match.</c:when>
                            <c:when test="${param.error == 'invalid'}">Invalid request. Please try again.</c:when>
                            <c:when test="${param.error == 'expired'}">Session expired. Please request password reset again.</c:when>
                            <c:otherwise>An error occurred. Please try again.</c:otherwise>
                        </c:choose>
                    </span>
                    <i class="fas fa-times close-btn" onclick="this.parentElement.style.display='none'"></i>
                </div>
            </c:if>

            <c:if test="${not empty param.success}">
                <div id="successAlert" class="alert alert-success" style="display: flex;">
                    <i class="fas fa-check-circle"></i>
                    <span>Password updated successfully! Redirecting to login...</span>
                    <i class="fas fa-times close-btn" onclick="this.parentElement.style.display='none'"></i>
                </div>
                <script>
                    setTimeout(function() {
                        window.location.href = 'login';
                    }, 3000);
                </script>
            </c:if>

            <div id="jsErrorAlert" class="alert alert-danger" style="display: none;">
                <i class="fas fa-exclamation-circle"></i>
                <span id="jsErrorMessage"></span>
                <i class="fas fa-times close-btn" onclick="this.parentElement.style.display='none'"></i>
            </div>

            <form action="${pageContext.request.contextPath}/update-password" method="post" id="passwordForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" name="email" value="${email}" />
                <input type="hidden" name="token" value="${token}" />

                <div class="form-group">
                    <div class="label-wrapper">
                        <i class="fas fa-key"></i>
                        <label>New Password</label>
                    </div>
                    <div class="password-input-wrapper">
                        <input type="password" name="password" id="newPassword"
                               placeholder="Enter new password" required oninput="checkPasswordStrength()"
                               autocomplete="new-password" minlength="8" maxlength="50">
                        <button type="button" class="toggle-password" onclick="togglePassword('newPassword', this)" tabindex="-1">
                            <i class="far fa-eye"></i>
                        </button>
                    </div>
                    <div class="strength-meter">
                        <div class="strength-bars">
                            <div class="strength-bar" id="bar1"></div>
                            <div class="strength-bar" id="bar2"></div>
                            <div class="strength-bar" id="bar3"></div>
                            <div class="strength-bar" id="bar4"></div>
                        </div>
                        <div class="strength-text">
                            <span class="strength-label">Password Strength:</span>
                            <span class="strength-value" id="strengthText">None</span>
                        </div>
                    </div>
                </div>

                <!-- Confirm Password Field with name attribute -->
                <div class="form-group">
                    <div class="label-wrapper">
                        <i class="fas fa-check-circle"></i>
                        <label>Confirm Password</label>
                    </div>
                    <div class="password-input-wrapper">
                        <input type="password" name="confirmPassword" id="confirmPassword"
                               placeholder="Confirm new password" required oninput="checkPasswordMatch()"
                               autocomplete="new-password" maxlength="50">
                        <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword', this)" tabindex="-1">
                            <i class="far fa-eye"></i>
                        </button>
                    </div>
                    <div id="matchIndicator" class="password-match" style="display: none;">
                        <i class="fas" id="matchIcon"></i>
                        <span id="matchText"></span>
                    </div>
                </div>

                <div class="password-requirements">
                    <div class="requirements-title">
                        <i class="fas fa-shield-alt"></i>
                        <span>Password Requirements</span>
                    </div>
                    <div class="requirements-grid">
                        <div class="requirement-item invalid" id="lengthReq">
                            <i class="fas fa-times-circle"></i>
                            <span>At least 8 characters</span>
                        </div>
                        <div class="requirement-item invalid" id="uppercaseReq">
                            <i class="fas fa-times-circle"></i>
                            <span>One uppercase letter</span>
                        </div>
                        <div class="requirement-item invalid" id="lowercaseReq">
                            <i class="fas fa-times-circle"></i>
                            <span>One lowercase letter</span>
                        </div>
                        <div class="requirement-item invalid" id="numberReq">
                            <i class="fas fa-times-circle"></i>
                            <span>One number</span>
                        </div>
                        <div class="requirement-item invalid" id="specialReq">
                            <i class="fas fa-times-circle"></i>
                            <span>One special character</span>
                        </div>
                        <div class="requirement-item invalid" id="matchReq">
                            <i class="fas fa-times-circle"></i>
                            <span>Passwords match</span>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-update" id="submitBtn" disabled>
                    <span>Update Password</span>
                    <i class="fas fa-arrow-right"></i>
                    <div class="spinner" id="spinner"></div>
                </button>
            </form>
        </div>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/fp">
                <i class="fas fa-arrow-left"></i>
                Back to Forgot Password
            </a>
        </div>
    </div>

    <script>
        // [All JavaScript remains exactly the same as before]
        const PASSWORD_MIN_LENGTH = 8;
        const PASSWORD_MAX_LENGTH = 50;
        
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const submitBtn = document.getElementById('submitBtn');
        const spinner = document.getElementById('spinner');
        const strengthText = document.getElementById('strengthText');
        const matchIndicator = document.getElementById('matchIndicator');
        
        document.addEventListener('DOMContentLoaded', function() {
            const email = "${email}";
            const token = "${token}";
            if (!email || !token) {
                showError('Invalid reset link. Please request a new password reset.');
                submitBtn.disabled = true;
            }
            newPasswordInput.focus();
        });

        function togglePassword(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        function checkPasswordStrength() {
            const password = newPasswordInput.value;
            const lengthValid = password.length >= PASSWORD_MIN_LENGTH && password.length <= PASSWORD_MAX_LENGTH;
            const uppercaseValid = /[A-Z]/.test(password);
            const lowercaseValid = /[a-z]/.test(password);
            const numberValid = /[0-9]/.test(password);
            const specialValid = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
            
            updateRequirement('lengthReq', lengthValid);
            updateRequirement('uppercaseReq', uppercaseValid);
            updateRequirement('lowercaseReq', lowercaseValid);
            updateRequirement('numberReq', numberValid);
            updateRequirement('specialReq', specialValid);
            
            let strength = 0;
            if (lengthValid) strength++;
            if (uppercaseValid) strength++;
            if (lowercaseValid) strength++;
            if (numberValid) strength++;
            if (specialValid) strength++;
            
            updateStrengthBars(strength);
            checkPasswordMatch();
        }

        function updateRequirement(elementId, isValid) {
            const element = document.getElementById(elementId);
            const icon = element.querySelector('i');
            if (isValid) {
                element.classList.remove('invalid');
                element.classList.add('valid');
                icon.classList.remove('fa-times-circle');
                icon.classList.add('fa-check-circle');
            } else {
                element.classList.remove('valid');
                element.classList.add('invalid');
                icon.classList.remove('fa-check-circle');
                icon.classList.add('fa-times-circle');
            }
        }

        function updateStrengthBars(strength) {
            const bars = ['bar1', 'bar2', 'bar3', 'bar4'];
            bars.forEach(bar => document.getElementById(bar).classList.remove('active'));
            const activeBars = Math.min(strength, 4);
            for (let i = 0; i < activeBars; i++) {
                document.getElementById(bars[i]).classList.add('active');
            }
            const strengthLevels = ['None', 'Weak', 'Fair', 'Good', 'Strong'];
            strengthText.textContent = strengthLevels[strength];
            if (strength <= 2) strengthText.style.color = '#dc3545';
            else if (strength <= 4) strengthText.style.color = '#ffc107';
            else strengthText.style.color = '#28a745';
        }

        function checkPasswordMatch() {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const matchIcon = document.getElementById('matchIcon');
            const matchText = document.getElementById('matchText');
            const matchReq = document.getElementById('matchReq');
            
            if (confirmPassword.length > 0) {
                matchIndicator.style.display = 'flex';
                if (password === confirmPassword) {
                    matchIndicator.className = 'password-match match';
                    matchIcon.className = 'fas fa-check-circle';
                    matchText.textContent = 'Passwords match';
                    updateRequirement('matchReq', true);
                } else {
                    matchIndicator.className = 'password-match no-match';
                    matchIcon.className = 'fas fa-exclamation-circle';
                    matchText.textContent = 'Passwords do not match';
                    updateRequirement('matchReq', false);
                }
            } else {
                matchIndicator.style.display = 'none';
                updateRequirement('matchReq', false);
            }
            validateForm();
        }

        function validateForm() {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const lengthValid = password.length >= PASSWORD_MIN_LENGTH && password.length <= PASSWORD_MAX_LENGTH;
            const uppercaseValid = /[A-Z]/.test(password);
            const lowercaseValid = /[a-z]/.test(password);
            const numberValid = /[0-9]/.test(password);
            const specialValid = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
            const matchValid = password === confirmPassword && confirmPassword.length > 0;
            submitBtn.disabled = !(lengthValid && uppercaseValid && lowercaseValid && numberValid && specialValid && matchValid);
        }

        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const btnText = submitBtn.querySelector('span');
            if (password !== confirmPassword) {
                e.preventDefault();
                showError('Passwords do not match');
                return false;
            }
            if (!isPasswordStrong(password)) {
                e.preventDefault();
                showError('Please meet all password requirements');
                return false;
            }
            btnText.style.display = 'none';
            spinner.style.display = 'inline-block';
            submitBtn.disabled = true;
            return true;
        });

        function isPasswordStrong(password) {
            return password.length >= PASSWORD_MIN_LENGTH &&
                   password.length <= PASSWORD_MAX_LENGTH &&
                   /[A-Z]/.test(password) &&
                   /[a-z]/.test(password) &&
                   /[0-9]/.test(password) &&
                   /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
        }

        function showError(message) {
            const errorAlert = document.getElementById('jsErrorAlert');
            const errorMessage = document.getElementById('jsErrorMessage');
            errorMessage.textContent = message;
            errorAlert.style.display = 'flex';
            setTimeout(() => errorAlert.style.display = 'none', 5000);
            window.scrollTo(0, 0);
        }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        let formDirty = false;
        newPasswordInput.addEventListener('input', () => formDirty = true);
        confirmPasswordInput.addEventListener('input', () => formDirty = true);
        window.addEventListener('beforeunload', function(e) {
            if (formDirty && !submitBtn.disabled) {
                e.preventDefault();
                e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
            }
        });
    </script>
</body>
</html>