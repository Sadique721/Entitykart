<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.grownited.entity.*" %>
<%@ page import="com.grownited.entity.UserEntity" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>
<%@ page import="com.grownited.entity.ProductEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EntityKart - India's Largest Online Marketplace</title>
    <!-- PWA Manifest -->
	<link rel="manifest" href="${pageContext.request.contextPath}/manifest.json">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Slick Carousel -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Owl Carousel -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    
    <style>
        /* All your existing styles remain exactly the same */
        :root {
            --primary-blue: #2874f0;
            --primary-orange: #fb641b;
            --light-gray: #f1f3f6;
            --dark-gray: #878787;
            --white: #ffffff;
            --success-green: #26a541;
            --yellow: #ff9f00;
            --pink: #ff3f6c;
            --border-color: #e0e0e0;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: var(--light-gray);
            color: #212121;
            line-height: 1.6;
        }
        
        /* Header Styles */
        .top-header {
            background: var(--primary-blue);
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
            background: var(--primary-blue);
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
        
        .search-box select {
            border: none;
            padding: 10px;
            background: #f5f5f5;
            font-size: 14px;
            outline: none;
            cursor: pointer;
            border-right: 1px solid #ddd;
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
            color: var(--primary-blue);
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
            background: var(--primary-orange);
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
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            overflow: hidden;
            border: 2px solid white;
            transition: transform 0.2s;
        }
        
        .user-avatar:hover {
            transform: scale(1.1);
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
            transition: background 0.2s;
        }
        
        .user-dropdown a:hover {
            background: #f5f5f5;
        }
        
        .user-dropdown a i {
            width: 20px;
            margin-right: 10px;
            color: var(--primary-blue);
        }
        
        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }
        
        /* Category Menu */
        .category-menu {
            background: white;
            border-bottom: 1px solid var(--border-color);
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
            -webkit-overflow-scrolling: touch;
            scrollbar-width: thin;
        }
        
        .category-list::-webkit-scrollbar {
            height: 3px;
        }
        
        .category-list::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 3px;
        }
        
        .category-item {
            position: relative;
        }
        
        .category-link {
            color: var(--dark-gray);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            padding: 8px 15px;
            display: block;
            transition: color 0.3s;
            border-bottom: 3px solid transparent;
        }
        
        .category-link:hover, .category-item.active .category-link {
            color: var(--primary-blue);
            border-bottom-color: var(--primary-blue);
        }
        
        .subcategory-dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            background: white;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            border-radius: 4px;
            display: none;
            z-index: 100;
            padding: 10px 0;
        }
        
        .category-item:hover .subcategory-dropdown {
            display: block;
        }
        
        .subcategory-link {
            color: var(--dark-gray);
            text-decoration: none;
            display: block;
            padding: 8px 20px;
            font-size: 13px;
        }
        
        .subcategory-link:hover {
            background: #f5f5f5;
            color: var(--primary-blue);
        }
        
        /* Hero Slider */
        .hero-slider {
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .slick-slide {
            margin: 0 10px;
        }
        
        .slick-list {
            margin: 0 -10px;
        }
        
        .hero-slide {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }
        
        .hero-slide img {
            width: 100%;
            height: 350px;
            object-fit: cover;
            transition: transform 0.3s;
        }
        
        .hero-slide:hover img {
            transform: scale(1.05);
        }
        
        /* Stats Banner */
        .stats-banner {
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .stat-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .stat-count {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-blue);
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: var(--dark-gray);
            font-size: 14px;
        }
        
        /* Categories Grid */
        .categories-grid {
            max-width: 1400px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 25px;
            color: #212121;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light-gray);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .section-title a {
            font-size: 14px;
            color: var(--primary-blue);
            text-decoration: none;
        }
        
        .categories-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 20px;
        }
        
        .category-card {
            text-align: center;
            padding: 15px 5px;
            border-radius: 8px;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: #212121;
            border: 1px solid transparent;
        }
        
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background: #f8f9fa;
            border-color: var(--border-color);
        }
        
        .category-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 10px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--light-gray);
            font-size: 24px;
            color: var(--primary-blue);
        }
        
        .category-name {
            font-size: 14px;
            font-weight: 500;
            margin-top: 8px;
            line-height: 1.3;
        }
        
        /* Deals Section */
        .deal-section {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .deal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .deal-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .deal-header h3 i {
            color: var(--pink);
        }
        
        .timer {
            background: #f5f5f5;
            padding: 8px 15px;
            border-radius: 20px;
            color: var(--primary-orange);
            font-weight: 600;
        }
        
        .timer i {
            margin-right: 5px;
        }
        
        .deal-products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        
        /* Product Cards */
        .product-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            border: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        
        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--yellow);
            color: var(--dark-gray);
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            z-index: 1;
        }
        
        .product-badge.hot {
            background: var(--pink);
            color: white;
        }
        
        .product-badge.new {
            background: var(--success-green);
            color: white;
        }
        
        .wishlist-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 35px;
            height: 35px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            z-index: 10;
            border: none;
            color: #dc3545;
            font-size: 18px;
        }
        
        .wishlist-btn i {
            color: #999;
            font-size: 18px;
        }
        
        .wishlist-btn.active i {
            color: #dc3545;
            font-weight: 900;
        }
        
        .wishlist-btn:hover {
            transform: scale(1.1);
            background: #fff5f5;
        }
        
        .product-image-container {
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: #f5f5f5;
            position: relative;
        }
        
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.05);
        }
        
        .product-details {
            padding: 15px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            line-height: 1.4;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            color: #212121;
            text-decoration: none;
        }
        
        .product-title:hover {
            color: var(--primary-blue);
        }
        
        .product-brand {
            color: #666;
            font-size: 13px;
            margin-bottom: 8px;
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 8px;
        }
        
        .rating-stars {
            color: var(--yellow);
            font-size: 12px;
        }
        
        .rating-count {
            color: var(--dark-gray);
            font-size: 11px;
        }
        
        .product-price {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            flex-wrap: wrap;
        }
        
        .current-price {
            font-size: 18px;
            font-weight: 600;
            color: #212121;
        }
        
        .original-price {
            font-size: 14px;
            color: #999;
            text-decoration: line-through;
        }
        
        .discount {
            color: var(--success-green);
            font-weight: 600;
            font-size: 12px;
            background: #e8f5e8;
            padding: 2px 6px;
            border-radius: 3px;
        }
        
        .stock-info {
            margin-bottom: 10px;
            font-size: 12px;
        }
        
        .in-stock {
            color: var(--success-green);
        }
        
        .low-stock {
            color: var(--primary-orange);
        }
        
        .out-of-stock {
            color: #f44336;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: auto;
        }
        
        .add-to-cart-btn, .add-to-cart {
            flex: 1;
            padding: 10px;
            background: var(--primary-orange);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.3s;
            font-size: 13px;
        }
        
        .add-to-cart-btn:hover:not(:disabled),
        .add-to-cart:hover:not(:disabled) {
            background: #e55a17;
        }
        
        .add-to-cart-btn:disabled,
        .add-to-cart:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .buy-now {
            flex: 1;
            padding: 10px;
            background: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.3s;
            font-size: 13px;
        }
        
        .buy-now:hover:not(:disabled) {
            background: #1e5fd8;
        }
        
        .buy-now:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        /* Sorting Section */
        .sorting-section {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .sorting-label {
            font-weight: 600;
            color: var(--dark-gray);
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .sorting-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .sort-btn {
            padding: 8px 16px;
            border: 1px solid var(--border-color);
            background: white;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            color: #666;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .sort-btn:hover {
            border-color: var(--primary-blue);
            color: var(--primary-blue);
            background: #f0f7ff;
        }
        
        .sort-btn.active {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }
        
        .sort-btn i {
            font-size: 12px;
        }
        
        /* Products Section */
        .products-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .filter-controls {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .filter-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            outline: none;
            cursor: pointer;
        }
        
        .filter-select:focus {
            border-color: var(--primary-blue);
        }
        
        .product-count {
            background: var(--primary-blue);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
        }
        
        /* Brands Section */
        .brands-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 20px;
        }
        
        .brand-card {
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            background: white;
        }
        
        .brand-card:hover {
            border-color: var(--primary-blue);
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .brand-logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .brand-name {
            font-size: 14px;
            font-weight: 500;
            color: #212121;
        }
        
        /* Services Section */
        .services-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }
        
        .service-card {
            text-align: center;
            padding: 20px;
        }
        
        .service-icon {
            width: 70px;
            height: 70px;
            background: var(--light-gray);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: var(--primary-blue);
            font-size: 28px;
            transition: all 0.3s;
        }
        
        .service-card:hover .service-icon {
            background: var(--primary-blue);
            color: white;
            transform: rotateY(180deg);
        }
        
        .service-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #212121;
        }
        
        .service-desc {
            font-size: 13px;
            color: var(--dark-gray);
            line-height: 1.5;
        }
        
        /* Banner Section */
        .banner-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .banner-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .banner-item {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            cursor: pointer;
        }
        
        .banner-item:hover {
            transform: scale(1.02);
        }
        
        .banner-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        /* Newsletter Section */
        .newsletter-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 50px;
            background: linear-gradient(135deg, var(--primary-blue), #1e5fd8);
            border-radius: 8px;
            text-align: center;
            color: white;
        }
        
        .newsletter-title {
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .newsletter-desc {
            font-size: 16px;
            margin-bottom: 25px;
            opacity: 0.9;
        }
        
        .newsletter-form {
            max-width: 500px;
            margin: 0 auto;
            display: flex;
            gap: 10px;
        }
        
        .newsletter-input {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            outline: none;
        }
        
        .newsletter-btn {
            padding: 15px 30px;
            background: var(--primary-orange);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .newsletter-btn:hover {
            background: #e55a17;
        }
        
        /* Footer */
        .footer {
            background: #172337;
            color: white;
            margin-top: 50px;
        }
        
        .footer-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px 20px;
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .footer-column h3 {
            font-size: 12px;
            color: #878787;
            text-transform: uppercase;
            margin-bottom: 20px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .footer-column ul {
            list-style: none;
            padding: 0;
        }
        
        .footer-column ul li {
            margin-bottom: 12px;
        }
        
        .footer-column ul li a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .footer-column ul li a:hover {
            color: var(--yellow);
        }
        
        .footer-bottom {
            border-top: 1px solid #2d3e50;
            padding-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .copyright {
            color: #878787;
            font-size: 13px;
        }
        
        .footer-links {
            display: flex;
            gap: 20px;
        }
        
        .footer-links a {
            color: white;
            text-decoration: none;
            font-size: 13px;
        }
        
        .social-icons {
            display: flex;
            gap: 15px;
        }
        
        .social-icons a {
            color: white;
            font-size: 18px;
            transition: color 0.3s;
        }
        
        .social-icons a:hover {
            color: var(--yellow);
        }
        
        /* Quick View Modal */
        .quick-view-modal .modal-dialog {
            max-width: 800px;
        }
        
        .quick-view-main-image {
            width: 100%;
            height: 300px;
            object-fit: contain;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
        }
        
        .quick-view-thumbnails {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            padding: 5px;
        }
        
        .quick-view-thumbnail {
            width: 60px;
            height: 60px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 4px;
        }
        
        .quick-view-thumbnail:hover,
        .quick-view-thumbnail.active {
            border-color: var(--primary-blue);
        }
        
        /* Search Suggestions */
        .search-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            z-index: 1000;
            max-height: 400px;
            overflow-y: auto;
        }
        
        .suggestion-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .suggestion-item:hover {
            background: #f5f5f5;
        }
        
        .suggestion-img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .suggestion-info {
            flex: 1;
        }
        
        .suggestion-name {
            font-size: 14px;
            color: #333;
        }
        
        .suggestion-price {
            font-size: 12px;
            color: var(--primary-blue);
            font-weight: 600;
        }
        
        /* Compare Bar */
        .compare-bar {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            border-radius: 50px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 20px;
            z-index: 999;
            display: none;
        }
        
        /* Loading & Toasts */
        .loading-spinner, .spinner-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        
        .spinner, .spinner-border {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-blue);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast-notification {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            padding: 16px 24px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideInRight 0.3s ease;
            max-width: 350px;
        }
        
        .toast-notification.success {
            border-left: 4px solid var(--success-green);
        }
        
        .toast-notification.error {
            border-left: 4px solid #f44336;
        }
        
        .toast-notification.info {
            border-left: 4px solid var(--primary-blue);
        }
        
        .toast-icon {
            font-size: 20px;
        }
        
        .toast-notification.success .toast-icon {
            color: var(--success-green);
        }
        
        .toast-notification.error .toast-icon {
            color: #f44336;
        }
        
        .toast-notification.info .toast-icon {
            color: var(--primary-blue);
        }
        
        .toast-content {
            flex: 1;
        }
        
        .toast-title {
            font-weight: 600;
            margin-bottom: 4px;
        }
        
        .toast-message {
            font-size: 14px;
            color: var(--dark-gray);
        }
        
        .toast-close {
            cursor: pointer;
            color: var(--dark-gray);
            font-size: 18px;
        }
        
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
        
        @keyframes fa-bounce {
            0%, 100% { transform: translateY(0); }
            25% { transform: translateY(-5px); }
            50% { transform: translateY(0); }
            75% { transform: translateY(-3px); }
        }
        
        .fa-bounce {
            animation: fa-bounce 1s ease;
        }
        
        /* Back to Top */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: var(--primary-blue);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
            z-index: 999;
            box-shadow: 0 4px 12px rgba(40, 116, 240, 0.3);
        }
        
        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
        }
        
        .back-to-top:hover {
            background: #1e5fd8;
            transform: translateY(-3px);
        }
        
        /* Responsive */
        @media (max-width: 1200px) {
            .deal-products {
                grid-template-columns: repeat(4, 1fr);
            }
            .categories-row {
                grid-template-columns: repeat(5, 1fr);
            }
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 992px) {
            .deal-products {
                grid-template-columns: repeat(3, 1fr);
            }
            .search-box select {
                display: none;
            }
            .categories-row {
                grid-template-columns: repeat(4, 1fr);
            }
            .products-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .banner-grid {
                grid-template-columns: 1fr;
            }
            .newsletter-form {
                flex-direction: column;
            }
        }
        
        @media (max-width: 768px) {
            .deal-products {
                grid-template-columns: repeat(2, 1fr);
            }
            .nav-icons {
                gap: 15px;
            }
            .category-list {
                overflow-x: auto;
                padding: 10px;
            }
            .category-item {
                flex-shrink: 0;
            }
            .categories-row {
                grid-template-columns: repeat(3, 1fr);
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .services-grid {
                grid-template-columns: 1fr;
            }
            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }
            .footer-links {
                justify-content: center;
            }
            
            .mobile-menu-btn {
                display: block;
            }
            .search-container {
                order: 3;
                flex: 1 0 100%;
                margin: 10px 0 0;
            }
            .user-actions {
                display: none;
            }
            .user-actions.active {
                display: flex;
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: var(--primary-blue);
                padding: 15px;
                justify-content: space-around;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                z-index: 1000;
            }
            .back-to-top {
                bottom: 20px;
                right: 20px;
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
        }
        
        @media (max-width: 576px) {
            .deal-products {
                grid-template-columns: 1fr;
            }
            .logo {
                font-size: 18px;
            }
            .nav-icon-item span {
                display: none;
            }
            .categories-row {
                grid-template-columns: repeat(2, 1fr);
            }
            .products-grid {
                grid-template-columns: 1fr;
            }
            .brands-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .hero-slide img {
                height: 180px;
            }
            .newsletter-section {
                padding: 30px 20px;
            }
            .newsletter-title {
                font-size: 20px;
            }
            .button-group {
                flex-direction: column;
            }
            .filter-controls {
                width: 100%;
            }
            .filter-select {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<%
    // Get session attributes
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
    
    // Get data from request attributes
    List<UserEntity> allUsers = (List<UserEntity>) request.getAttribute("users");
    List<CategoryEntity> categories = (List<CategoryEntity>) request.getAttribute("categoryList");
    List<ProductEntity> products = (List<ProductEntity>) request.getAttribute("productList");
    List<ProductEntity> featuredProducts = (List<ProductEntity>) request.getAttribute("featuredProducts");
    List<ProductEntity> dealProducts = (List<ProductEntity>) request.getAttribute("dealProducts");
    List<ProductEntity> recentlyViewed = (List<ProductEntity>) request.getAttribute("recentlyViewed");
    List<Integer> wishlistedIds = (List<Integer>) request.getAttribute("wishlistedIds");
    
    // Debug
    System.out.println("JSP Loaded - Categories: " + (categories != null ? categories.size() : 0));
    System.out.println("JSP Loaded - Products: " + (products != null ? products.size() : 0));
    
    // Calculate stats
    int totalProducts = products != null ? products.size() : 0;
    int happyCustomers = allUsers != null ? allUsers.size() : 0;
    
    // Default values for null collections
    if (categories == null) categories = new ArrayList<>();
    if (products == null) products = new ArrayList<>();
    if (featuredProducts == null) featuredProducts = new ArrayList<>();
    if (dealProducts == null) dealProducts = new ArrayList<>();
    if (recentlyViewed == null) recentlyViewed = new ArrayList<>();
    if (wishlistedIds == null) wishlistedIds = new ArrayList<>();
%>

<!-- Loading Spinner -->
<div class="loading-spinner" id="loadingSpinner">
    <div class="spinner"></div>
</div>

<!-- Toast Notifications -->
<div class="toast-container" id="toastContainer"></div>

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
                    <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                    <a href="${pageContext.request.contextPath}/signup"><i class="fas fa-user-plus me-1"></i> Sign Up</a>
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
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <i class="fas fa-shopping-bag me-2"></i>
                    EntityKart
                    <span>Plus</span>
                </a>
            </div>
            <div class="col-md-6">
                <div class="search-box">
                    <select id="searchCategory">
                        <option value="">All Categories</option>
                        <% for (CategoryEntity cat : categories) { %>
                            <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
                        <% } %>
                    </select>
                    <input type="text" id="searchInput" placeholder="Search for products, brands and more..." 
                           value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>" 
                           autocomplete="off">
                    <button type="button" onclick="performSearch()">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="nav-icons justify-content-end">
                    <a href="${pageContext.request.contextPath}/wishlist" class="nav-icon-item">
                        <i class="far fa-heart"></i>
                        <span>Wishlist</span>
                        <span class="cart-count" id="wishlistCount" style="display: none;">0</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/cart" class="nav-icon-item">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Cart</span>
                        <span class="cart-count" id="cartCount"><%= cartCount %></span>
                    </a>
                    <a href="${pageContext.request.contextPath}/orders" class="nav-icon-item">
                        <i class="fas fa-box"></i>
                        <span>Orders</span>
                    </a>
                    <% if (currentUser != null && "ADMIN".equals(currentUser.getRole())) { %>
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-icon-item">
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
                                <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> My Profile</a>
                                <a href="${pageContext.request.contextPath}/orders"><i class="fas fa-box"></i> My Orders</a>
                                <a href="${pageContext.request.contextPath}/wishlist"><i class="fas fa-heart"></i> Wishlist</a>
                                <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Cart</a>
                                <a href="${pageContext.request.contextPath}/listAddress"><i class="fas fa-map-marker-alt"></i> Addresses</a>
                                <a href="${pageContext.request.contextPath}/my-reviews"><i class="fas fa-star"></i> My Reviews</a>
                                <a href="${pageContext.request.contextPath}/logout" style="color: #f44336;"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
                    <a href="${pageContext.request.contextPath}/products?category=<%= category.getCategoryId() %>" class="category-link">
                        <%= category.getCategoryName() %>
                    </a>
                    <div class="subcategory-dropdown">
                        <a href="${pageContext.request.contextPath}/products?category=<%= category.getCategoryId() %>" class="subcategory-link">
                            View All <%= category.getCategoryName() %>
                        </a>
                    </div>
                </li>
            <% } %>
            <li class="category-item">
                <a href="${pageContext.request.contextPath}/products" class="category-link">
                    <i class="fas fa-chevron-right"></i> More
                </a>
            </li>
        </ul>
    </div>
</div>

<!-- Hero Slider -->
<div class="hero-slider">
    <div class="slick-slider">
        <div class="hero-slide" onclick="window.location.href='${pageContext.request.contextPath}/products?category=electronics'">
            <img src="https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
                 alt="Electronics Sale" loading="lazy">
        </div>
        <div class="hero-slide" onclick="window.location.href='${pageContext.request.contextPath}/products?category=fashion'">
            <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
                 alt="Fashion Collection" loading="lazy">
        </div>
        <div class="hero-slide" onclick="window.location.href='${pageContext.request.contextPath}/products?category=home'">
            <img src="https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
                 alt="Home Essentials" loading="lazy">
        </div>
        <div class="hero-slide" onclick="window.location.href='${pageContext.request.contextPath}/products?category=mobile'">
            <img src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
                 alt="Mobile Phones" loading="lazy">
        </div>
    </div>
</div>

<!-- Quick Stats Banner -->
<section class="stats-banner">
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="color: #2874f0;">
                <i class="fas fa-box-open"></i>
            </div>
            <div class="stat-count"><fmt:formatNumber value="<%= totalProducts %>" type="number" groupingUsed="true" /></div>
            <div class="stat-label">Products</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="color: #26a541;">
                <i class="fas fa-smile"></i>
            </div>
            <div class="stat-count"><fmt:formatNumber value="<%= happyCustomers %>" type="number" groupingUsed="true" />+</div>
            <div class="stat-label">Happy Customers</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="color: #fb641b;">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <div class="stat-count">500+</div>
            <div class="stat-label">Cities Served</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="color: #ff9f00;">
                <i class="fas fa-store"></i>
            </div>
            <div class="stat-count">25K+</div>
            <div class="stat-label">Verified Sellers</div>
        </div>
    </div>
</section>

<!-- Categories Grid -->
<section class="categories-grid">
    <div class="section-title">
        <span>Shop by Categories</span>
        <a href="${pageContext.request.contextPath}/products">View All <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="categories-row">
        <% int gridCount = 0; for (CategoryEntity category : categories) { 
            if (gridCount++ >= 10) break; %>
            <a href="${pageContext.request.contextPath}/products?category=<%= category.getCategoryId() %>" class="category-card">
                <div class="category-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <div class="category-name"><%= category.getCategoryName() %></div>
            </a>
        <% } %>
    </div>
</section>

<!-- Deal of the Day Section -->
<% if (!dealProducts.isEmpty()) { %>
    <div class="container">
        <div class="deal-section" data-aos="fade-up">
            <div class="deal-header">
                <h3><i class="fas fa-bolt"></i> Deal of the Day</h3>
                <div class="timer" id="dealTimer">
                    <i class="far fa-clock"></i>
                    <span id="hours">00</span>:<span id="minutes">00</span>:<span id="seconds">00</span>
                </div>
            </div>
            <div class="deal-products">
                <% for (ProductEntity product : dealProducts) { 
                    int discountPercent = 0;
                    if (product.getMrp() != null && product.getMrp() > 0 && 
                        product.getPrice() != null && product.getPrice() > 0 && 
                        product.getMrp() > product.getPrice()) {
                        discountPercent = (int) Math.round(((product.getMrp() - product.getPrice()) / (double)product.getMrp()) * 100);
                    }
                    
                    boolean inStock = product.getStockQuantity() != null && product.getStockQuantity() > 0;
                    boolean inWishlist = wishlistedIds.contains(product.getProductId());
                    
                    String productImageUrl = product.getMainImageURL() != null && !product.getMainImageURL().isEmpty() 
                                            ? product.getMainImageURL() 
                                            : "https://via.placeholder.com/200";
                %>
                <div class="product-card" onclick="viewProduct(<%= product.getProductId() %>)">
                    <span class="product-badge hot">HOT</span>
                    <button class="wishlist-btn <%= inWishlist ? "active" : "" %>" 
                            onclick="event.stopPropagation(); toggleWishlist(<%= product.getProductId() %>, this)">
                        <i class="fa<%= inWishlist ? "s" : "r" %> fa-heart"></i>
                    </button>
                    <div class="product-image-container">
                        <img src="<%= productImageUrl %>" class="product-image" alt="<%= product.getProductName() %>">
                    </div>
                    <div class="product-details">
                        <h6 class="product-title"><%= product.getProductName() %></h6>
                        <p class="product-brand"><%= product.getBrand() != null ? product.getBrand() : "EntityKart" %></p>
                        <div class="product-price">
                            <span class="current-price">₹<fmt:formatNumber value="<%= product.getPrice() %>" pattern="#,##0"/></span>
                            <% if (product.getMrp() != null && product.getMrp() > product.getPrice()) { %>
                                <span class="original-price">₹<fmt:formatNumber value="<%= product.getMrp() %>" pattern="#,##0"/></span>
                                <span class="discount"><%= discountPercent %>% off</span>
                            <% } %>
                        </div>
                        <div class="stock-info">
                            <% if (inStock) { %>
                                <span class="in-stock"><i class="fas fa-check-circle"></i> In Stock</span>
                            <% } else { %>
                                <span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                            <% } %>
                        </div>
                        <button class="add-to-cart-btn" onclick="event.stopPropagation(); addToCart(<%= product.getProductId() %>)"
                                <%= !inStock ? "disabled" : "" %>>
                            <i class="fas fa-cart-plus me-2"></i>
                            <%= inStock ? "Add to Cart" : "Out of Stock" %>
                        </button>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<% } %>

<!-- Featured Products with Sorting -->
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 data-aos="fade-right">
            <i class="fas fa-crown me-2 text-warning"></i>Featured Products
        </h3>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary" data-aos="fade-left">
            View All <i class="fas fa-arrow-right ms-2"></i>
        </a>
    </div>
    
    <!-- Sorting Section -->
    <div class="sorting-section" data-aos="fade-up">
        <span class="sorting-label">
            <i class="fas fa-sort-amount-down-alt"></i> Sort By:
        </span>
        <div class="sorting-buttons">
            <a href="${pageContext.request.contextPath}/?sort=default" class="sort-btn ${param.sort == 'default' or empty param.sort ? 'active' : ''}">
                <i class="fas fa-star"></i> Featured
            </a>
            <a href="${pageContext.request.contextPath}/?sort=newest" class="sort-btn ${param.sort == 'newest' ? 'active' : ''}">
                <i class="fas fa-clock"></i> Newest
            </a>
            <a href="${pageContext.request.contextPath}/?sort=popular" class="sort-btn ${param.sort == 'popular' ? 'active' : ''}">
                <i class="fas fa-fire"></i> Popular
            </a>
            <a href="${pageContext.request.contextPath}/?sort=name_asc" class="sort-btn ${param.sort == 'name_asc' ? 'active' : ''}">
                <i class="fas fa-sort-alpha-down"></i> Name: A to Z
            </a>
            <a href="${pageContext.request.contextPath}/?sort=name_desc" class="sort-btn ${param.sort == 'name_desc' ? 'active' : ''}">
                <i class="fas fa-sort-alpha-up"></i> Name: Z to A
            </a>
            <a href="${pageContext.request.contextPath}/?sort=price_low" class="sort-btn ${param.sort == 'price_low' ? 'active' : ''}">
                <i class="fas fa-sort-amount-down"></i> Price: Low to High
            </a>
            <a href="${pageContext.request.contextPath}/?sort=price_high" class="sort-btn ${param.sort == 'price_high' ? 'active' : ''}">
                <i class="fas fa-sort-amount-up"></i> Price: High to Low
            </a>
        </div>
    </div>
    
    <div class="row">
        <% int featuredCount = 0; 
           // Apply sorting based on parameter
           List<ProductEntity> sortedFeatured = new ArrayList<>(featuredProducts);
           String sortParam = request.getParameter("sort");
           
           if (sortParam != null) {
               if ("name_asc".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> 
                       a.getProductName().compareToIgnoreCase(b.getProductName()));
               } else if ("name_desc".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> 
                       b.getProductName().compareToIgnoreCase(a.getProductName()));
               } else if ("price_low".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> 
                       Float.compare(a.getPrice() != null ? a.getPrice() : 0, 
                                    b.getPrice() != null ? b.getPrice() : 0));
               } else if ("price_high".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> 
                       Float.compare(b.getPrice() != null ? b.getPrice() : 0, 
                                    a.getPrice() != null ? a.getPrice() : 0));
               } else if ("newest".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> {
                       if (a.getCreatedAt() == null && b.getCreatedAt() == null) return 0;
                       if (a.getCreatedAt() == null) return 1;
                       if (b.getCreatedAt() == null) return -1;
                       return b.getCreatedAt().compareTo(a.getCreatedAt());
                   });
               } else if ("popular".equals(sortParam)) {
                   Collections.sort(sortedFeatured, (a, b) -> 
                       Integer.compare(b.getStockQuantity() != null ? b.getStockQuantity() : 0, 
                                      a.getStockQuantity() != null ? a.getStockQuantity() : 0));
               }
           }
           
           for (ProductEntity product : sortedFeatured) { 
            if (featuredCount++ >= 8) break;
            boolean inWishlist = wishlistedIds.contains(product.getProductId());
            boolean inStock = product.getStockQuantity() != null && product.getStockQuantity() > 0;
            
            int discountPercent = 0;
            if (product.getMrp() != null && product.getMrp() > 0 && 
                product.getPrice() != null && product.getPrice() > 0 && 
                product.getMrp() > product.getPrice()) {
                discountPercent = (int) Math.round(((product.getMrp() - product.getPrice()) / (double)product.getMrp()) * 100);
            }
            
            String productImageUrl = product.getMainImageURL() != null && !product.getMainImageURL().isEmpty() 
                                    ? product.getMainImageURL() 
                                    : "https://via.placeholder.com/200";
        %>
        <div class="col-lg-3 col-md-4 col-6 mb-4" data-aos="fade-up" data-aos-delay="<%= featuredCount * 50 %>">
            <div class="product-card" onclick="viewProduct(<%= product.getProductId() %>)">
                <% if (discountPercent > 20) { %>
                    <span class="product-badge"><%= discountPercent %>% OFF</span>
                <% } %>
                <button class="wishlist-btn <%= inWishlist ? "active" : "" %>" 
                        onclick="event.stopPropagation(); toggleWishlist(<%= product.getProductId() %>, this)">
                    <i class="fa<%= inWishlist ? "s" : "r" %> fa-heart"></i>
                </button>
                <div class="product-image-container">
                    <img src="<%= productImageUrl %>" class="product-image" alt="<%= product.getProductName() %>">
                </div>
                <div class="product-details">
                    <h6 class="product-title"><%= product.getProductName() %></h6>
                    <p class="product-brand"><%= product.getBrand() != null ? product.getBrand() : "EntityKart" %></p>
                    <div class="product-price">
                        <span class="current-price">₹<fmt:formatNumber value="<%= product.getPrice() %>" pattern="#,##0"/></span>
                        <% if (product.getMrp() != null && product.getMrp() > product.getPrice()) { %>
                            <span class="original-price">₹<fmt:formatNumber value="<%= product.getMrp() %>" pattern="#,##0"/></span>
                        <% } %>
                    </div>
                    <% if (discountPercent > 0) { %>
                        <span class="discount"><%= discountPercent %>% off</span>
                    <% } %>
                    <div class="stock-info mt-2">
                        <% if (inStock) { %>
                            <span class="in-stock"><i class="fas fa-check-circle"></i> In Stock</span>
                        <% } else { %>
                            <span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                        <% } %>
                    </div>
                    <button class="add-to-cart-btn mt-2" onclick="event.stopPropagation(); addToCart(<%= product.getProductId() %>)"
                            <%= !inStock ? "disabled" : "" %>>
                        <i class="fas fa-cart-plus me-2"></i>
                        <%= inStock ? "Add to Cart" : "Out of Stock" %>
                    </button>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<!-- All Products Section -->
<section class="products-section">
    <div class="section-header">
        <h2 class="section-title">All Products</h2>
        <div class="filter-controls">
            <select class="filter-select" id="sortFilter">
                <option value="default">Sort by: Featured</option>
                <option value="name_asc">Name: A to Z</option>
                <option value="name_desc">Name: Z to A</option>
                <option value="price_low">Price: Low to High</option>
                <option value="price_high">Price: High to Low</option>
                <option value="newest">Newest First</option>
                <option value="popular">Popularity</option>
            </select>
            <select class="filter-select" id="categoryFilter">
                <option value="all">All Categories</option>
                <% for (CategoryEntity cat : categories) { %>
                    <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
                <% } %>
            </select>
        </div>
        <span class="product-count badge bg-primary"><%= products.size() %> items</span>
    </div>
    
    <div class="products-grid" id="productsGrid">
        <% 
           // Apply sorting to all products
           List<ProductEntity> sortedProducts = new ArrayList<>(products);
           if (sortParam != null) {
               if ("name_asc".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> 
                       a.getProductName().compareToIgnoreCase(b.getProductName()));
               } else if ("name_desc".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> 
                       b.getProductName().compareToIgnoreCase(a.getProductName()));
               } else if ("price_low".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> 
                       Float.compare(a.getPrice() != null ? a.getPrice() : 0, 
                                    b.getPrice() != null ? b.getPrice() : 0));
               } else if ("price_high".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> 
                       Float.compare(b.getPrice() != null ? b.getPrice() : 0, 
                                    a.getPrice() != null ? a.getPrice() : 0));
               } else if ("newest".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> {
                       if (a.getCreatedAt() == null && b.getCreatedAt() == null) return 0;
                       if (a.getCreatedAt() == null) return 1;
                       if (b.getCreatedAt() == null) return -1;
                       return b.getCreatedAt().compareTo(a.getCreatedAt());
                   });
               } else if ("popular".equals(sortParam)) {
                   Collections.sort(sortedProducts, (a, b) -> 
                       Integer.compare(b.getStockQuantity() != null ? b.getStockQuantity() : 0, 
                                      a.getStockQuantity() != null ? a.getStockQuantity() : 0));
               }
           }
           
           for (ProductEntity product : sortedProducts) { 
            int discountPercent = 0;
            if (product.getMrp() != null && product.getMrp() > 0 && 
                product.getPrice() != null && product.getPrice() > 0 && 
                product.getMrp() > product.getPrice()) {
                discountPercent = (int) Math.round(((product.getMrp() - product.getPrice()) / (double)product.getMrp()) * 100);
            }
            
            boolean inStock = product.getStockQuantity() != null && product.getStockQuantity() > 0;
            boolean lowStock = product.getStockQuantity() != null && product.getStockQuantity() < 10 && product.getStockQuantity() > 0;
            boolean inWishlist = wishlistedIds.contains(product.getProductId());
            
            String productImageUrl = product.getMainImageURL() != null && !product.getMainImageURL().isEmpty() 
                                    ? product.getMainImageURL() 
                                    : "https://via.placeholder.com/300";
        %>
        <div class="product-card" data-product-id="<%= product.getProductId() %>" 
             data-price="<%= product.getPrice() %>" onclick="viewProduct(<%= product.getProductId() %>)">
            <% if (product.getStockQuantity() != null && product.getStockQuantity() > 50) { %>
                <div class="product-badge">BESTSELLER</div>
            <% } else if (lowStock) { %>
                <div class="product-badge" style="background: var(--pink);">HURRY!</div>
            <% } %>
            
            <button class="wishlist-btn <%= inWishlist ? "active" : "" %>" 
                    onclick="event.stopPropagation(); toggleWishlist(<%= product.getProductId() %>, this)"
                    data-product-id="<%= product.getProductId() %>">
                <i class="<%= inWishlist ? "fas" : "far" %> fa-heart"></i>
            </button>
            
            <div class="product-image-container">
                <img src="<%= productImageUrl %>" class="product-image" alt="<%= product.getProductName() %>" loading="lazy">
            </div>
            
            <div class="product-details">
                <h6 class="product-title">
                    <%= product.getProductName().length() > 40 ? product.getProductName().substring(0, 37) + "..." : product.getProductName() %>
                </h6>
                
                <div class="product-price">
                    <span class="current-price">
                        <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="<%= product.getPrice() %>" pattern="#,##0"/>
                    </span>
                    <% if (product.getMrp() != null && product.getMrp() > product.getPrice()) { %>
                        <span class="original-price">
                            <i class="fas fa-rupee-sign"></i> <fmt:formatNumber value="<%= product.getMrp() %>" pattern="#,##0"/>
                        </span>
                        <span class="discount"><%= discountPercent %>% off</span>
                    <% } %>
                </div>
                
                <div class="stock-info">
                    <% if (inStock) { %>
                        <span class="<%= lowStock ? "low-stock" : "in-stock" %>">
                            <i class="fas fa-check-circle"></i> 
                            <%= lowStock ? "Only " + product.getStockQuantity() + " left!" : "In Stock" %>
                        </span>
                    <% } else { %>
                        <span class="out-of-stock">
                            <i class="fas fa-times-circle"></i> Out of Stock
                        </span>
                    <% } %>
                </div>
                
                <div class="button-group">
                    <button class="add-to-cart" onclick="event.stopPropagation(); addToCart(<%= product.getProductId() %>)" 
                            <%= !inStock ? "disabled" : "" %>>
                        <i class="fas fa-cart-plus"></i> Add
                    </button>
                    <button class="buy-now" onclick="event.stopPropagation(); buyNow(<%= product.getProductId() %>)" 
                            <%= !inStock ? "disabled" : "" %>>
                        <i class="fas fa-bolt"></i> Buy
                    </button>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    
    <% if (products.size() > 12) { %>
        <div class="load-more-container text-center mt-4" id="loadMoreContainer">
            <button class="btn btn-outline-primary" id="loadMoreBtn" onclick="loadMoreProducts()">
                <i class="fas fa-spinner me-2"></i>Load More Products
            </button>
        </div>
    <% } %>
</section>

<!-- Recently Viewed -->
<% if (!recentlyViewed.isEmpty()) { %>
<div class="container mt-5">
    <h3 class="mb-4" data-aos="fade-right">
        <i class="fas fa-history me-2 text-info"></i>Recently Viewed
    </h3>
    <div class="owl-carousel owl-theme" id="recentlyViewedCarousel">
        <% for (ProductEntity product : recentlyViewed) { 
            String productImageUrl = product.getMainImageURL() != null && !product.getMainImageURL().isEmpty()
                ? product.getMainImageURL()
                : "https://via.placeholder.com/150";
        %>
        <div class="item">
            <div class="product-card" onclick="viewProduct(<%= product.getProductId() %>)">
                <div class="product-image-container" style="height: 150px;">
                    <img src="<%= productImageUrl %>" class="product-image" alt="<%= product.getProductName() %>">
                </div>
                <div class="product-details p-2">
                    <h6 class="product-title small"><%= product.getProductName().length() > 30 ? product.getProductName().substring(0, 27) + "..." : product.getProductName() %></h6>
                    <span class="current-price small">₹<fmt:formatNumber value="<%= product.getPrice() %>" pattern="#,##0"/></span>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
<% } %>

<!-- Top Brands -->
<section class="brands-section">
    <h2 class="section-title">Top Brands</h2>
    <div class="brands-grid">
        <% String[] brands = {"Apple", "Samsung", "Nike", "Sony", "Adidas", "LG", "Puma", "Dell"};
           String[] brandColors = {"#A3AAAE", "#1428A0", "#111111", "#0037B3", "#000000", "#A50034", "#000000", "#0085C3"};
           for(int i = 0; i < brands.length; i++) { %>
        <div class="brand-card" onclick="window.location.href='${pageContext.request.contextPath}/products?brand=<%= brands[i].toLowerCase() %>'">
            <div class="brand-logo" style="color: <%= brandColors[i] %>;">
                <%= brands[i].substring(0, 1) %>
            </div>
            <div class="brand-name"><%= brands[i] %></div>
        </div>
        <% } %>
    </div>
</section>

<!-- Services Section -->
<section class="services-section">
    <h2 class="section-title">Why Choose EntityKart?</h2>
    <div class="services-grid">
        <div class="service-card">
            <div class="service-icon"><i class="fas fa-shield-alt"></i></div>
            <h3 class="service-title">100% Secure Payments</h3>
            <p class="service-desc">Safe and secure payment options with SSL encryption</p>
        </div>
        <div class="service-card">
            <div class="service-icon"><i class="fas fa-truck"></i></div>
            <h3 class="service-title">Free Shipping</h3>
            <p class="service-desc">Free delivery on orders above ₹499 across India</p>
        </div>
        <div class="service-card">
            <div class="service-icon"><i class="fas fa-undo"></i></div>
            <h3 class="service-title">Easy Returns</h3>
            <p class="service-desc">30-day return policy on most products</p>
        </div>
        <div class="service-card">
            <div class="service-icon"><i class="fas fa-headset"></i></div>
            <h3 class="service-title">24/7 Support</h3>
            <p class="service-desc">Round-the-clock customer support</p>
        </div>
    </div>
</section>

<!-- Banner Section -->
<section class="banner-section">
    <div class="banner-grid">
        <div class="banner-item" onclick="window.location.href='${pageContext.request.contextPath}/products?category=electronics'">
            <img src="https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" 
                 alt="Electronics Sale" loading="lazy">
        </div>
        <div class="banner-item" onclick="window.location.href='${pageContext.request.contextPath}/products?category=fashion'">
            <img src="https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" 
                 alt="Fashion Sale" loading="lazy">
        </div>
    </div>
</section>

<!-- Newsletter Section -->
<section class="newsletter-section">
    <h2 class="newsletter-title">Stay Updated</h2>
    <p class="newsletter-desc">Subscribe to our newsletter for exclusive deals and updates</p>
    <form class="newsletter-form" id="newsletterForm">
        <input type="email" name="email" class="newsletter-input" 
               placeholder="Enter your email address" required
               <%= currentUser != null ? "value='" + currentUser.getEmail() + "'" : "" %>>
        <button type="submit" class="newsletter-btn">Subscribe</button>
    </form>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-grid">
            <div class="footer-column">
                <h3>ABOUT</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/careers">Careers</a></li>
                    <li><a href="${pageContext.request.contextPath}/press">Press</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>HELP</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/payments">Payments</a></li>
                    <li><a href="${pageContext.request.contextPath}/shipping">Shipping</a></li>
                    <li><a href="${pageContext.request.contextPath}/returns">Cancellation & Returns</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>POLICY</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/return-policy">Return Policy</a></li>
                    <li><a href="${pageContext.request.contextPath}/terms">Terms Of Use</a></li>
                    <li><a href="${pageContext.request.contextPath}/security">Security</a></li>
                    <li><a href="${pageContext.request.contextPath}/privacy">Privacy</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>SOCIAL</h3>
                <div class="social-icons">
                    <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
                    <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="footer-column">
                <h3>MAIL US</h3>
                <ul>
                    <li>EntityKart Internet Private Limited,</li>
                    <li>Buildings Alyssa, Begonia &</li>
                    <li>Clove Embassy Tech Village,</li>
                    <li>Outer Ring Road,</li>
                    <li>Begusarai, Bihar - 861126</li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="copyright">
                <p>&copy; 2024 EntityKart. All rights reserved.</p>
            </div>
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/sitemap">Sitemap</a>
            </div>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
                <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </div>
</footer>

<!-- Back to Top Button -->
<div class="back-to-top" id="backToTop">
    <i class="fas fa-chevron-up"></i>
</div>

<!-- Compare Bar -->
<div class="compare-bar" id="compareBar">
    <span><i class="fas fa-balance-scale"></i> <span id="compareCount">0</span> products selected</span>
    <button class="btn btn-primary btn-sm" onclick="viewComparison()">Compare</button>
    <button class="btn btn-outline-secondary btn-sm" onclick="clearComparison()">Clear</button>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    // Global Variables
    let currentPage = 1;
    let loading = false;
    let hasMore = true;
    let compareList = JSON.parse(localStorage.getItem('compareList') || '[]');
    let searchTimeout;
    const contextPath = '${pageContext.request.contextPath}';
    
    // Document Ready
    $(document).ready(function() {
        // Initialize AOS
        AOS.init({ duration: 800, once: true });
        
        // Initialize Slick Slider
        $('.slick-slider').slick({
            dots: true,
            infinite: true,
            speed: 500,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 3000,
            arrows: true,
            responsive: [{ breakpoint: 768, settings: { arrows: false } }]
        });
        
        // Initialize Owl Carousel for Recently Viewed
        $('#recentlyViewedCarousel').owlCarousel({
            loop: true,
            margin: 15,
            nav: true,
            navText: ['<i class="fas fa-chevron-left"></i>', '<i class="fas fa-chevron-right"></i>'],
            responsive: {
                0: { items: 2 },
                600: { items: 3 },
                1000: { items: 5 }
            }
        });
        
        // User dropdown
        $('#userAvatar').click(function(e) {
            e.stopPropagation();
            $('#userDropdown').toggleClass('show');
        });
        
        $(document).click(function() {
            $('#userDropdown').removeClass('show');
        });
        
        // Search functionality
        $('#searchInput').keypress(function(e) {
            if (e.which === 13) performSearch();
        });
        
        // Search suggestions
        $('#searchInput').on('input', function() {
            clearTimeout(searchTimeout);
            const query = $(this).val().trim();
            
            if (query.length < 2) {
                $('.search-suggestions').remove();
                return;
            }
            
            searchTimeout = setTimeout(() => {
                axios.get('/api/search/suggestions', { params: { q: query } })
                    .then(response => showSearchSuggestions(response.data))
                    .catch(error => console.error('Search error:', error));
            }, 300);
        });
        
        // Back to top
        $(window).scroll(function() {
            $('#backToTop').toggleClass('visible', $(this).scrollTop() > 300);
        });
        
        $('#backToTop').click(function() {
            $('html, body').animate({scrollTop: 0}, 500);
        });
        
        // Infinite scroll
        $(window).scroll(function() {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                loadMoreProducts();
            }
        });
        
        // Newsletter form
        $('#newsletterForm').submit(function(e) {
            e.preventDefault();
            const email = $(this).find('input[type="email"]').val();
            
            axios.post('/api/newsletter/subscribe', { email: email })
                .then(response => {
                    if (response.data.success) {
                        showToast('success', 'Thank you for subscribing!');
                        $(this)[0].reset();
                    } else {
                        showToast('error', response.data.message || 'Subscription failed');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('error', 'Failed to subscribe');
                });
        });
        
        // Update compare count
        updateCompareCount();
        
        // Start deal timer if exists
        if (document.getElementById('dealTimer')) {
            startDealTimer();
        }
        
        // Sorting and Filtering
        $('#sortFilter').change(function() {
            const sortValue = $(this).val();
            const url = new URL(window.location.href);
            url.searchParams.set('sort', sortValue);
            url.searchParams.set('page', '1');
            window.location.href = url.toString();
        });
        
        $('#categoryFilter').change(function() {
            const categoryValue = $(this).val();
            const url = new URL(window.location.href);
            if (categoryValue === 'all') {
                url.searchParams.delete('category');
            } else {
                url.searchParams.set('category', categoryValue);
            }
            url.searchParams.set('page', '1');
            window.location.href = url.toString();
        });
    });
    
    // Search Functions
    function performSearch() {
        const query = $('#searchInput').val().trim();
        const category = $('#searchCategory').val();
        
        let url = contextPath + '/products?';
        if (query) url += 'q=' + encodeURIComponent(query);
        if (category) url += (query ? '&' : '') + 'category=' + category;
        
        window.location.href = url;
    }
    
    function showSearchSuggestions(suggestions) {
        $('.search-suggestions').remove();
        
        if (!suggestions || suggestions.length === 0) return;
        
        let suggestionsHtml = '<div class="search-suggestions" id="searchSuggestions">';
        suggestions.forEach(item => {
            suggestionsHtml += `
                <div class="suggestion-item" onclick="window.location.href='${contextPath}/product/' + ${item.id}">
                    <img src="${item.image}" class="suggestion-img" alt="${item.name}">
                    <div class="suggestion-info">
                        <div class="suggestion-name">${item.name}</div>
                        <div class="suggestion-price">₹${item.price}</div>
                    </div>
                </div>
            `;
        });
        suggestionsHtml += '</div>';
        
        $('.search-box').parent().append(suggestionsHtml);
        
        // Close suggestions when clicking outside
        setTimeout(() => {
            $(document).one('click', function() {
                $('.search-suggestions').remove();
            });
        }, 100);
    }
    
    // Product Functions
    function viewProduct(productId) {
        window.location.href = contextPath + '/product/' + productId;
        trackRecentlyViewed(productId);
    }
    
    // Cart Functions - FIXED: Using correct endpoints
    function addToCart(productId) {
        <% if (currentUser != null) { %>
            showLoading();
            
            axios.get(contextPath + '/cart/add', { 
                params: { 
                    productId: productId, 
                    quantity: 1 
                } 
            })
            .then(response => {
                hideLoading();
                // Since it's a redirect response, we need to handle differently
                if (response.request && response.request.responseURL) {
                    showToast('success', 'Product added to cart successfully!');
                    updateCartCount();
                } else {
                    showToast('success', 'Product added to cart successfully!');
                }
            })
            .catch(error => {
                hideLoading();
                console.error('Error:', error);
                if (error.response && error.response.status === 401) {
                    showToast('info', 'Please login to add items to cart');
                    setTimeout(() => window.location.href = contextPath + '/login', 2000);
                } else {
                    showToast('error', 'Failed to add product to cart');
                }
            });
        <% } else { %>
            showToast('info', 'Please login to add items to cart');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Buy Now Function - FIXED: Using correct endpoint
    function buyNow(productId) {
        <% if (currentUser != null) { %>
            window.location.href = contextPath + '/checkout?productId=' + productId + '&quantity=1';
        <% } else { %>
            showToast('info', 'Please login to place order');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Update Cart Count
    function updateCartCount() {
        <% if (currentUser != null) { %>
            axios.get(contextPath + '/cart/count')
                .then(response => {
                    $('#cartCount').text(response.data.count || 0);
                })
                .catch(error => console.log('Failed to update cart count'));
        <% } %>
    }
    
    // Wishlist Functions - FIXED: Using toggle endpoint
    function toggleWishlist(productId, element) {
        <% if (currentUser != null) { %>
            const $btn = $(element);
            const wasActive = $btn.hasClass('active');
            
            // Optimistic UI update
            $btn.toggleClass('active');
            $btn.find('i').toggleClass('far fas');
            
            axios.post(contextPath + '/api/wishlist/toggle', null, { 
                params: { productId: productId } 
            })
            .then(response => {
                const data = response.data;
                if (data.success) {
                    if (data.inWishlist) {
                        showToast('success', 'Added to wishlist!');
                    } else {
                        showToast('info', 'Removed from wishlist!');
                    }
                    
                    // Update wishlist count if exists
                    if (data.count !== undefined) {
                        $('#wishlistCount').text(data.count);
                        $('#wishlistCount').toggle(data.count > 0);
                    }
                } else {
                    // Revert if failed
                    $btn.toggleClass('active', wasActive);
                    $btn.find('i').toggleClass('far fas', !wasActive);
                    showToast('error', data.message || 'Failed to update wishlist');
                }
            })
            .catch(error => {
                // Revert on error
                $btn.toggleClass('active', wasActive);
                $btn.find('i').toggleClass('far fas', !wasActive);
                console.error('Error:', error);
                showToast('error', 'Failed to update wishlist');
            });
        <% } else { %>
            showToast('info', 'Please login to use wishlist');
            setTimeout(() => window.location.href = contextPath + '/login', 2000);
        <% } %>
    }
    
    // Initialize wishlist buttons
    function initWishlistButtons() {
        $('.wishlist-btn').off('click').on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const productId = $(this).data('product-id');
            toggleWishlist(productId, this);
        });
    }
    
    // Load More Products
    function loadMoreProducts() {
        if (loading || !hasMore) return;
        
        loading = true;
        showLoading();
        
        currentPage++;
        const searchTerm = $('#searchInput').val();
        const category = new URLSearchParams(window.location.search).get('category');
        const sort = new URLSearchParams(window.location.search).get('sort');
        
        let url = contextPath + '/products?page=' + currentPage;
        if (searchTerm) url += '&q=' + encodeURIComponent(searchTerm);
        if (category) url += '&category=' + category;
        if (sort) url += '&sort=' + sort;
        
        fetch(url)
            .then(response => response.text())
            .then(html => {
                hideLoading();
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                const newProducts = doc.querySelectorAll('.product-card');
                
                if (newProducts.length === 0) {
                    hasMore = false;
                    $('#loadMoreContainer').hide();
                } else {
                    newProducts.forEach(product => {
                        $('#productsGrid').append(product);
                    });
                    initWishlistButtons();
                }
            })
            .catch(error => {
                hideLoading();
                console.error('Error loading more products:', error);
                showToast('error', 'Failed to load more products');
            })
            .finally(() => {
                loading = false;
            });
    }
    
    // Recently Viewed
    function trackRecentlyViewed(productId) {
        let recentlyViewed = JSON.parse(localStorage.getItem('recentlyViewed') || '[]');
        recentlyViewed = recentlyViewed.filter(id => id !== productId);
        recentlyViewed.unshift(productId);
        if (recentlyViewed.length > 10) recentlyViewed.pop();
        localStorage.setItem('recentlyViewed', JSON.stringify(recentlyViewed));
    }
    
    // Deal Timer
    function startDealTimer() {
        const endTime = new Date();
        endTime.setHours(23, 59, 59, 999);
        
        function updateTimer() {
            const now = new Date();
            const diff = endTime - now;
            
            if (diff <= 0) {
                $('#hours, #minutes, #seconds').text('00');
                return;
            }
            
            const hours = Math.floor(diff / (1000 * 60 * 60));
            const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((diff % (1000 * 60)) / 1000);
            
            $('#hours').text(String(hours).padStart(2, '0'));
            $('#minutes').text(String(minutes).padStart(2, '0'));
            $('#seconds').text(String(seconds).padStart(2, '0'));
        }
        
        updateTimer();
        setInterval(updateTimer, 1000);
    }
    
    // Toast Notifications
    function showToast(type, message) {
        const toastId = 'toast-' + Date.now();
        const icons = {
            success: 'fa-check-circle',
            error: 'fa-exclamation-circle',
            info: 'fa-info-circle'
        };
        const titles = {
            success: 'Success',
            error: 'Error',
            info: 'Info'
        };
        
        const toast = `
            <div id="${toastId}" class="toast-notification ${type}">
                <div class="toast-icon"><i class="fas ${icons[type]}"></i></div>
                <div class="toast-content">
                    <div class="toast-title">${titles[type]}</div>
                    <div class="toast-message">${message}</div>
                </div>
                <div class="toast-close" onclick="this.parentElement.remove()"><i class="fas fa-times"></i></div>
            </div>
        `;
        
        $('#toastContainer').append(toast);
        
        setTimeout(() => {
            $('#' + toastId).css('animation', 'slideOutRight 0.3s ease forwards');
            setTimeout(() => $('#' + toastId).remove(), 300);
        }, 3000);
    }
    
    // Utility Functions
    function showLoading() {
        $('#loadingSpinner').fadeIn();
    }
    
    function hideLoading() {
        $('#loadingSpinner').fadeOut();
    }
    
    // Update compare count
    function updateCompareCount() {
        $('#compareCount').text(compareList.length);
        if (compareList.length > 0) {
            $('#compareBar').show();
        } else {
            $('#compareBar').hide();
        }
    }
    
    function viewComparison() {
        if (compareList.length < 2) {
            showToast('info', 'Add at least 2 products to compare');
            return;
        }
        window.location.href = contextPath + '/compare?ids=' + compareList.join(',');
    }
    
    function clearComparison() {
        compareList = [];
        localStorage.setItem('compareList', '[]');
        updateCompareCount();
        $('.compare-btn').removeClass('active');
        showToast('info', 'Comparison list cleared');
    }
    
    // Auto-refresh cart count every 30 seconds if logged in
    <% if (currentUser != null) { %>
        setInterval(updateCartCount, 30000);
    <% } %>
    
</script>

</body>
</html>