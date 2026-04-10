<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:00C853,100:1E90FF&height=200&section=header&text=EntityKart&fontSize=40&fontColor=ffffff"/>
</p>

<h1 align="center">🛒 EntityKart – E-Commerce Platform</h1>

<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com?color=00C853&size=25&center=true&vCenter=true&width=700&height=50&lines=Full+Stack+E-Commerce+Application;Spring+Boot+%7C+JSP+%7C+MySQL;Production+Ready+Project;Developed+by+Md+Sadique+Amin" />
</p>

---

## 🚀 Badges

<p align="center">
  <img src="https://img.shields.io/github/stars/Sadique721/Entitykart?style=for-the-badge" />
  <img src="https://img.shields.io/github/forks/Sadique721/Entitykart?style=for-the-badge" />
  <img src="https://img.shields.io/github/issues/Sadique721/Entitykart?style=for-the-badge" />
  <img src="https://img.shields.io/github/license/Sadique721/Entitykart?style=for-the-badge" />
</p>

---

## 🧑‍💻 About Project

**EntityKart** is a **production-ready full-stack e-commerce web application** built using **Spring Boot, JSP, and MySQL**.

### 🔥 Key Highlights:
- 🛍️ Complete Shopping System  
- 🔐 Secure Authentication (BCrypt)  
- 💳 Payment Integration (Authorize.Net)  
- 📦 Order Management  
- 🔄 Return & Refund System  
- 📊 Admin Dashboard  

---

## 🎯 Features

### 👤 User Features
- Registration & Login  
- OTP Password Reset  
- Profile Management  
- Address Management  

### 🛒 Shopping Features
- Product Listing & Filters  
- Cart (AJAX)  
- Wishlist  

### 📦 Orders
- Checkout Process  
- Order Tracking  
- Order History  

### 🔄 Returns
- Return Requests  
- Refund Processing  

### ⭐ Reviews
- Ratings & Reviews  
- Admin Moderation  

### 👨‍💼 Admin Panel
- Dashboard Analytics  
- Product Management  
- Order Management  
- User Management  

---

## 🏗️ Architecture

```mermaid
graph TD
A[Client Browser] --> B[Spring Boot]
B --> C[Controllers]
C --> D[Services]
D --> E[Repositories]
E --> F[(MySQL Database)]
B --> G[Cloudinary]
B --> H[Authorize.Net]

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
