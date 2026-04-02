package com.grownited.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.grownited.entity.UserEntity;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AuthFilter implements Filter {

    // Public exact URLs (no authentication required)
    private static final Set<String> PUBLIC_EXACT = new HashSet<>(Arrays.asList(
        "/", "/index", "/home",
        "/login", "/signup", "/fp",
        "/authenticate",          // POST login
        "/send-otp",              // POST for OTP
        "/verify-otp",            // POST OTP verification
        "/update-password",
        "/register"
    ));

    // Public URL prefixes (no authentication required) – includes static resources
    private static final Set<String> PUBLIC_PREFIXES = new HashSet<>(Arrays.asList(
        "/assets/", "/css/", "/js/", "/images/",          // static resources
        "/products",                                      // product listing
        "/product/",                                      // product details, reviews, quick view
        "/category/",                                     // category and subcategory JSON endpoints
        "/api/product/",                                  // product rating, recent reviews, images
        "/api/wishlist/count/",                           // public wishlist count
        "/api/orders/best-selling",                       // best‑selling products API
        "/check-delivery",                                // delivery check AJAX
        "/product/quickView/"                             // product quick view AJAX
    ));

    // Admin‑only URL prefixes (require role ADMIN)
    private static final Set<String> ADMIN_PREFIXES = new HashSet<>(Arrays.asList(
        "/admin/",
        "/api/admin/",
        "/dashboard",
        "/listUser", "/deleteUser",
        "/toggleCategoryActive", "/saveCategory", "/deleteCategory",
        "/editCategory", "/updateCategory",
        "/toggleSubCategoryActive", "/saveSubCategory", "/deleteSubCategory",
        "/editSubCategory", "/updateSubCategory",
        "/product/images"                 // all image management endpoints
    ));

    // Additional admin‑only exact URLs
    private static final Set<String> ADMIN_EXACT = new HashSet<>(Arrays.asList(
        "/admin/orders", "/admin/order/details", "/admin/order/update-status", "/admin/order-stats",
        "/admin/payments", "/admin/payment/details", "/admin/payment-summary",
        "/admin/returns", "/admin/return/details", "/admin/return/process", "/admin/return/bulk-process",
        "/admin/wishlist-stats",
        "/admin/reviews", "/admin/review/delete"
    ));

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Use getServletPath() to get the path without context root
        String servletPath = req.getServletPath();
        String requestURI = req.getRequestURI();

        // 1. Allow OPTIONS requests (CORS preflight)
        if ("OPTIONS".equalsIgnoreCase(req.getMethod())) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Allow public exact URLs
        if (PUBLIC_EXACT.contains(servletPath)) {
            chain.doFilter(request, response);
            return;
        }

        // 3. Check for admin‑only access first (because some URLs may also match public prefixes)
        boolean isAdminPath = false;
        for (String prefix : ADMIN_PREFIXES) {
            if (servletPath.startsWith(prefix)) {
                isAdminPath = true;
                break;
            }
        }
        if (ADMIN_EXACT.contains(servletPath)) {
            isAdminPath = true;
        }

        // 4. Allow public prefix URLs (only if not already identified as admin)
        if (!isAdminPath) {
            for (String prefix : PUBLIC_PREFIXES) {
                if (servletPath.startsWith(prefix)) {
                    chain.doFilter(request, response);
                    return;
                }
            }
        }

        // 5. All other paths require authentication
        HttpSession session = req.getSession(false);
        UserEntity user = (session != null) ? (UserEntity) session.getAttribute("user") : null;

        if (user == null) {
            // Not logged in – store original URL and redirect to login
            session = req.getSession(true);
            session.setAttribute("redirectUrl", requestURI);
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 6. If the path is admin‑only, verify role
        if (isAdminPath && !"ADMIN".equals(user.getRole())) {
            // User is logged in but not an admin – redirect to home
            res.sendRedirect(req.getContextPath() + "/index");
            return;
        }

        // 7. Authenticated user, allowed to proceed
        chain.doFilter(request, response);
    }
}