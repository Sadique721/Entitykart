package com.grownited.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.ReviewRatingEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.ReviewRatingRepository;
import com.grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {

    @Autowired
    private ReviewRatingRepository reviewRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    // ==================== CUSTOMER SIDE ====================
    
    // Show review form for a product
    @GetMapping("/review/write/{productId}")
    public String showReviewForm(@PathVariable Integer productId,
                                 @RequestParam(required = false) Integer orderItemId,
                                 HttpSession session,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Product not found!");
            return "redirect:/listProduct";
        }
        
        ProductEntity product = productOpt.get();
        
        // Check if user already reviewed this product
        if (reviewRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId)) {
            redirectAttributes.addFlashAttribute("error", "You have already reviewed this product!");
            return "redirect:/viewProduct?productId=" + productId;
        }
        
        // If orderItemId is provided, verify that user purchased this product
        if (orderItemId != null) {
            Optional<OrderDetailEntity> detailOpt = orderDetailRepository.findById(orderItemId);
            if (detailOpt.isPresent()) {
                OrderDetailEntity detail = detailOpt.get();
                Optional<OrderEntity> orderOpt = orderRepository.findById(detail.getOrderId());
                if (orderOpt.isPresent() && orderOpt.get().getCustomerId().equals(currentUser.getUserId())) {
                    model.addAttribute("orderItem", detail);
                    model.addAttribute("order", orderOpt.get());
                }
            }
        }
        
        model.addAttribute("product", product);
        model.addAttribute("productId", productId);
        
        return "reviewForm";
    }
    
    // Submit review
    @PostMapping("/review/submit")
    public String submitReview(@RequestParam Integer productId,
                               @RequestParam Integer rating,
                               @RequestParam String comment,
                               @RequestParam(required = false) Integer orderItemId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // Validate rating
        if (rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5!");
            return "redirect:/review/write/" + productId;
        }
        
        // Check if already reviewed
        if (reviewRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId)) {
            redirectAttributes.addFlashAttribute("error", "You have already reviewed this product!");
            return "redirect:/viewProduct?productId=" + productId;
        }
        
        // Create and save review
        ReviewRatingEntity review = new ReviewRatingEntity();
        review.setProductId(productId);
        review.setCustomerId(currentUser.getUserId());
        review.setRating(rating);
        review.setComment(comment);
        reviewRepository.save(review);
        
        session.setAttribute("successMessage", "Thank you! Your review has been submitted successfully.");
        
        return "redirect:/product/reviews/" + productId;
    }
    
    // Edit review
    @GetMapping("/review/edit/{reviewId}")
    public String editReview(@PathVariable Integer reviewId,
                             HttpSession session,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ReviewRatingEntity> reviewOpt = reviewRepository.findById(reviewId);
        if (reviewOpt.isEmpty() || !reviewOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Review not found!");
            return "redirect:/my-reviews";
        }
        
        ReviewRatingEntity review = reviewOpt.get();
        Optional<ProductEntity> productOpt = productRepository.findById(review.getProductId());
        
        model.addAttribute("review", review);
        model.addAttribute("product", productOpt.orElse(null));
        
        return "reviewEdit";
    }
    
    // Update review
    @PostMapping("/review/update")
    public String updateReview(@RequestParam Integer reviewId,
                               @RequestParam Integer rating,
                               @RequestParam String comment,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ReviewRatingEntity> reviewOpt = reviewRepository.findById(reviewId);
        if (reviewOpt.isEmpty() || !reviewOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "Review not found!");
            return "redirect:/my-reviews";
        }
        
        ReviewRatingEntity review = reviewOpt.get();
        review.setRating(rating);
        review.setComment(comment);
        reviewRepository.save(review);
        
        session.setAttribute("successMessage", "Review updated successfully!");
        
        return "redirect:/product/reviews/" + review.getProductId();
    }
    
    // Delete review
    @GetMapping("/review/delete/{reviewId}")
    public String deleteReview(@PathVariable Integer reviewId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ReviewRatingEntity> reviewOpt = reviewRepository.findById(reviewId);
        if (reviewOpt.isPresent() && reviewOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            Integer productId = reviewOpt.get().getProductId();
            reviewRepository.delete(reviewOpt.get());
            session.setAttribute("successMessage", "Review deleted successfully!");
            return "redirect:/product/reviews/" + productId;
        }
        
        redirectAttributes.addFlashAttribute("error", "Review not found!");
        return "redirect:/my-reviews";
    }
    
    // View my reviews
    @GetMapping("/my-reviews")
    public String myReviews(@RequestParam(required = false, defaultValue = "0") int page,
                            HttpSession session,
                            Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Pageable pageable = PageRequest.of(page, 10, Sort.by("createdAt").descending());
        Page<ReviewRatingEntity> reviewsPage = reviewRepository.findByCustomerIdOrderByCreatedAtDesc(currentUser.getUserId(), pageable);
        
        // Enrich with product details
        List<Map<String, Object>> reviewList = new ArrayList<>();
        for (ReviewRatingEntity review : reviewsPage.getContent()) {
            Optional<ProductEntity> productOpt = productRepository.findById(review.getProductId());
            
            Map<String, Object> map = new HashMap<>();
            map.put("review", review);
            map.put("product", productOpt.orElse(null));
            reviewList.add(map);
        }
        
        // Get summary statistics
        List<Object[]> summary = reviewRepository.getCustomerReviewSummary(currentUser.getUserId());
        
        model.addAttribute("reviews", reviewList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviewsPage.getTotalPages());
        model.addAttribute("totalElements", reviewsPage.getTotalElements());
        
        if (!summary.isEmpty()) {
            Object[] stats = summary.get(0);
            model.addAttribute("avgRating", String.format("%.1f", stats[1]));
            model.addAttribute("totalReviews", stats[2]);
        }
        
        return "myReviews";
    }
    
    // ==================== PUBLIC SIDE (Product Reviews) ====================
    
    // View all reviews for a product - FIXED: Proper type handling
    @GetMapping("/product/reviews/{productId}")
    public String productReviews(@PathVariable Integer productId,
                                 @RequestParam(required = false, defaultValue = "0") int page,
                                 HttpSession session,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Product not found!");
            return "redirect:/listProduct";
        }
        
        ProductEntity product = productOpt.get();
        
        Pageable pageable = PageRequest.of(page, 10, Sort.by("createdAt").descending());
        Page<ReviewRatingEntity> reviewsPage = reviewRepository.findByProductIdOrderByCreatedAtDesc(productId, pageable);
        
        // Get reviews with user details
        List<Object[]> reviewsWithUsers = reviewRepository.findReviewsWithUserDetails(productId, pageable);
        
        // Calculate rating statistics
        Double avgRating = reviewRepository.getAverageRatingForProduct(productId);
        Long totalReviews = reviewRepository.getReviewCountForProduct(productId);
        List<Object[]> distribution = reviewRepository.getRatingDistribution(productId);
        
        // Create rating distribution map with proper type handling
        Map<Integer, Long> ratingCount = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            ratingCount.put(i, 0L);
        }
        for (Object[] dist : distribution) {
            ratingCount.put((Integer) dist[0], (Long) dist[1]);
        }
        
        model.addAttribute("product", product);
        model.addAttribute("reviews", reviewsWithUsers != null ? reviewsWithUsers : new ArrayList<>());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviewsPage.getTotalPages());
        model.addAttribute("totalReviews", totalReviews != null ? totalReviews : 0L);
        model.addAttribute("avgRating", avgRating != null ? String.format("%.1f", avgRating) : "0.0");
        model.addAttribute("ratingCount", ratingCount);
        
        return "productReviews";
    }
    
    // ==================== ADMIN SIDE ====================
    
    // Admin: View all reviews
 // Admin: View all reviews with enhanced data
    @GetMapping("/admin/reviews")
    public String adminReviews(@RequestParam(required = false) Integer productId,
                               @RequestParam(required = false, defaultValue = "0") int page,
                               HttpSession session,
                               Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        Pageable pageable = PageRequest.of(page, 20, Sort.by("createdAt").descending());
        Page<ReviewRatingEntity> reviewsPage;
        
        if (productId != null) {
            reviewsPage = reviewRepository.findByProductIdOrderByCreatedAtDesc(productId, pageable);
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            model.addAttribute("filterProduct", productOpt.orElse(null));
        } else {
            reviewsPage = reviewRepository.findAll(pageable);
        }
        
        // Enrich with user and product details
        List<Map<String, Object>> reviewList = new ArrayList<>();
        for (ReviewRatingEntity review : reviewsPage.getContent()) {
            Optional<UserEntity> userOpt = userRepository.findById(review.getCustomerId());
            Optional<ProductEntity> productOpt = productRepository.findById(review.getProductId());
            
            Map<String, Object> map = new HashMap<>();
            map.put("review", review);
            map.put("user", userOpt.orElse(null));
            map.put("product", productOpt.orElse(null));
            reviewList.add(map);
        }
        
        // Get statistics for dashboard
        long totalReviews = reviewRepository.count();
        Double overallAvgRating = reviewRepository.getOverallAverageRating();
        long productsWithReviews = reviewRepository.countProductsWithReviews();
        long activeReviewers = reviewRepository.countDistinctCustomers();
        long totalProducts = productRepository.count();
        
        // Get rating distribution
        List<Object[]> distribution = reviewRepository.getRatingDistributionAll();
        Map<Integer, Long> ratingDistribution = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            ratingDistribution.put(i, 0L);
        }
        for (Object[] dist : distribution) {
            ratingDistribution.put((Integer) dist[0], (Long) dist[1]);
        }
        
        // Get all products for filter dropdown
        List<ProductEntity> allProducts = productRepository.findAll();
        
        model.addAttribute("reviews", reviewList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviewsPage.getTotalPages());
        model.addAttribute("totalElements", reviewsPage.getTotalElements());
        model.addAttribute("totalReviews", totalReviews);
        model.addAttribute("overallAvgRating", overallAvgRating != null ? String.format("%.1f", overallAvgRating) : "0.0");
        model.addAttribute("productsWithReviews", productsWithReviews);
        model.addAttribute("activeReviewers", activeReviewers);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("allProducts", allProducts);
        model.addAttribute("ratingDistribution", ratingDistribution);
        
        return "adminReviews";
    }
    
    // Admin: Delete review
    @GetMapping("/admin/review/delete")
    public String adminDeleteReview(@RequestParam Integer reviewId,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        if (reviewRepository.existsById(reviewId)) {
            reviewRepository.deleteById(reviewId);
            session.setAttribute("successMessage", "Review deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Review not found!");
        }
        
        return "redirect:/admin/reviews";
    }
    
    // ==================== AJAX ENDPOINTS ====================
    
    // Get product rating summary (AJAX)
    @GetMapping("/api/product/{productId}/rating")
    @ResponseBody
    public Map<String, Object> getProductRating(@PathVariable Integer productId) {
        
        Map<String, Object> response = new HashMap<>();
        
        Double avgRating = reviewRepository.getAverageRatingForProduct(productId);
        Long totalReviews = reviewRepository.getReviewCountForProduct(productId);
        List<Object[]> distribution = reviewRepository.getRatingDistribution(productId);
        
        Map<Integer, Long> ratingCount = new HashMap<>();
        for (Object[] dist : distribution) {
            ratingCount.put((Integer) dist[0], (Long) dist[1]);
        }
        
        response.put("avgRating", avgRating != null ? String.format("%.1f", avgRating) : "0.0");
        response.put("totalReviews", totalReviews != null ? totalReviews : 0);
        response.put("distribution", ratingCount);
        
        return response;
    }
    
    // Get recent reviews for a product (AJAX)
    @GetMapping("/api/product/{productId}/recent-reviews")
    @ResponseBody
    public List<Map<String, Object>> getRecentReviews(@PathVariable Integer productId) {
        
        Pageable pageable = PageRequest.of(0, 5, Sort.by("createdAt").descending());
        List<Object[]> reviews = reviewRepository.findReviewsWithUserDetails(productId, pageable);
        
        List<Map<String, Object>> response = new ArrayList<>();
        for (Object[] row : reviews) {
            ReviewRatingEntity review = (ReviewRatingEntity) row[0];
            String userName = (String) row[1];
            String userPic = (String) row[2];
            
            Map<String, Object> map = new HashMap<>();
            map.put("reviewId", review.getReviewId());
            map.put("rating", review.getRating());
            map.put("comment", review.getComment());
            map.put("userName", userName);
            map.put("userPic", userPic);
            map.put("date", review.getFormattedDate());
            response.add(map);
        }
        
        return response;
    }
}