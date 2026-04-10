<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | EntityKart</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        /* ===== CSS Variables ===== */
        :root {
            --primary-color: #667eea;
            --primary-dark: #5a67d8;
            --secondary-color: #764ba2;
            --success-color: #56ab2f;
            --danger-color: #e53e3e;
            --warning-color: #f6ad55;
            --light-bg: #f8fafc;
            --border-color: #e2e8f0;
            --text-primary: #2d3748;
            --text-secondary: #4a5568;
            --text-muted: #718096;
            
            --primary-gradient: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            --success-gradient: linear-gradient(135deg, var(--success-color) 0%, #a8e063 100%);
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --border-radius: 12px;
            --border-radius-sm: 8px;
        }
        
        /* ===== Base Styles ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px 0;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        .container {
            max-width: 1200px;
            padding: 0 15px;
        }
        
        /* ===== Registration Card ===== */
        .registration-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-xl);
            overflow: hidden;
            margin: 30px auto;
            transition: var(--transition);
            max-width: 100%;
        }
        
        .registration-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }
        
        /* ===== Card Header ===== */
        .card-header {
            background: var(--primary-gradient);
            padding: 2.5rem;
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
            pointer-events: none;
        }
        
        .card-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }
        
        .card-header p {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }
        
        /* ===== Card Body ===== */
        .card-body {
            padding: 2rem 2.5rem;
        }
        
        /* ===== Profile Image Upload ===== */
        .profile-image-section {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--light-bg);
            border-radius: var(--border-radius);
            border: 2px dashed var(--border-color);
            transition: var(--transition);
        }
        
        .profile-image-section:hover {
            border-color: var(--primary-color);
            background: #f0f4ff;
        }
        
        .profile-image-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--light-bg);
            border: 4px solid white;
            box-shadow: var(--shadow-md);
            margin: 0 auto 1rem;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .profile-image-preview:hover {
            transform: scale(1.05);
            box-shadow: var(--shadow-lg);
        }
        
        .profile-image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-image-preview i {
            font-size: 3rem;
            color: var(--text-muted);
        }
        
        .profile-image-label {
            display: inline-block;
            padding: 0.5rem 1.5rem;
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 0.5rem;
        }
        
        .profile-image-label:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .file-input {
            display: none;
        }
        
        .image-requirements {
            font-size: 0.875rem;
            color: var(--text-muted);
            margin-top: 0.75rem;
        }
        
        /* ===== Form Elements ===== */
        .form-label {
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }
        
        .field-icon {
            color: var(--primary-color);
            font-size: 1.125rem;
        }
        
        .form-control,
        .form-select {
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 0.875rem 1rem;
            font-size: 1rem;
            transition: var(--transition);
            width: 100%;
            background: white;
        }
        
        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
        .form-control.is-invalid,
        .form-select.is-invalid {
            border-color: var(--danger-color);
        }
        
        .form-control.is-invalid:focus {
            box-shadow: 0 0 0 3px rgba(229, 62, 62, 0.1);
        }
        
        .input-group {
            border-radius: var(--border-radius-sm);
            overflow: hidden;
            border: 2px solid var(--border-color);
            transition: var(--transition);
        }
        
        .input-group:focus-within {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .input-group .form-control {
            border: none;
            padding-left: 1rem;
        }
        
        .input-group-text {
            background: var(--light-bg);
            border: none;
            color: var(--primary-color);
            padding: 0.875rem 1rem;
            font-size: 1rem;
        }
        
        /* ===== Password Strength ===== */
        .password-strength {
            height: 6px;
            border-radius: 3px;
            background: var(--border-color);
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .strength-fill {
            height: 100%;
            width: 0%;
            transition: var(--transition);
            border-radius: 3px;
        }
        
        /* ===== Toggle Password Button ===== */
        .btn-toggle-password {
            background: var(--light-bg);
            border: 2px solid var(--border-color);
            border-left: none;
            color: var(--primary-color);
            cursor: pointer;
            padding: 0.875rem 1rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-toggle-password:hover {
            background: var(--border-color);
        }
        
        /* ===== Form Sections ===== */
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        /* ===== Birth Year Range ===== */
        .birth-year-range {
            width: 100%;
            height: 8px;
            margin: 1rem 0 0.5rem;
            background: var(--border-color);
            border-radius: 4px;
            outline: none;
            -webkit-appearance: none;
            appearance: none;
        }
        
        .birth-year-range::-webkit-slider-thumb {
            -webkit-appearance: none;
            width: 22px;
            height: 22px;
            background: var(--primary-color);
            border-radius: 50%;
            cursor: pointer;
            border: 3px solid white;
            box-shadow: var(--shadow-md);
        }
        
        .birth-year-range::-moz-range-thumb {
            width: 22px;
            height: 22px;
            background: var(--primary-color);
            border-radius: 50%;
            cursor: pointer;
            border: 3px solid white;
            box-shadow: var(--shadow-md);
        }
        
        .age-indicator {
            font-size: 0.875rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }
        
        /* ===== Gender Options ===== */
        .gender-options {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 0.5rem;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-check-input {
            width: 1.25rem;
            height: 1.25rem;
            margin-top: 0;
            cursor: pointer;
        }
        
        .form-check-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            font-weight: 500;
        }
        
        /* ===== Terms & Conditions ===== */
        .terms-check {
            margin: 2rem 0;
            padding: 1.5rem;
            background: var(--light-bg);
            border-radius: var(--border-radius-sm);
            border-left: 4px solid var(--primary-color);
        }
        
        /* ===== Form Footer ===== */
        .form-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border-color);
            gap: 1rem;
        }
        
        /* ===== Buttons ===== */
        .btn-register {
            background: var(--success-gradient);
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 1rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            cursor: pointer;
            min-width: 180px;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(86, 171, 47, 0.3);
        }
        
        .btn-register:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-reset {
            background: var(--light-bg);
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 1rem 2rem;
            font-weight: 500;
            color: var(--text-secondary);
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            min-width: 180px;
        }
        
        .btn-reset:hover {
            background: var(--border-color);
        }
        
        /* ===== Login Link ===== */
        .login-link {
            text-align: center;
            padding: 1.5rem;
            background: var(--light-bg);
            border-top: 1px solid var(--border-color);
        }
        
        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        /* ===== Validation Messages ===== */
        .invalid-feedback {
            font-size: 0.875rem;
            color: var(--danger-color);
            margin-top: 0.25rem;
            display: none;
        }
        
        .is-invalid ~ .invalid-feedback {
            display: block;
        }
        
        .form-text {
            font-size: 0.875rem;
            color: var(--text-muted);
            margin-top: 0.5rem;
        }
        
        /* ===== Progress Bar ===== */
        .upload-progress {
            height: 4px;
            background: var(--border-color);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
            display: none;
        }
        
        .upload-progress-bar {
            height: 100%;
            background: var(--primary-gradient);
            width: 0%;
            transition: width 0.3s ease;
        }
        
        /* ===== Responsive Design ===== */
        @media (max-width: 992px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .card-header {
                padding: 2rem;
            }
            
            .card-header h1 {
                font-size: 1.75rem;
            }
        }
        
        @media (max-width: 768px) {
            body {
                padding: 10px 0;
            }
            
            .registration-card {
                margin: 10px;
                border-radius: 10px;
            }
            
            .card-header {
                padding: 1.5rem;
            }
            
            .card-header h1 {
                font-size: 1.5rem;
            }
            
            .card-body {
                padding: 1.25rem;
            }
            
            .section-title {
                font-size: 1.125rem;
                margin-bottom: 1.25rem;
            }
            
            .form-footer {
                flex-direction: column;
                gap: 1rem;
            }
            
            .btn-register,
            .btn-reset {
                width: 100%;
                justify-content: center;
            }
            
            .gender-options {
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .profile-image-preview {
                width: 100px;
                height: 100px;
            }
        }
        
        @media (max-width: 576px) {
            .card-header {
                padding: 1.25rem;
            }
            
            .card-header h1 {
                font-size: 1.375rem;
            }
            
            .card-header p {
                font-size: 0.875rem;
            }
            
            .card-body {
                padding: 1rem;
            }
            
            .form-control,
            .form-select {
                padding: 0.75rem;
                font-size: 0.9375rem;
            }
            
            .btn-register,
            .btn-reset {
                padding: 0.875rem 1.5rem;
            }
        }
        
        /* ===== Grid System Overrides ===== */
        .row.g-3 {
            --bs-gutter-x: 1rem;
            --bs-gutter-y: 1rem;
        }
        
        /* ===== Loading Spinner ===== */
        .spinner-border {
            width: 1.25rem;
            height: 1.25rem;
            border-width: 0.15em;
        }
        
        /* ===== Accessibility Improvements ===== */
        .form-control:focus-visible,
        .form-select:focus-visible,
        .btn-register:focus-visible,
        .btn-reset:focus-visible {
            outline: 2px solid var(--primary-color);
            outline-offset: 2px;
        }
        
        /* ===== Print Styles ===== */
        @media print {
            .registration-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }
            
            .btn-register,
            .btn-reset,
            .btn-toggle-password,
            .login-link {
                display: none !important;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4 mt-lg-5">
        <div class="row justify-content-center">
            <div class="col-xl-8 col-lg-10 col-md-12">
                <div class="registration-card">
                    <!-- Header -->
                    <div class="card-header">
                        <h1>Create Your Account</h1>
                        <p>Join EntityKart in just a few steps</p>
                    </div>

                    <!-- Registration Form -->
                    <div class="card-body p-4 p-lg-5">
                        <!-- IMPORTANT: Add enctype="multipart/form-data" for file upload -->
                        <form action="register" method="post" id="registrationForm" novalidate enctype="multipart/form-data">
                            
                            <!-- Profile Image Upload Section -->
                            <div class="profile-image-section">
                                <div class="profile-image-preview" id="profilePreview" onclick="document.getElementById('profilePic').click()">
                                    <i class="bi bi-person-circle"></i>
                                </div>
                                <div>
                                    <label for="profilePic" class="profile-image-label">
                                        <i class="bi bi-camera me-2"></i>Choose Profile Picture
                                    </label>
                                    <input type="file" class="file-input" id="profilePic" name="profilePic" accept="image/jpeg, image/png, image/gif, image/webp">
                                    <div class="image-requirements">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Supported formats: JPG, PNG, GIF, WEBP (Max size: 5MB)
                                    </div>
                                    <div class="upload-progress" id="uploadProgress">
                                        <div class="upload-progress-bar" id="uploadProgressBar"></div>
                                    </div>
                                    <div class="invalid-feedback" id="profilePicError">
                                        Please select a valid image file (JPG, PNG, GIF, WEBP) under 5MB.
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Personal Information Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-person-circle"></i> Personal Information
                                </h3>
                                
                                <div class="row g-3">
                                    <!-- Full Name -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-person field-icon"></i> Full Name
                                        </label>
                                        <input type="text" name="name" class="form-control" 
                                               placeholder="Enter your full name" required
                                               pattern="^[a-zA-Z\s]{2,50}$"
                                               title="Please enter a valid name (2-50 characters, letters only)">
                                        <div class="invalid-feedback">Please enter a valid full name (2-50 characters).</div>
                                    </div>

                                    <!-- Email -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-envelope field-icon"></i> Email Address
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text">@</span>
                                            <input type="email" name="email" class="form-control" 
                                                   placeholder="you@example.com" required
                                                   pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                                        </div>
                                        <div class="invalid-feedback">Please enter a valid email address.</div>
                                    </div>

                                    <!-- Contact Number -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-phone field-icon"></i> Contact Number
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-telephone"></i>
                                            </span>
                                            <input type="tel" name="contactNum" class="form-control" 
                                                   placeholder="+91 1234567890" required
                                                   pattern="^(\+91[\-\s]?)?[0-9]{10}$"
                                                   title="Please enter a valid 10-digit phone number">
                                        </div>
                                        <div class="invalid-feedback">Please enter a valid 10-digit contact number.</div>
                                    </div>

                                    <!-- Birth Year with Range -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-calendar field-icon"></i> Birth Year
                                        </label>
                                        <input type="number" name="birthYear" class="form-control" 
                                               min="1900" max="2024" value="1990" required>
                                        <input type="range" class="birth-year-range" min="1900" max="2024" 
                                               value="1990" id="birthYearRange" aria-label="Birth year range">
                                        <div class="age-indicator" id="ageIndicator">Age: 34 years</div>
                                        <div class="invalid-feedback">Please enter a valid birth year (1900-2024).</div>
                                    </div>

                                    <!-- Gender -->
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="bi bi-gender-ambiguous field-icon"></i> Gender
                                        </label>
                                        <div class="gender-options">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" 
                                                       value="MALE" id="male" required checked>
                                                <label class="form-check-label" for="male">
                                                    <i class="bi bi-gender-male"></i> Male
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" 
                                                       value="FEMALE" id="female">
                                                <label class="form-check-label" for="female">
                                                    <i class="bi bi-gender-female"></i> Female
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" 
                                                       value="OTHER" id="other">
                                                <label class="form-check-label" for="other">
                                                    <i class="bi bi-gender-ambiguous"></i> Other
                                                </label>
                                            </div>
                                        </div>
                                        <div class="invalid-feedback">Please select your gender.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Password Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-shield-lock"></i> Account Security
                                </h3>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-key field-icon"></i> Password
                                        </label>
                                        <div class="input-group">
                                            <input type="password" name="password" id="password" 
                                                   class="form-control" placeholder="Create strong password" required
                                                   pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                                                   title="Minimum 8 characters with uppercase, lowercase, number and special character">
                                            <button class="btn btn-toggle-password" type="button" 
                                                    id="togglePassword" aria-label="Toggle password visibility">
                                                <i class="bi bi-eye-slash"></i>
                                            </button>
                                        </div>
                                        <div class="password-strength">
                                            <div class="strength-fill" id="strengthFill"></div>
                                        </div>
                                        <div class="form-text">Must contain at least 8 characters with uppercase, lowercase, number and special character</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-key-fill field-icon"></i> Confirm Password
                                        </label>
                                        <div class="input-group">
                                            <input type="password" id="confirmPassword" class="form-control" 
                                                   placeholder="Re-enter password" required>
                                            <button class="btn btn-toggle-password" type="button" 
                                                    onclick="togglePassword('confirmPassword')"
                                                    aria-label="Toggle confirm password visibility">
                                                <i class="bi bi-eye-slash"></i>
                                            </button>
                                        </div>
                                        <div class="invalid-feedback" id="passwordMatchError">Passwords do not match.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Education Section -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-mortarboard"></i> Education
                                </h3>

                                <div class="row g-3">
                                    <!-- Qualification -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-mortarboard field-icon"></i> Qualification
                                        </label>
                                        <select name="qualification" class="form-select" required>
                                            <option value="">Select Qualification</option>
                                            <option value="High School">High School</option>
                                            <option value="Diploma">Diploma</option>
                                            <option value="B.Tech">B.Tech</option>
                                            <option value="B.Sc">B.Sc</option>
                                            <option value="M.Tech">M.Tech</option>
                                            <option value="MBA">MBA</option>
                                            <option value="PhD">PhD</option>
                                            <option value="Other">Other</option>
                                        </select>
                                        <div class="invalid-feedback">Please select your qualification.</div>
                                    </div>

                                    <!-- Country -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-globe field-icon"></i> Country
                                        </label>
                                        <input type="text" name="country" class="form-control" 
                                               value="India" readonly aria-readonly="true">
                                    </div>
                                </div>
                            </div>

                            <!-- Address Information -->
                            <div class="mb-5">
                                <h3 class="section-title">
                                    <i class="bi bi-house-door"></i> Address Information
                                </h3>

                                <div class="row g-3">
                                    <!-- Address Line 1 -->
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="bi bi-house field-icon"></i> Address Line 1
                                        </label>
                                        <input type="text" name="addressLine1" class="form-control" 
                                               placeholder="Street address, P.O. box, company name" required
                                               maxlength="200">
                                        <div class="invalid-feedback">Please enter your address.</div>
                                    </div>

                                    <!-- City -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-building field-icon"></i> City
                                        </label>
                                        <input type="text" name="city" class="form-control" 
                                               placeholder="Enter your city" required
                                               pattern="^[a-zA-Z\s]{2,50}$"
                                               title="Please enter a valid city name">
                                        <div class="invalid-feedback">Please enter a valid city name.</div>
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
                                            <option value="Bihar">Bihar</option>
                                            <option value="Gujarat">Gujarat</option>
                                            <option value="Other">Other</option>
                                        </select>
                                        <div class="invalid-feedback">Please select your state.</div>
                                    </div>

                                    <!-- Pin Code -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-pin-map field-icon"></i> Pin Code
                                        </label>
                                        <input type="text" name="pincode" class="form-control" 
                                               placeholder="6-digit PIN code" required
                                               pattern="^[1-9][0-9]{5}$"
                                               title="Please enter a valid 6-digit PIN code"
                                               maxlength="6">
                                        <div class="invalid-feedback">Please enter a valid 6-digit PIN code.</div>
                                    </div>

                                    <!-- Address Type -->
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-tag field-icon"></i> Address Type
                                        </label>
                                        <select name="addressType" class="form-select" required>
                                            <option value="">Select Address Type</option>
                                            <option value="HOME">Home</option>
                                            <option value="OFFICE">Office</option>
                                            <option value="OTHER">Other</option>
                                        </select>
                                        <div class="invalid-feedback">Please select address type.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Terms & Conditions -->
                            <div class="terms-check">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" 
                                           id="terms" required>
                                    <label class="form-check-label" for="terms">
                                        I agree to the <a href="#" class="text-primary">Terms & Conditions</a> 
                                        and <a href="#" class="text-primary">Privacy Policy</a>
                                    </label>
                                    <div class="invalid-feedback">You must agree to the terms.</div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="form-footer">
                                <button type="button" class="btn-reset" onclick="resetForm()">
                                    <i class="bi bi-arrow-clockwise"></i> Reset Form
                                </button>
                                <button type="submit" class="btn-register">
                                    <i class="bi bi-person-plus"></i> Create Account
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Login Link -->
                    <div class="login-link">
                        <p class="mb-0">
                            Already have an account? 
                            <a href="login">Sign In</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Registration Form JavaScript -->
    <script>
        // Initialize when document is ready
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registrationForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const birthYearInput = document.querySelector('input[name="birthYear"]');
            const birthYearRange = document.getElementById('birthYearRange');
            const ageIndicator = document.getElementById('ageIndicator');
            const profilePic = document.getElementById('profilePic');
            const profilePreview = document.getElementById('profilePreview');
            const profilePicError = document.getElementById('profilePicError');
            
            // Update age indicator
            function updateAgeIndicator() {
                const currentYear = new Date().getFullYear();
                const birthYear = parseInt(birthYearInput.value);
                if (!isNaN(birthYear)) {
                    const age = currentYear - birthYear;
                    ageIndicator.textContent = `Age: ${age} years`;
                }
            }
            
            // Initialize age indicator
            updateAgeIndicator();
            
            // Birth Year Range Sync
            birthYearRange.addEventListener('input', function() {
                birthYearInput.value = this.value;
                updateAgeIndicator();
            });
            
            birthYearInput.addEventListener('input', function() {
                let value = parseInt(this.value);
                if (isNaN(value)) value = 1990;
                if (value < 1900) value = 1900;
                if (value > 2024) value = 2024;
                this.value = value;
                birthYearRange.value = value;
                updateAgeIndicator();
            });
            
            // Profile Image Preview with validation
            profilePic.addEventListener('change', function(event) {
                const file = event.target.files[0];
                const progressBar = document.getElementById('uploadProgress');
                const progressBarFill = document.getElementById('uploadProgressBar');
                
                if (file) {
                    // Validate file type
                    const validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
                    if (!validTypes.includes(file.type)) {
                        profilePicError.textContent = 'Invalid file type. Please select JPG, PNG, GIF, or WEBP.';
                        profilePicError.style.display = 'block';
                        this.value = '';
                        return;
                    }
                    
                    // Validate file size (5MB max)
                    const maxSize = 5 * 1024 * 1024; // 5MB in bytes
                    if (file.size > maxSize) {
                        profilePicError.textContent = 'File size exceeds 5MB. Please choose a smaller image.';
                        profilePicError.style.display = 'block';
                        this.value = '';
                        return;
                    }
                    
                    // Show progress bar
                    progressBar.style.display = 'block';
                    
                    // Simulate upload progress
                    let width = 0;
                    const interval = setInterval(function() {
                        if (width >= 100) {
                            clearInterval(interval);
                            setTimeout(function() {
                                progressBar.style.display = 'none';
                                progressBarFill.style.width = '0%';
                            }, 500);
                        } else {
                            width += 10;
                            progressBarFill.style.width = width + '%';
                        }
                    }, 50);
                    
                    // Preview image
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        profilePreview.innerHTML = `<img src="${e.target.result}" alt="Profile Preview">`;
                        profilePicError.style.display = 'none';
                    };
                    reader.readAsDataURL(file);
                } else {
                    // Reset preview
                    profilePreview.innerHTML = '<i class="bi bi-person-circle"></i>';
                }
            });
            
            // Password Strength Indicator
            password.addEventListener('input', function() {
                const strength = checkPasswordStrength(this.value);
                const strengthFill = document.getElementById('strengthFill');
                
                strengthFill.style.width = strength.width;
                strengthFill.style.background = strength.color;
                strengthFill.setAttribute('aria-valuenow', Math.round(parseInt(strength.width)));
            });
            
            // Password Visibility Toggle
            document.getElementById('togglePassword').addEventListener('click', function() {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                const icon = this.querySelector('i');
                icon.className = type === 'password' ? 'bi bi-eye-slash' : 'bi bi-eye';
                this.setAttribute('aria-label', type === 'password' ? 'Show password' : 'Hide password');
            });
            
            // Toggle password for confirm password
            window.togglePassword = function(fieldId) {
                const field = document.getElementById(fieldId);
                const button = field.parentElement.querySelector('button');
                const icon = button.querySelector('i');
                
                const type = field.getAttribute('type') === 'password' ? 'text' : 'password';
                field.setAttribute('type', type);
                icon.className = type === 'password' ? 'bi bi-eye-slash' : 'bi bi-eye';
                button.setAttribute('aria-label', type === 'password' ? 'Show confirm password' : 'Hide confirm password');
            };
            
            // Real-time Password Confirmation
            confirmPassword.addEventListener('input', function() {
                const passwordMatchError = document.getElementById('passwordMatchError');
                if (this.value !== password.value && password.value !== '') {
                    this.classList.add('is-invalid');
                    passwordMatchError.style.display = 'block';
                } else {
                    this.classList.remove('is-invalid');
                    passwordMatchError.style.display = 'none';
                }
            });
            
            // Form Submission
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Remove previous validation states
                form.classList.remove('was-validated');
                form.querySelectorAll('.is-invalid').forEach(el => {
                    el.classList.remove('is-invalid');
                });
                
                // Check form validity
                if (!form.checkValidity()) {
                    e.stopPropagation();
                    form.classList.add('was-validated');
                    
                    // Focus on first invalid field
                    const firstInvalid = form.querySelector(':invalid');
                    if (firstInvalid) {
                        firstInvalid.focus();
                    }
                    return false;
                }
                
                // Check password match
                if (password.value !== confirmPassword.value) {
                    confirmPassword.classList.add('is-invalid');
                    document.getElementById('passwordMatchError').style.display = 'block';
                    confirmPassword.focus();
                    return false;
                }
                
                // Check if profile picture is selected
                if (profilePic.files.length === 0) {
                    profilePicError.textContent = 'Please select a profile picture.';
                    profilePicError.style.display = 'block';
                    profilePic.focus();
                    return false;
                }
                
                // Show loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Creating Account...';
                submitBtn.disabled = true;
                
                // Submit form
                form.submit();
                
                return true;
            });
            
            // Real-time validation on blur
            form.querySelectorAll('[required]').forEach(input => {
                input.addEventListener('blur', function() {
                    if (!this.checkValidity()) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
            });
            
            // Auto-validate on input for immediate feedback
            form.querySelectorAll('input, select').forEach(input => {
                input.addEventListener('input', function() {
                    if (this.checkValidity()) {
                        this.classList.remove('is-invalid');
                    }
                });
            });
        });
        
        // Check password strength
        function checkPasswordStrength(password) {
            let score = 0;
            let requirements = {
                length: password.length >= 8,
                lower: /[a-z]/.test(password),
                upper: /[A-Z]/.test(password),
                number: /\d/.test(password),
                special: /[^A-Za-z0-9]/.test(password)
            };
            
            // Calculate score
            if (requirements.length) score++;
            if (requirements.lower) score++;
            if (requirements.upper) score++;
            if (requirements.number) score++;
            if (requirements.special) score++;
            
            // Return width and color based on score
            let width, color;
            switch(score) {
                case 0:
                case 1:
                    width = '20%';
                    color = '#e53e3e'; // Red
                    break;
                case 2:
                    width = '40%';
                    color = '#f6ad55'; // Orange
                    break;
                case 3:
                    width = '60%';
                    color = '#68d391'; // Green
                    break;
                case 4:
                    width = '80%';
                    color = '#38a169'; // Dark Green
                    break;
                case 5:
                    width = '100%';
                    color = '#22543d'; // Very Dark Green
                    break;
                default:
                    width = '0%';
                    color = '#e2e8f0';
            }
            
            return { width: width, color: color };
        }
        
        // Reset form
        function resetForm() {
            if (confirm('Are you sure you want to reset all fields?')) {
                const form = document.getElementById('registrationForm');
                form.reset();
                
                // Reset additional elements
                document.getElementById('strengthFill').style.width = '0%';
                document.getElementById('ageIndicator').textContent = 'Age: 34 years';
                document.getElementById('birthYearRange').value = '1990';
                
                // Reset profile preview
                document.getElementById('profilePreview').innerHTML = '<i class="bi bi-person-circle"></i>';
                document.getElementById('profilePicError').style.display = 'none';
                document.getElementById('uploadProgress').style.display = 'none';
                document.getElementById('uploadProgressBar').style.width = '0%';
                
                // Clear all validation states
                form.classList.remove('was-validated');
                form.querySelectorAll('.is-invalid').forEach(el => {
                    el.classList.remove('is-invalid');
                });
                
                // Reset password visibility
                document.getElementById('password').type = 'password';
                document.getElementById('confirmPassword').type = 'password';
                document.querySelectorAll('.btn-toggle-password i').forEach(icon => {
                    icon.className = 'bi bi-eye-slash';
                });
                
                // Reset submit button
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="bi bi-person-plus"></i> Create Account';
                submitBtn.disabled = false;
                
                // Focus on first field
                form.querySelector('input[name="name"]').focus();
            }
        }
        
        // Show toast notification
        function showToast(message, type = 'info') {
            const toastContainer = document.createElement('div');
            toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
            
            const toast = document.createElement('div');
            toast.className = `toast show`;
            toast.setAttribute('role', 'alert');
            toast.setAttribute('aria-live', 'assertive');
            toast.setAttribute('aria-atomic', 'true');
            
            toast.innerHTML = `
                <div class="toast-header bg-${type} text-white">
                    <strong class="me-auto">Notification</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    ${message}
                </div>
            `;
            
            toastContainer.appendChild(toast);
            document.body.appendChild(toastContainer);
            
            // Auto-remove after 3 seconds
            setTimeout(() => {
                if (toastContainer.parentElement) {
                    toastContainer.remove();
                }
            }, 3000);
        }
    </script>
</body>
</html>