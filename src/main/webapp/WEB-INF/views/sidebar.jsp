<div class="wrapper">
    <!-- Sidebar -->
    <nav id="sidebar">
        <div class="sidebar-header">
            <h4>EntityKart</h4>
            <c:if test="${currentUser != null}">
                <img src="${currentUser.profilePicURL != null ? currentUser.profilePicURL : 'https://via.placeholder.com/80'}" 
                     class="profile-img" alt="Profile">
                <h6 class="mb-0">${currentUser.name}</h6>
                <p class="mb-0">${currentUser.role}</p>
            </c:if>
        </div>

        <ul class="list-unstyled components">
            <!-- Admin Menu -->
            <c:if test="${currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/dashboard" class="${pageContext.request.servletPath == '/dashboard.jsp' ? 'active' : ''}">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                
                <li class="nav-divider px-3 my-2"><small>MANAGEMENT</small></li>
                
                <li>
                    <a href="#userSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-users"></i> User Management
                    </a>
                    <ul class="collapse list-unstyled" id="userSubmenu">
                        <li><a href="/listUser"><i class="fas fa-list"></i> All Users</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#productSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-box"></i> Product Management
                    </a>
                    <ul class="collapse list-unstyled" id="productSubmenu">
                        <li><a href="/admin/products"><i class="fas fa-list"></i> All Products</a></li>
                        <li><a href="/admin/product/add"><i class="fas fa-plus"></i> Add Product</a></li>
                        <li><a href="/listCategory"><i class="fas fa-tags"></i> Categories</a></li>
                        <li><a href="/listSubCategory"><i class="fas fa-sitemap"></i> Sub Categories</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#orderSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-shopping-cart"></i> Order Management
                    </a>
                    <ul class="collapse list-unstyled" id="orderSubmenu">
                        <li><a href="/admin/orders"><i class="fas fa-list"></i> All Orders</a></li>
                        <li><a href="/admin/orders?status=PLACED"><i class="fas fa-clock"></i> Pending Orders</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#returnSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-undo-alt"></i> Return Management
                    </a>
                    <ul class="collapse list-unstyled" id="returnSubmenu">
                        <li><a href="/admin/returns"><i class="fas fa-list"></i> All Returns</a></li>
                        <li><a href="/admin/returns?status=REQUESTED"><i class="fas fa-clock"></i> Pending Returns</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#paymentSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-credit-card"></i> Payment Management
                    </a>
                    <ul class="collapse list-unstyled" id="paymentSubmenu">
                        <li><a href="/admin/payments"><i class="fas fa-list"></i> All Payments</a></li>
                        <li><a href="/admin/payment-summary"><i class="fas fa-chart-pie"></i> Summary</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#reviewSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-star"></i> Review Management
                    </a>
                    <ul class="collapse list-unstyled" id="reviewSubmenu">
                        <li><a href="/admin/reviews"><i class="fas fa-list"></i> All Reviews</a></li>
                    </ul>
                </li>
                
                <li class="nav-divider px-3 my-2"><small>ANALYTICS</small></li>
                
                <li>
                    <a href="/admin/wishlist-stats"><i class="fas fa-heart"></i> Wishlist Analytics</a>
                </li>
            
            </c:if>
            
            <!-- User Menu -->
            <c:if test="${currentUser.role == 'USER'}">
                <li class="nav-item">
                    <a href="/index"><i class="fas fa-home"></i> Home</a>
                </li>
                
                <li class="nav-divider px-3 my-2"><small>SHOPPING</small></li>
                
                <li>
                    <a href="/cart">
                        <i class="fas fa-shopping-cart"></i> Cart
                        <span class="badge bg-danger ms-2" id="sidebarCartCount">0</span>
                    </a>
                </li>
                
                <li>
                    <a href="/wishlist">
                        <i class="fas fa-heart"></i> Wishlist
                        <span class="badge bg-danger ms-2" id="sidebarWishlistCount">0</span>
                    </a>
                </li>
                
                <li class="nav-divider px-3 my-2"><small>ACCOUNT</small></li>
                
                <li>
                    <a href="#orderSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                        <i class="fas fa-shopping-bag"></i> Orders
                    </a>
                    <ul class="collapse list-unstyled" id="orderSubmenu">
                        <li><a href="/orders"><i class="fas fa-list"></i> My Orders</a></li>
                        <li><a href="/my-returns"><i class="fas fa-undo-alt"></i> Returns</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="/profile"><i class="fas fa-user"></i> My Profile</a>
                </li>
                
                <li>
                    <a href="/address"><i class="fas fa-map-marker-alt"></i> Addresses</a>
                </li>
                
                <li>
                    <a href="/my-reviews"><i class="fas fa-star"></i> My Reviews</a>
                </li>
            </c:if>
            
            <li class="nav-divider px-3 my-2"><small>ACCOUNT</small></li>
            
            <li>
                <a href="/logout" class="text-danger" onclick="return confirm('Are you sure you want to logout?')">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </nav>

    <!-- Page Content -->
    <div id="content">
        <nav class="navbar navbar-custom">
            <div class="container-fluid">
                <button type="button" id="sidebarCollapse" class="btn btn-outline-secondary">
                    <i class="fas fa-bars"></i>
                </button>
                
                <div class="ms-auto d-flex align-items-center">
                    <!-- Cart Icon for Users -->
                    <c:if test="${currentUser.role == 'USER'}">
                        <a href="/cart" class="btn btn-link position-relative me-3">
                            <i class="fas fa-shopping-cart fa-lg"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="headerCartCount">
                                0
                            </span>
                        </a>
                    </c:if>
                    
                    <!-- User Dropdown -->
                    <div class="dropdown">
                    	<span class="ms-2 d-none d-md-inline">${currentUser.name}</span>
                        <button class="btn btn-link dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="dropdown">
                            <img src="${currentUser.profilePicURL != null ? currentUser.profilePicURL : 'https://via.placeholder.com/40'}" 
                                 class="profile-img-small" alt="Profile">
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i> Profile</a></li>
                            <li><a class="dropdown-item" href="/editUser?userId=${currentUser.userId}"><i class="fas fa-edit me-2"></i> Edit Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        
        <script>
            // Sidebar toggle
            document.getElementById('sidebarCollapse').addEventListener('click', function() {
                document.getElementById('sidebar').classList.toggle('active');
                document.getElementById('content').classList.toggle('active');
            });
            
            // Update counts
            function updateCartCount() {
                fetch('/cart/count')
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('headerCartCount').textContent = data.count || 0;
                        document.getElementById('sidebarCartCount').textContent = data.count || 0;
                    })
                    .catch(error => console.log('Cart count update failed'));
            }
            
            function updateWishlistCount() {
                fetch('/api/wishlist/summary')
                    .then(response => response.json())
                    .then(data => {
                        if (data.loggedIn) {
                            document.getElementById('sidebarWishlistCount').textContent = data.count || 0;
                        }
                    })
                    .catch(error => console.log('Wishlist count update failed'));
            }
            
            // Update on page load
            <c:if test="${currentUser.role == 'USER'}">
                updateCartCount();
                updateWishlistCount();
                setInterval(updateCartCount, 30000);
                setInterval(updateWishlistCount, 30000);
            </c:if>
        </script>