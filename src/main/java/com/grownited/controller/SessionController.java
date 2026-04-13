package com.grownited.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.ReturnRefundRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

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

    @Autowired
    private AddressRepository addressRepository;

    // ========================= DASHBOARD (ADMIN ONLY) =========================
    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }

        try {
            List<UserEntity> userList = userRepository.findAll();
            List<CategoryEntity> categoryList = categoryRepository.findAll();
            List<ProductEntity> productList = productRepository.findAll();
            List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();

            // ---------- DYNAMIC STATS ----------
            long totalUsers = userRepository.count();
            long totalCities = addressRepository.countDistinctCities();
            long totalSellers = userRepository.countByRole("SELLER");
            if (totalSellers == 0) {
                totalSellers = productRepository.findDistinctUserIds().size(); // fallback
            }

            long totalProducts = productRepository.count();
            long totalOrders = orderRepository.count();

            long placedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.PLACED);
            long confirmedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.CONFIRMED);
            long shippedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.SHIPPED);
            long deliveredOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.DELIVERED);
            long cancelledOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.CANCELLED);
            long returnedOrders = orderRepository.countByOrderStatus(OrderEntity.OrderStatus.RETURNED);
            long pendingOrders = placedOrders + confirmedOrders;

            Double revenue = orderRepository.getTotalRevenue();
            double totalRevenue = (revenue != null) ? revenue : 0.0;

            List<OrderEntity> recentOrders = orderRepository.findTop10ByOrderByOrderDateDesc();

            // Return statistics
            List<Object[]> returnStats = returnRefundRepository.getReturnStatistics();
            Map<String, Long> statistics = new HashMap<>();
            for (Object[] stat : returnStats) {
                statistics.put(stat[0].toString(), (Long) stat[1]);
            }

            // Calculate in‑stock and low‑stock counts for products
            long inStockCount = productRepository.findInStockProducts(org.springframework.data.domain.Pageable.unpaged()).getTotalElements();
            long lowStockCount = productRepository.findLowStockProducts(org.springframework.data.domain.Pageable.unpaged()).getTotalElements();

            // ---------- ADD TO MODEL ----------
            model.addAttribute("totalCities", totalCities);
            model.addAttribute("totalSellers", totalSellers);
            model.addAttribute("statistics", statistics);
            model.addAttribute("userList", userList);
            model.addAttribute("categoryList", categoryList);
            model.addAttribute("productList", productList);
            model.addAttribute("subCategories", subCategories);
            model.addAttribute("currentUser", currentUser);
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
            model.addAttribute("totalRevenue", totalRevenue);
            model.addAttribute("recentOrders", recentOrders);
            model.addAttribute("inStockCount", inStockCount);
            model.addAttribute("lowStockCount", lowStockCount);

            // Optional: month‑over‑month percentages (simplified – use static text in JSP)
            // If you want real percentages, you need to add repository methods – not included here.

        } catch (Exception e) {
            logger.error("Error loading admin dashboard: {}", e.getMessage());
            model.addAttribute("error", "Unable to load dashboard data");
        }
        return "dashboard";
    }

    // ========================= HOME PAGE (FOR ALL USERS) =========================

    @GetMapping("/")
    public String rootURL(){
        return "login";
    }
    
    @GetMapping(value = { "/index", "/home"})
    @Transactional(readOnly = true)
    public String homePage(Model model, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        try {
            List<CategoryEntity> categoryList = categoryRepository.findAll();
            List<ProductEntity> productList = productRepository.findAll();

            long totalUsers = userRepository.count();
            long totalCities = addressRepository.countDistinctCities();
            long totalSellers = userRepository.countByRole("SELLER");
            if (totalSellers == 0) {
                totalSellers = productRepository.findDistinctUserIds().size();
            }

            model.addAttribute("categoryList", categoryList);
            model.addAttribute("productList", productList);
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalCities", totalCities);
            model.addAttribute("totalSellers", totalSellers);

        } catch (Exception e) {
            logger.error("Error loading home page: {}", e.getMessage());
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
        if (session.getAttribute("user") != null) {
            return "redirect:/index";
        }
        return "signup";
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/index";
        }
        return "login";
    }

    @GetMapping("/fp")
    public String forgotPasswordPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/index";
        }
        return "fp";
    }

    // ========================= AUTHENTICATION =========================
    @PostMapping("/authenticate")
    public String authenticate(String email, String password, Model model, HttpSession session) {
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

        session.setAttribute("user", dbUser);
        session.setAttribute("lastLoginTime", new java.util.Date());
        logger.info("User logged in successfully: {}", email);

        return "ADMIN".equals(dbUser.getRole()) ? "redirect:/dashboard" : "redirect:/index";
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
