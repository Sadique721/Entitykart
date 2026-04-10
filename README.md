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
