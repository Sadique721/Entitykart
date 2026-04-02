<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.grownited.entity.UserEntity" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    UserEntity currentUser = (UserEntity) session.getAttribute("user");
    String userInitials = "";
    String currentUserName = "Guest";
    String profilePicURL = null;
    int cartCount = 0;
    
    if (currentUser != null) {
        currentUserName = currentUser.getName();
        profilePicURL = currentUser.getProfilePicURL();
        if (currentUserName != null && currentUserName.length() > 0 && profilePicURL == null) {
            String[] names = currentUserName.split(" ");
            if (names.length >= 2) {
                userInitials = names[0].substring(0, 1) + names[1].substring(0, 1);
            } else {
                userInitials = currentUserName.substring(0, Math.min(2, currentUserName.length())).toUpperCase();
            }
        } else if (profilePicURL == null) {
            userInitials = "GU";
        }
        
        Integer sessionCartCount = (Integer) session.getAttribute("cartCount");
        if (sessionCartCount != null) {
            cartCount = sessionCartCount;
        }
    } else {
        userInitials = "GU";
    }
    
    List<CategoryEntity> categories = (List<CategoryEntity>) request.getAttribute("categoryList");
    if (categories == null) categories = new ArrayList<>();
%>

<style>
    .top-header {
        background: #2874f0;
        color: white;
        padding: 8px 0;
        font-size: 13px;
    }
    
    .top-header a {
        color: white;
        text-decoration: none;
        margin-right: 20px;
    }
    
    .top-header a:hover {
        text-decoration: underline;
    }
    
    .main-header {
        background: #2874f0;
        padding: 12px 0;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .logo {
        color: white;
        font-size: 24px;
        font-weight: 700;
        text-decoration: none;
        display: flex;
        align-items: center;
    }
    
    .logo span {
        font-size: 12px;
        margin-left: 5px;
        font-style: italic;
        color: #ffe500;
    }
    
    .search-box {
        display: flex;
        background: white;
        border-radius: 4px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .search-box input {
        flex: 1;
        border: none;
        padding: 12px 15px;
        font-size: 14px;
        outline: none;
    }
    
    .search-box button {
        background: none;
        border: none;
        padding: 0 20px;
        color: #2874f0;
        cursor: pointer;
        font-size: 18px;
    }
    
    .nav-icons {
        display: flex;
        align-items: center;
        gap: 25px;
    }
    
    .nav-icon-item {
        color: white;
        text-decoration: none;
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 12px;
        position: relative;
    }
    
    .nav-icon-item i {
        font-size: 20px;
        margin-bottom: 2px;
    }
    
    .nav-icon-item:hover {
        color: #ffe500;
    }
    
    .cart-count {
        position: absolute;
        top: -8px;
        right: -8px;
        background: #fb641b;
        color: white;
        border-radius: 50%;
        width: 18px;
        height: 18px;
        font-size: 11px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
    }
    
    .user-profile {
        position: relative;
    }
    
    .user-avatar {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background-color: white;
        color: #2874f0;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        cursor: pointer;
        overflow: hidden;
        border: 2px solid white;
    }
    
    .user-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .user-dropdown {
        position: absolute;
        top: 45px;
        right: 0;
        background: white;
        border-radius: 4px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        min-width: 200px;
        display: none;
        z-index: 1001;
    }
    
    .user-dropdown.show {
        display: block;
    }
    
    .user-dropdown a {
        display: block;
        padding: 12px 15px;
        color: #212121;
        text-decoration: none;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .user-dropdown a:hover {
        background: #f5f5f5;
    }
    
    .user-dropdown a i {
        width: 20px;
        margin-right: 10px;
        color: #2874f0;
    }
    
    .category-menu {
        background: white;
        border-bottom: 1px solid #e0e0e0;
        padding: 10px 0;
    }
    
    .category-list {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        justify-content: space-around;
        overflow-x: auto;
        white-space: nowrap;
    }
    
    .category-link {
        color: #878787;
        text-decoration: none;
        font-weight: 500;
        font-size: 14px;
        padding: 8px 15px;
        display: block;
        border-bottom: 3px solid transparent;
    }
    
    .category-link:hover {
        color: #2874f0;
        border-bottom-color: #2874f0;
    }
</style>

<!-- Top Header -->
<div class="top-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <a href="#"><i class="fas fa-phone-alt me-1"></i> Download App</a>
                <a href="#"><i class="fas fa-tag me-1"></i> Offers</a>
            </div>
            <div>
                <% if (currentUser != null) { %>
                    <span class="me-3">
                        <i class="fas fa-user me-1"></i> 
                        Welcome, <%= currentUserName %>
                    </span>
                    <a href="/logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                <% } else { %>
                    <a href="/login"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                    <a href="/signup"><i class="fas fa-user-plus me-1"></i> Sign Up</a>
                <% } %>
                <a href="#"><i class="fas fa-headset me-1"></i> 24/7 Support</a>
            </div>
        </div>
    </div>
</div>

<!-- Main Header -->
<header class="main-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-2">
                <a href="/" class="logo">
                    <i class="fas fa-shopping-bag me-2"></i>
                    EntityKart
                    <span>Plus</span>
                </a>
            </div>
            <div class="col-md-6">
                <form action="/products" method="get" class="search-box">
                    <input type="text" name="q" placeholder="Search for products, brands and more..." 
                           value="${param.q}" autocomplete="off">
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
            <div class="col-md-4">
                <div class="nav-icons justify-content-end">
                    <a href="/wishlist" class="nav-icon-item">
                        <i class="far fa-heart"></i>
                        <span>Wishlist</span>
                        <span class="cart-count" id="wishlistCount" style="display: none;">0</span>
                    </a>
                    <a href="/cart" class="nav-icon-item">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Cart</span>
                        <span class="cart-count" id="cartCount"><%= cartCount %></span>
                    </a>
                    <a href="/orders" class="nav-icon-item">
                        <i class="fas fa-box"></i>
                        <span>Orders</span>
                    </a>
                    <% if (currentUser != null && "ADMIN".equals(currentUser.getRole())) { %>
                        <a href="/dashboard" class="nav-icon-item">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Admin</span>
                        </a>
                    <% } %>
                    
                    <!-- User Profile Dropdown -->
                    <div class="user-profile">
                        <div class="user-avatar" id="userAvatar">
                            <% if (currentUser != null && profilePicURL != null && !profilePicURL.isEmpty()) { %>
                                <img src="<%= profilePicURL %>" alt="<%= currentUserName %>">
                            <% } else { %>
                                <%= userInitials %>
                            <% } %>
                        </div>
                        <% if (currentUser != null) { %>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="/profile"><i class="fas fa-user"></i> My Profile</a>
                                <a href="/orders"><i class="fas fa-box"></i> My Orders</a>
                                <a href="/wishlist"><i class="fas fa-heart"></i> Wishlist</a>
                                <a href="/cart"><i class="fas fa-shopping-cart"></i> Cart</a>
                                <a href="/address"><i class="fas fa-map-marker-alt"></i> Addresses</a>
                                <a href="/my-reviews"><i class="fas fa-star"></i> My Reviews</a>
                                <a href="/logout" style="color: #f44336;"><i class="fas fa-sign-out-alt"></i> Logout</a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Category Menu -->
<div class="category-menu">
    <div class="container">
        <ul class="category-list">
            <% int catCount = 0; for (CategoryEntity category : categories) { 
                if (catCount++ >= 8) break; %>
                <li class="category-item">
                    <a href="/products?category=<%= category.getCategoryId() %>" class="category-link">
                        <%= category.getCategoryName() %>
                    </a>
                </li>
            <% } %>
            <li class="category-item">
                <a href="/products" class="category-link">
                    <i class="fas fa-chevron-right"></i> More
                </a>
            </li>
        </ul>
    </div>
</div>

<script>
    // User dropdown toggle
    document.getElementById('userAvatar')?.addEventListener('click', function(e) {
        e.stopPropagation();
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');
        }
    });
    
    document.addEventListener('click', function() {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) {
            dropdown.classList.remove('show');
        }
    });
</script>