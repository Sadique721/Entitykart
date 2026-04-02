package com.grownited.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.ReturnRefundRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Map;
import java.util.HashMap;

@Controller
public class SessionController {
    
    private static final Logger logger = LoggerFactory.getLogger(SessionController.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private SubCategoryRepository subCategoryRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ReturnRefundRepository returnRefundRepository;
    // ========================= DASHBOARD (ADMIN ONLY) =========================
    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        if (!"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/index";
        }

        try {
            // Load admin dashboard data
            List<UserEntity> userList = userRepository.findAll();
            List<CategoryEntity> categoryList = categoryRepository.findAll();
            List<ProductEntity> productList = productRepository.findAll();
            List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
            
            // Admin statistics
            long totalUsers = userList.size();
            long totalProducts = productList.size();
            long totalOrders = orderRepository.count();
            long placedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.PLACED);
            long confirmedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.CONFIRMED);
            long shippedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.SHIPPED);
            long deliveredOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.DELIVERED);
            long cancelledOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.CANCELLED);
            long returnedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.RETURNED);
            long pendingOrders = placedOrders + confirmedOrders;
            Double totalRevenue = orderRepository.getTotalRevenue();
            
            // Recent orders for admin
            List<OrderEntity> recentOrders = orderRepository.findTop10ByOrderByOrderDateDesc();
            List<Object[]> stats = returnRefundRepository.getReturnStatistics();
            Map<String, Long> statistics = new HashMap<>();
            for (Object[] stat : stats) {
                statistics.put(stat[0].toString(), (Long) stat[1]);
            }

            model.addAttribute("statistics", statistics);
            model.addAttribute("userList", userList);
            model.addAttribute("categoryList", categoryList);
            model.addAttribute("productList", productList);
            model.addAttribute("subCategories", subCategories);
            model.addAttribute("currentUser", currentUser);
            
            // Statistics
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalProducts", totalProducts);
            model.addAttribute("totalOrders", totalOrders);
            model.addAttribute("placedOrders", placedOrders);
            model.addAttribute("confirmedOrders", confirmedOrders);
            model.addAttribute("shippedOrders", shippedOrders);
            model.addAttribute("deliveredOrders", deliveredOrders);
            model.addAttribute("cancelledOrders", cancelledOrders);
            model.addAttribute("returnedOrders", returnedOrders);
            model.addAttribute("pendingOrders", pendingOrders);
            model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
            model.addAttribute("recentOrders", recentOrders);

        } catch (Exception e) {
            logger.error("Error loading admin dashboard: {}", e.getMessage());
            model.addAttribute("error", "Unable to load dashboard data");
        }

        return "dashboard";
    }

    // ========================= HOME PAGE (FOR ALL USERS) =========================
    @GetMapping(value = {"/", "/index", "/home"})
    public String homePage(Model model, HttpSession session) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        
        try {
            // Load public data with null safety
            List<CategoryEntity> categoryList = categoryRepository != null ? 
                categoryRepository.findAll() : List.of();
            List<ProductEntity> productList = productRepository != null ? 
                productRepository.findAll() : List.of();
            
            // Log for debugging (optional, can be removed in production)
            logger.debug("Home page loaded - Categories: {}, Products: {}", 
                categoryList.size(), productList.size());
            
            model.addAttribute("categoryList", categoryList);
            model.addAttribute("productList", productList);
            
            
        } catch (Exception e) {
            logger.error("Error loading home page data: {}", e.getMessage());
            model.addAttribute("categoryList", List.of());
            model.addAttribute("productList", List.of());
            model.addAttribute("error", "Unable to load some content");
        }
        
        model.addAttribute("currentUser", currentUser);
        
        return "index";
    }

    // ========================= AUTH PAGES =========================
    @GetMapping("/signup")
    public String signupPage(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser != null) {
            return "redirect:/index";
        }
        return "signup";
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser != null) {
            return "redirect:/index";
        }
        return "login";
    }

    @GetMapping("/fp")
    public String forgotPasswordPage(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser != null) {
            return "redirect:/index";
        }
        return "fp";
    }

    // ========================= AUTHENTICATION =========================
    @PostMapping("/authenticate")
    public String authenticate(String email,
                               String password,
                               Model model,
                               HttpSession session) {

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email and password are required");
            return "login";
        }

        Optional<UserEntity> optionalUser = userRepository.findByEmail(email.trim());

        if (optionalUser.isEmpty()) {
            logger.warn("Failed login attempt for email: {}", email);
            model.addAttribute("error", "Invalid Credentials");
            return "login";
        }

        UserEntity dbUser = optionalUser.get();

        if (!dbUser.getActive()) {
            logger.warn("Inactive account login attempt: {}", email);
            model.addAttribute("error", "Your account is deactivated. Please contact support.");
            return "login";
        }

        if (!passwordEncoder.matches(password, dbUser.getPassword())) {
            logger.warn("Invalid password for email: {}", email);
            model.addAttribute("error", "Invalid Credentials");
            return "login";
        }

        // Successful login
        session.setAttribute("user", dbUser);
        session.setAttribute("lastLoginTime", new java.util.Date());
        
        logger.info("User logged in successfully: {}", email);

        if ("ADMIN".equals(dbUser.getRole())) {
            return "redirect:/dashboard";
        } else {
            return "redirect:/index";
        }
    }

    // ========================= LOGOUT =========================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user != null) {
            logger.info("User logged out: {}", user.getEmail());
        }
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}