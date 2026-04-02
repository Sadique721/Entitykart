<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f6f9;
}

/* Sidebar */
.sidebar {
	height: 100vh;
	background-color: #212529;
	color: #fff;
	position: fixed;
	width: 240px;
}

.sidebar a {
	color: #adb5bd;
	text-decoration: none;
	padding: 12px 20px;
	display: block;
	transition: 0.3s;
}

.sidebar a:hover {
	background-color: #343a40;
	color: #fff;
}

.sidebar .active {
	background-color: #0d6efd;
	color: #fff;
}

/* Main content */
.content {
	margin-left: 240px;
	padding: 20px;
}

/* Footer */
footer {
	background-color: #fff;
	border-top: 1px solid #dee2e6;
	padding: 10px;
	text-align: center;
	margin-top: 20px;
}
</style>
</head>
<body>
	<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold">Admin Panel</span>

        <div class="ms-auto">
            <span class="me-3">Welcome, Admin</span>
            <a href="logout" class="btn btn-sm btn-outline-danger">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
</nav>
<div class="sidebar">
    <h5 class="text-center py-3 border-bottom">Dashboard</h5>

    <a href="admin-dashboard" class="">
        <i class="bi bi-speedometer2 me-2"></i> Dashboard
    </a>
    <a href="newCategory">
        <i class="bi bi-tags me-2"></i> New Category
    </a>
     <a href="listCategory">
        <i class="bi bi-tags me-2"></i> List Category
    </a>
    
    <a href="signup">
        <i class="bi bi-box me-2"></i> New User
    </a>
    <a href="listUser">
        <i class="bi bi-people me-2"></i> Users
    </a>
    <a href="#">
        <i class="bi bi-gear me-2"></i> Settings
    </a>
</div>
</body>
</html>