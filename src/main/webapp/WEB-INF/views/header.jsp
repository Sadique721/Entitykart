<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EntityKart - <c:out value="${pageTitle != null ? pageTitle : 'E-Commerce Platform'}" /></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    
    <style>
        :root {
            --primary-blue: #2874f0;
            --primary-orange: #fb641b;
            --light-gray: #f1f3f6;
            --dark-gray: #878787;
            --white: #ffffff;
            --success-green: #26a541;
            --yellow: #ff9f00;
            --pink: #ff3f6c;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .wrapper {
            display: flex;
            width: 100%;
        }
        
        /* Sidebar Styles */
        #sidebar {
            min-width: 250px;
            max-width: 250px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            transition: all 0.3s;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            z-index: 1000;
        }
        
        #sidebar.active {
            margin-left: -250px;
        }
        
        #sidebar .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        #sidebar .sidebar-header h4 {
            color: white;
            margin-bottom: 5px;
        }
        
        #sidebar .sidebar-header p {
            color: rgba(255,255,255,0.8);
            font-size: 12px;
        }
        
        #sidebar .profile-img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            margin-bottom: 10px;
        }
        
        #sidebar ul.components {
            padding: 20px 0;
        }
        
        #sidebar ul li a {
            padding: 10px 20px;
            font-size: 14px;
            display: block;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: 0.3s;
        }
        
        #sidebar ul li a:hover {
            background: rgba(255,255,255,0.1);
            color: white;
        }
        
        #sidebar ul li.active > a {
            background: rgba(255,255,255,0.2);
            color: white;
            border-left: 3px solid #ffc107;
        }
        
        #sidebar ul li a i {
            width: 20px;
            margin-right: 10px;
        }
        
        .nav-divider {
            color: rgba(255,255,255,0.5);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Content Area */
        #content {
            width: 100%;
            margin-left: 250px;
            padding: 20px;
            min-height: 100vh;
            transition: all 0.3s;
        }
        
        #content.active {
            margin-left: 0;
        }
        
        .navbar-custom {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            border-radius: 10px;
            padding: 15px;
        }
        
        .profile-img-small {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        
        /* Welcome Card */
        .welcome-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .welcome-card h2 {
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .welcome-card p {
            opacity: 0.9;
            margin-bottom: 0;
        }
        
        @media (max-width: 768px) {
            #sidebar {
                margin-left: -250px;
            }
            #sidebar.active {
                margin-left: 0;
            }
            #content {
                margin-left: 0;
            }
            #content.active {
                margin-left: 250px;
            }
        }
    </style>
</head>
<body>
    <c:set var="currentUser" value="${sessionScope.user}" />
    <c:if test="${currentUser == null && pageContext.request.servletPath != '/login.jsp' && pageContext.request.servletPath != '/signup.jsp' && pageContext.request.servletPath != '/fp.jsp'}">
        <c:redirect url="/login" />
    </c:if>