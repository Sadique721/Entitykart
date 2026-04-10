EntityKart - Complete E-Commerce Platform
<div align="center">
https://img.shields.io/badge/EntityKart-E--Commerce%2520Platform-blue?style=for-the-badge&logo=springboot&logoColor=white

A Production-Ready Full-Stack E-Commerce Application Built with Spring Boot

https://img.shields.io/badge/Java-25.0.2-orange.svg
https://img.shields.io/badge/Spring%2520Boot-4.0.2-brightgreen.svg
https://img.shields.io/badge/MySQL-9.6-blue.svg
https://img.shields.io/badge/License-MIT-yellow.svg

</div>
📋 Table of Contents
Project Overview

Key Features

Technical Architecture

Technology Stack

Project Structure

Database Schema

API Endpoints

Email Templates

Deployment

Installation Guide

Screenshots

Contributors

License

🚀 Project Overview
EntityKart is a comprehensive e-commerce platform built with Spring Boot, offering complete shopping cart functionality, order management, payment processing, and admin dashboard. The application supports multiple payment methods including Credit/Debit Cards (via Authorize.Net), COD, and UPI.

📊 Project Statistics
Metric	Value
Total Files	250+
Java Classes	45+
JSP Templates	35+
Entities	12
Repositories	13
Controllers	18
Services	4
Lines of Code	26,000+
📅 Development Timeline
Phase	Date	Milestone
Initial Setup	April 2026	Project initialization, Spring Boot configuration
Core Entities	April 2026	Created 12 JPA entities with relationships
Authentication	April 2026	Implemented login/registration with password encoding
Product Management	April 2026	CRUD operations with Cloudinary image upload
Shopping Cart	April 2026	Cart functionality with AJAX updates
Order Processing	April 2026	Complete checkout flow with stock management
Payment Integration	April 2026	Authorize.Net sandbox integration
Email System	April 2026	10+ email templates with HTML styling
Admin Dashboard	April 2026	Charts, reports, and analytics
Returns & Refunds	April 2026	Complete return management system
Reviews & Ratings	April 2026	Product review system with star ratings
Wishlist	April 2026	User wishlist functionality
Export Features	April 2026	Excel and Word report generation
Docker Deployment	April 2026	Containerization with docker-compose
Final Polish	April 2026	Bug fixes and performance optimization
✨ Key Features
👤 User Features
Feature	Description	Status
User Registration	Signup with profile picture upload	✅ Complete
Login Authentication	Secure login with password encoding	✅ Complete
Password Reset	OTP-based password recovery	✅ Complete
Profile Management	Edit profile, change password	✅ Complete
Address Management	Multiple addresses with default selection	✅ Complete
🛍️ Shopping Features
Feature	Description	Status
Product Listing	Paginated product grid with filters	✅ Complete
Product Search	Search by name/description	✅ Complete
Category Filter	Filter by category and subcategory	✅ Complete
Price Filter	Min/max price range filtering	✅ Complete
Product Details	Detailed view with multiple images	✅ Complete
Shopping Cart	Add/remove/update quantities	✅ Complete
Wishlist	Save products for later	✅ Complete
Quick View	AJAX-powered product quick view	✅ Complete
📦 Order Management
Feature	Description	Status
Checkout Process	Multi-step checkout with address selection	✅ Complete
Multiple Payments	Card, COD, UPI, Net Banking	✅ Complete
Order Tracking	Real-time order status updates	✅ Complete
Order History	View all past orders	✅ Complete
Order Cancellation	Cancel orders before shipping	✅ Complete
Order Confirmation	Email confirmation with order details	✅ Complete
🔄 Returns & Refunds
Feature	Description	Status
Return Request	Submit return request for delivered items	✅ Complete
Return Tracking	Track return status	✅ Complete
Admin Processing	Approve/reject returns	✅ Complete
Stock Restoration	Automatic stock restoration on approval	✅ Complete
Refund Processing	Mark refunds as processed	✅ Complete
Bulk Processing	Process multiple returns at once	✅ Complete
⭐ Reviews & Ratings
Feature	Description	Status
Product Reviews	Rate products 1-5 stars	✅ Complete
Review Management	Edit/delete your reviews	✅ Complete
Rating Distribution	Visual star distribution chart	✅ Complete
Admin Moderation	Delete inappropriate reviews	✅ Complete
👨‍💼 Admin Features
Feature	Description	Status
Dashboard	Analytics with interactive charts	✅ Complete
Product Management	Full CRUD with image upload	✅ Complete
Order Management	Update order status	✅ Complete
User Management	View/delete users	✅ Complete
Payment Tracking	View all transactions	✅ Complete
Return Management	Process return requests	✅ Complete
Report Export	Excel/Word report generation	✅ Complete
Email Reports	Send reports via email	✅ Complete
📧 Email System (10+ Templates)
Template	Purpose	Status
welcome-email.html	New user registration	✅ Complete
otp-email.html	Password reset OTP	✅ Complete
order-confirmation.html	Order placed confirmation	✅ Complete
order-status-update.html	Order status change notification	✅ Complete
password-reset-confirm.html	Password change confirmation	✅ Complete
return-request.html	Return request submitted	✅ Complete
return-status-update.html	Return status update	✅ Complete
review-confirmation.html	Review posted confirmation	✅ Complete
shipment-tracking.html	Shipping notification	✅ Complete
newsletter.html	Marketing newsletter	✅ Complete
🏗️ Technical Architecture
text
┌─────────────────────────────────────────────────────────────┐
│                     Client Browser                          │
│                   (HTML/CSS/JS + JSP)                       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   Spring Boot Application                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ │
│  │ Controllers │  │  Services   │  │    Repositories     │ │
│  │    (18)     │→│    (4)      │→│       (13)          │ │
│  └─────────────┘  └─────────────┘  └─────────────────────┘ │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ │
│  │   Filters   │  │  Security   │  │   Email Service     │ │
│  │   (Auth)    │  │ (BCrypt)    │  │   (JavaMail)        │ │
│  └─────────────┘  └─────────────┘  └─────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│     MySQL       │  │   Cloudinary    │  │  Authorize.Net  │
│   Database      │  │  Image Storage  │  │  Payment Gateway│
└─────────────────┘  └─────────────────┘  └─────────────────┘
🛠️ Technology Stack
Backend
Technology	Version	Purpose
Java	25.0.2	Core language
Spring Boot	4.0.2	Application framework
Spring MVC	7.0.3	Web layer
Spring Data JPA	7.0.3	Database access
Hibernate	7.2.1	ORM framework
MySQL Connector	Latest	Database driver
Security & Authentication
Technology	Purpose
BCryptPasswordEncoder	Password hashing
Session-based Auth	User session management
Custom AuthFilter	URL-based authorization
Payment Integration
Gateway	Purpose
Authorize.Net	Credit/Debit card payments (Sandbox)
Simulated Gateway	COD, UPI, Net Banking
Cloud Services
Service	Purpose
Cloudinary	Image upload and CDN
Email Service
Component	Purpose
JavaMailSender	Email delivery
Gmail SMTP	Mail server
Frontend
Technology	Purpose
JSP	View templates
JSTL	Template tags
Bootstrap 5	CSS framework
Chart.js	Dashboard charts
jQuery	AJAX requests
Font Awesome	Icons
Development Tools
Tool	Purpose
Maven	Build automation
Docker	Containerization
Git	Version control
Eclipse/IntelliJ	IDE
Dependencies (Key from pom.xml)
xml
- spring-boot-starter-web: 4.0.2
- spring-boot-starter-data-jpa: 4.0.2
- spring-boot-starter-mail: 4.0.2
- mysql-connector-j: latest
- cloudinary-http44: 1.38.0
- authorizenet: 1.9.9
- poi-ooxml: 5.2.5 (Excel export)
- dotenv-java: 3.0.0
- bcrypt: 0.9.0
📁 Project Structure
text
Entitykart/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/grownited/
│   │   │       ├── config/
│   │   │       │   ├── AppConfig.java
│   │   │       │   └── DotEnvConfig.java
│   │   │       ├── controller/
│   │   │       │   ├── AddressController.java
│   │   │       │   ├── AdminExportController.java
│   │   │       │   ├── AdminReviewApiController.java
│   │   │       │   ├── CartController.java
│   │   │       │   ├── CategoryController.java
│   │   │       │   ├── CheckoutController.java
│   │   │       │   ├── OrderController.java
│   │   │       │   ├── OrderDetailAPIController.java
│   │   │       │   ├── PaymentController.java
│   │   │       │   ├── ProductController.java
│   │   │       │   ├── ProductImageApiController.java
│   │   │       │   ├── ProductImageController.java
│   │   │       │   ├── ReturnRefundController.java
│   │   │       │   ├── ReviewController.java
│   │   │       │   ├── SessionController.java
│   │   │       │   ├── SubCategoryController.java
│   │   │       │   ├── UserController.java
│   │   │       │   └── WishlistController.java
│   │   │       ├── entity/
│   │   │       │   ├── AddressEntity.java
│   │   │       │   ├── CartEntity.java
│   │   │       │   ├── CategoryEntity.java
│   │   │       │   ├── OrderDetailEntity.java
│   │   │       │   ├── OrderEntity.java
│   │   │       │   ├── PaymentEntity.java
│   │   │       │   ├── ProductEntity.java
│   │   │       │   ├── ProductImageEntity.java
│   │   │       │   ├── ReturnRefundEntity.java
│   │   │       │   ├── ReviewRatingEntity.java
│   │   │       │   ├── SubCategoryEntity.java
│   │   │       │   ├── UserEntity.java
│   │   │       │   └── WishlistEntity.java
│   │   │       ├── repository/
│   │   │       │   ├── AddressRepository.java
│   │   │       │   ├── CartRepository.java
│   │   │       │   ├── CategoryRepository.java
│   │   │       │   ├── OrderDetailRepository.java
│   │   │       │   ├── OrderRepository.java
│   │   │       │   ├── PaymentRepository.java
│   │   │       │   ├── ProductImageRepository.java
│   │   │       │   ├── ProductRepository.java
│   │   │       │   ├── ReturnRefundRepository.java
│   │   │       │   ├── ReviewRatingRepository.java
│   │   │       │   ├── SubCategoryRepository.java
│   │   │       │   ├── UserRepository.java
│   │   │       │   └── WishlistRepository.java
│   │   │       ├── service/
│   │   │       │   ├── MailerService.java
│   │   │       │   ├── PaymentService.java
│   │   │       │   └── StockService.java
│   │   │       └── filter/
│   │   │           └── AuthFilter.java
│   │   ├── resources/
│   │   │   ├── application.properties
│   │   │   ├── application-production.properties
│   │   │   └── templates/email/
│   │   │       ├── welcome-email.html
│   │   │       ├── otp-email.html
│   │   │       ├── order-confirmation.html
│   │   │       ├── order-status-update.html
│   │   │       ├── password-reset-confirm.html
│   │   │       ├── return-request.html
│   │   │       ├── return-status-update.html
│   │   │       ├── review-confirmation.html
│   │   │       ├── shipment-tracking.html
│   │   │       └── newsletter.html
│   │   └── webapp/WEB-INF/views/
│   │       ├── adminOrders.jsp
│   │       ├── adminOrderDetails.jsp
│   │       ├── adminPayments.jsp
│   │       ├── adminPaymentDetails.jsp
│   │       ├── adminReturns.jsp
│   │       ├── adminReturnDetails.jsp
│   │       ├── adminReviews.jsp
│   │       ├── adminProducts.jsp
│   │       ├── adminAddProduct.jsp
│   │       ├── adminEditProduct.jsp
│   │       ├── adminViewProduct.jsp
│   │       ├── adminWishlistStats.jsp
│   │       ├── cart.jsp
│   │       ├── checkout.jsp
│   │       ├── dashboard.jsp
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── signup.jsp
│   │       ├── listUser.jsp
│   │       ├── viewUser.jsp
│   │       ├── editUser.jsp
│   │       ├── listAddress.jsp
│   │       ├── addAddress.jsp
│   │       ├── editAddress.jsp
│   │       ├── listCategory.jsp
│   │       ├── editCategory.jsp
│   │       ├── listSubCategory.jsp
│   │       ├── editSubCategory.jsp
│   │       ├── productList.jsp
│   │       ├── product-detail.jsp
│   │       ├── productReviews.jsp
│   │       ├── myOrders.jsp
│   │       ├── orderDetails.jsp
│   │       ├── orderConfirmation.jsp
│   │       ├── myReviews.jsp
│   │       ├── reviewForm.jsp
│   │       ├── reviewEdit.jsp
│   │       ├── myReturns.jsp
│   │       ├── returnForm.jsp
│   │       ├── wishlist.jsp
│   │       ├── paymentStatus.jsp
│   │       ├── paymentSummary.jsp
│   │       ├── fp.jsp
│   │       ├── verifyOtp.jsp
│   │       └── resetPassword.jsp
│   └── test/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── .gitignore
├── pom.xml
└── README.md
🗄️ Database Schema
Tables Structure
Table Name	Entity	Description
users	UserEntity	User authentication and profile
address	AddressEntity	User shipping addresses
categories	CategoryEntity	Product categories
subCategory	SubCategoryEntity	Product subcategories
product	ProductEntity	Product catalog
product_image	ProductImageEntity	Product gallery images
cart	CartEntity	Shopping cart items
orders	OrderEntity	Order information
order_details	OrderDetailEntity	Order line items
payment	PaymentEntity	Payment transactions
review_rating	ReviewRatingEntity	Product reviews
wishlist	WishlistEntity	User wishlist items
return_refund	ReturnRefundEntity	Return requests
Key Relationships
text
User (1) ──────< (N) Address
User (1) ──────< (N) Order
User (1) ──────< (N) Cart
User (1) ──────< (N) Wishlist
User (1) ──────< (N) Review

Category (1) ──< (N) SubCategory
Category (1) ──< (N) Product

Product (1) ───< (N) ProductImage
Product (1) ───< (N) Cart
Product (1) ───< (N) OrderDetail
Product (1) ───< (N) Review
Product (1) ───< (N) Wishlist

Order (1) ─────< (N) OrderDetail
Order (1) ─────< (1) Payment
Order (1) ─────< (1) Address

OrderDetail (1) ─< (1) ReturnRefund
🔌 API Endpoints
Public APIs (No Auth Required)
Method	Endpoint	Description
GET	/products	List all products
GET	/product/{id}	Get product details
GET	/category/{id}/subcategories	Get subcategories
GET	/api/product/{id}/rating	Get product rating
GET	/api/product/{id}/recent-reviews	Get recent reviews
GET	/api/product/{id}/images	Get product images
POST	/authenticate	Login
POST	/register	Register user
POST	/send-otp	Send OTP
POST	/verify-otp	Verify OTP
POST	/update-password	Reset password
Authenticated APIs (User)
Method	Endpoint	Description
GET	/cart	View cart
POST	/cart/update	Update cart quantity
GET	/cart/add	Add to cart
GET	/cart/remove	Remove from cart
GET	/cart/clear	Clear cart
GET	/checkout	Checkout page
POST	/order/place	Place order
GET	/orders	My orders
GET	/order/details	Order details
GET	/order/cancel	Cancel order
GET	/wishlist	View wishlist
POST	/api/wishlist/toggle	Toggle wishlist
GET	/my-reviews	My reviews
POST	/review/submit	Submit review
GET	/return/request/{id}	Request return
GET	/my-returns	My returns
Admin APIs
Method	Endpoint	Description
GET	/dashboard	Admin dashboard
GET	/admin/products	Manage products
POST	/admin/product/save	Add product
POST	/admin/product/update	Update product
GET	/admin/product/delete/{id}	Delete product
GET	/admin/orders	Manage orders
POST	/admin/order/update-status	Update order status
GET	/admin/payments	View payments
GET	/admin/returns	Manage returns
POST	/admin/return/process	Process return
GET	/admin/reviews	Manage reviews
GET	/listUser	Manage users
GET	/deleteUser	Delete user
Export APIs
Method	Endpoint	Description
GET	/admin/export/orders/excel	Export orders to Excel
GET	/admin/export/products/excel	Export products to Excel
GET	/admin/export/users/excel	Export users to Excel
GET	/admin/export/payments/excel	Export payments to Excel
GET	/admin/export/returns/excel	Export returns to Excel
GET	/admin/export/reviews/excel	Export reviews to Excel
GET	/admin/export/wishlist/excel	Export wishlist to Excel
POST	/admin/export/send-report	Email report with attachments
📧 Email Templates Preview
Welcome Email
html
- Gradient hero section with profile picture
- Account credentials card
- Security tips
- Feature grid (Free delivery, Secure payments, Easy returns)
- Call-to-action login button
Order Confirmation Email
html
- Order summary with status badge
- Items table with quantities and prices
- Price breakdown (Subtotal, Shipping, Tax, Total)
- Delivery address card
- Payment method display
- Track order button
Password Reset Confirmation
html
- Success icon animation
- Password changed confirmation
- Security notice for unauthorized changes
- Login button
