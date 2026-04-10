<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP - Secure Access</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
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
        overflow: hidden;
    }

    /* Animated background elements */
    body::before {
        content: '';
        position: absolute;
        width: 2000px;
        height: 2000px;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%);
        top: -1000px;
        right: -500px;
        animation: rotate 20s linear infinite;
    }

    body::after {
        content: '';
        position: absolute;
        width: 1500px;
        height: 1500px;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(255,255,255,0.08) 0%, rgba(255,255,255,0.03) 100%);
        bottom: -750px;
        left: -300px;
        animation: rotate 15s linear infinite reverse;
    }

    @keyframes rotate {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(360deg);
        }
    }

    .container {
        width: 100%;
        max-width: 500px;
        position: relative;
        z-index: 1;
        animation: fadeInUp 0.8s ease;
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

    .otp-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease;
    }

    .otp-card:hover {
        transform: translateY(-5px);
    }

    /* Header Section */
    .header {
        text-align: center;
        margin-bottom: 30px;
    }

    .icon-wrapper {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7);
        }
        70% {
            box-shadow: 0 0 0 15px rgba(102, 126, 234, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(102, 126, 234, 0);
        }
    }

    .icon-wrapper i {
        font-size: 36px;
        color: white;
    }

    .header h2 {
        color: #333;
        font-size: 28px;
        font-weight: 600;
        margin-bottom: 10px;
    }

    .header p {
        color: #666;
        font-size: 14px;
        line-height: 1.6;
    }

    .email-display {
        background: linear-gradient(135deg, #f5f7fa 0%, #e9ecf2 100%);
        padding: 12px 20px;
        border-radius: 12px;
        margin: 20px 0;
        display: flex;
        align-items: center;
        gap: 10px;
        border-left: 4px solid #667eea;
    }

    .email-display i {
        color: #667eea;
        font-size: 18px;
    }

    .email-display span {
        color: #333;
        font-weight: 500;
        word-break: break-all;
    }

    /* Form Section */
    .form-group {
        margin-bottom: 25px;
    }

    .label-wrapper {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
        color: #555;
        font-weight: 500;
        font-size: 14px;
    }

    .label-wrapper i {
        color: #667eea;
        font-size: 14px;
    }

    .otp-input-group {
        display: flex;
        gap: 10px;
        margin-bottom: 5px;
    }

    .otp-input-group input {
        flex: 1;
        padding: 16px 20px;
        border: 2px solid #e1e1e1;
        border-radius: 12px;
        font-size: 16px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: white;
        letter-spacing: 2px;
        font-weight: 600;
        color: #333;
        text-align: center;
    }

    .otp-input-group input:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        outline: none;
        transform: scale(1.02);
    }

    .otp-input-group input::placeholder {
        color: #999;
        font-weight: 300;
        letter-spacing: normal;
    }

    /* OTP Timer */
    .otp-timer {
        text-align: right;
        margin-top: 5px;
        font-size: 13px;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 5px;
    }

    .timer-text {
        color: #666;
    }

    .time {
        color: #667eea;
        font-weight: 600;
        background: #f0f3ff;
        padding: 4px 8px;
        border-radius: 20px;
    }

    /* Button */
    .btn-verify {
        width: 100%;
        padding: 16px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        position: relative;
        overflow: hidden;
    }

    .btn-verify::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.3);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }

    .btn-verify:hover::before {
        width: 300px;
        height: 300px;
    }

    .btn-verify:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
    }

    .btn-verify:active {
        transform: translateY(0);
    }

    .btn-verify i {
        font-size: 18px;
        transition: transform 0.3s ease;
    }

    .btn-verify:hover i {
        transform: translateX(5px);
    }

    /* Resend Section */
    .resend-section {
        text-align: center;
        margin-top: 25px;
        padding-top: 25px;
        border-top: 1px solid #e1e1e1;
    }

    .resend-text {
        color: #666;
        font-size: 14px;
        margin-bottom: 10px;
    }

    .resend-btn {
        background: none;
        border: 2px solid #667eea;
        color: #667eea;
        padding: 10px 25px;
        border-radius: 25px;
        font-size: 14px;
        font-weight: 500;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .resend-btn:hover:not(:disabled) {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .resend-btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        border-color: #999;
        color: #999;
    }

    .resend-btn i {
        font-size: 14px;
    }

    /* Alert Messages */
    .alert {
        padding: 15px 20px;
        border-radius: 12px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
        animation: slideIn 0.5s ease;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .alert-success {
        background: #d4edda;
        color: #155724;
        border-left: 4px solid #28a745;
    }

    .alert-danger {
        background: #f8d7da;
        color: #721c24;
        border-left: 4px solid #dc3545;
    }

    .alert i {
        font-size: 20px;
    }

    .alert .close-btn {
        margin-left: auto;
        cursor: pointer;
        opacity: 0.5;
        transition: opacity 0.3s ease;
    }

    .alert .close-btn:hover {
        opacity: 1;
    }

    /* Back Link */
    .back-link {
        text-align: center;
        margin-top: 20px;
    }

    .back-link a {
        color: white;
        text-decoration: none;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 20px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 25px;
        transition: all 0.3s ease;
    }

    .back-link a:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateX(-5px);
    }

    .back-link i {
        font-size: 14px;
    }

    /* Loading Spinner */
    .spinner {
        display: none;
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

    /* Responsive Design */
    @media (max-width: 480px) {
        .otp-card {
            padding: 30px 20px;
        }

        .header h2 {
            font-size: 24px;
        }

        .icon-wrapper {
            width: 60px;
            height: 60px;
        }

        .icon-wrapper i {
            font-size: 28px;
        }

        .otp-input-group input {
            padding: 14px;
            font-size: 14px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="otp-card">
            <!-- Header with Icon -->
            <div class="header">
                <div class="icon-wrapper">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h2>Verify Your Identity</h2>
                <p>Please enter the 6-digit verification code<br>sent to your email address</p>
            </div>

            <!-- Display Email -->
            <div class="email-display">
                <i class="fas fa-envelope"></i>
                <span>${email}</span>
            </div>

            <!-- Alert Messages (Hidden by default) -->
            <div id="errorAlert" class="alert alert-danger" style="display: none;">
                <i class="fas fa-exclamation-circle"></i>
                <span id="errorMessage">Invalid OTP. Please try again.</span>
                <i class="fas fa-times close-btn" onclick="this.parentElement.style.display='none'"></i>
            </div>

            <div id="successAlert" class="alert alert-success" style="display: none;">
                <i class="fas fa-check-circle"></i>
                <span>OTP verified successfully! Redirecting...</span>
                <i class="fas fa-times close-btn" onclick="this.parentElement.style.display='none'"></i>
            </div>

            <!-- OTP Verification Form -->
            <form action="verify-otp" method="post" id="otpForm" onsubmit="return validateForm()">
                <input type="hidden" name="email" value="${email}" />
                
                <div class="form-group">
                    <div class="label-wrapper">
                        <i class="fas fa-key"></i>
                        <label>Verification Code</label>
                    </div>
                    
                    <div class="otp-input-group">
                        <input type="text" 
                               name="otp"
                               id="otpInput"
                               placeholder="Enter 6-digit OTP"
                               maxlength="6"
                               pattern="[0-9]{6}"
                               title="Please enter a valid 6-digit OTP"
                               required 
                               autocomplete="off">
                    </div>

                    <!-- OTP Timer -->
                    <div class="otp-timer">
                        <span class="timer-text"><i class="far fa-clock"></i> Code expires in:</span>
                        <span class="time" id="timer">05:00</span>
                    </div>
                </div>

                <!-- Verify Button -->
                <button type="submit" class="btn-verify" id="verifyBtn">
                    <span>Verify OTP</span>
                    <i class="fas fa-arrow-right"></i>
                    <div class="spinner" id="spinner"></div>
                </button>
            </form>

            <!-- Resend OTP Section -->
            <div class="resend-section">
                <div class="resend-text">Didn't receive the code?</div>
                <button class="resend-btn" id="resendBtn" onclick="resendOTP()" disabled>
                    <i class="fas fa-redo-alt"></i>
                    Resend OTP
                    <span id="resendTimer"></span>
                </button>
            </div>
        </div>

        <!-- Back Link -->
        <div class="back-link">
            <a href="forgot-password">
                <i class="fas fa-arrow-left"></i>
                Back to Forgot Password
            </a>
        </div>
    </div>

    <script>
        // Timer functionality
        let timeLeft = 300; // 5 minutes in seconds
        const timerElement = document.getElementById('timer');
        const resendBtn = document.getElementById('resendBtn');
        let resendCooldown = 60; // 1 minute cooldown for resend

        function updateTimer() {
            if (timeLeft > 0) {
                timeLeft--;
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                timerElement.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
                
                if (timeLeft < 60) {
                    timerElement.style.color = '#dc3545';
                }
            } else {
                timerElement.textContent = '00:00';
                timerElement.style.color = '#dc3545';
                // Auto-enable resend when timer expires
                resendBtn.disabled = false;
            }
        }

        // Start timer
        setInterval(updateTimer, 1000);

        // OTP Input validation
        document.getElementById('otpInput').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 6);
            
            // Visual feedback
            if (this.value.length === 6) {
                this.style.borderColor = '#28a745';
                this.style.backgroundColor = '#f0fff4';
            } else {
                this.style.borderColor = '#e1e1e1';
                this.style.backgroundColor = 'white';
            }
        });

        // Form validation
        function validateForm() {
            const otp = document.getElementById('otpInput').value;
            const verifyBtn = document.getElementById('verifyBtn');
            const spinner = document.getElementById('spinner');
            const btnText = verifyBtn.querySelector('span');
            
            if (otp.length !== 6) {
                showError('Please enter a valid 6-digit OTP');
                return false;
            }

            // Show loading state
            btnText.style.display = 'none';
            spinner.style.display = 'inline-block';
            verifyBtn.disabled = true;

            return true;
        }

        // Show error message
        function showError(message) {
            const errorAlert = document.getElementById('errorAlert');
            const errorMessage = document.getElementById('errorMessage');
            errorMessage.textContent = message;
            errorAlert.style.display = 'flex';
            
            // Auto hide after 5 seconds
            setTimeout(() => {
                errorAlert.style.display = 'none';
            }, 5000);
        }

        // Resend OTP functionality
        function resendOTP() {
            const resendBtn = document.getElementById('resendBtn');
            resendBtn.disabled = true;
            
            // Show loading state
            const originalText = resendBtn.innerHTML;
            resendBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
            
            // Simulate API call (replace with actual AJAX call)
            setTimeout(() => {
                // Reset timer
                timeLeft = 300;
                timerElement.textContent = '05:00';
                timerElement.style.color = '#667eea';
                
                // Reset button
                resendBtn.innerHTML = originalText;
                
                // Start cooldown
                let cooldown = 60;
                const cooldownInterval = setInterval(() => {
                    cooldown--;
                    if (cooldown > 0) {
                        resendBtn.innerHTML = `<i class="fas fa-redo-alt"></i> Resend OTP (${cooldown}s)`;
                    } else {
                        clearInterval(cooldownInterval);
                        resendBtn.innerHTML = '<i class="fas fa-redo-alt"></i> Resend OTP';
                        resendBtn.disabled = false;
                    }
                }, 1000);
                
                // Show success message
                const successAlert = document.getElementById('successAlert');
                successAlert.querySelector('span').textContent = 'New OTP sent successfully!';
                successAlert.style.display = 'flex';
                setTimeout(() => {
                    successAlert.style.display = 'none';
                }, 3000);
            }, 1500);
        }

        // Auto-focus OTP input
        document.getElementById('otpInput').focus();

        // Handle paste event
        document.getElementById('otpInput').addEventListener('paste', function(e) {
            e.preventDefault();
            const pastedText = (e.clipboardData || window.clipboardData).getData('text');
            const numbers = pastedText.replace(/[^0-9]/g, '').slice(0, 6);
            this.value = numbers;
            
            // Trigger validation
            if (numbers.length === 6) {
                this.style.borderColor = '#28a745';
                this.style.backgroundColor = '#f0fff4';
            }
        });

        // Enable resend after 60 seconds
        setTimeout(() => {
            resendBtn.disabled = false;
        }, 60000);

        // Handle form submission response
        window.onload = function() {
            // Check URL parameters for error/success
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'invalid') {
                showError('Invalid OTP. Please try again.');
            } else if (urlParams.get('error') === 'expired') {
                showError('OTP has expired. Please request a new one.');
            }
        };
    </script>
</body>
</html>