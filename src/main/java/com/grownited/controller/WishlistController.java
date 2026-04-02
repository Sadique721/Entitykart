package com.grownited.controller;

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

import com.grownited.entity.ProductEntity;
import com.grownited.entity.UserEntity;
import com.grownited.entity.WishlistEntity;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.WishlistRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class WishlistController {

    @Autowired
    private WishlistRepository wishlistRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    // ==================== CUSTOMER SIDE ====================
    
    // Add to wishlist
    @GetMapping("/wishlist/add/{productId}")
    public String addToWishlist(@PathVariable Integer productId,
                                HttpSession session,
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
        
        // Check if already in wishlist
        if (!wishlistRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId)) {
            WishlistEntity wishlist = new WishlistEntity();
            wishlist.setCustomerId(currentUser.getUserId());
            wishlist.setProductId(productId);
            wishlistRepository.save(wishlist);
            redirectAttributes.addFlashAttribute("success", "Product added to wishlist!");
        } else {
            redirectAttributes.addFlashAttribute("info", "Product already in wishlist!");
        }
        
        // Redirect back to the referring page
        String referer = (String) session.getAttribute("previousPage");
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        
        return "redirect:/viewProduct?productId=" + productId;
    }
    
    // Add to wishlist (AJAX version)
    @PostMapping("/api/wishlist/add")
    @ResponseBody
    public Map<String, Object> addToWishlistAjax(@RequestParam Integer productId,
                                                 HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Please login first!");
            return response;
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Product not found!");
            return response;
        }
        
        boolean exists = wishlistRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId);
        
        if (!exists) {
            WishlistEntity wishlist = new WishlistEntity();
            wishlist.setCustomerId(currentUser.getUserId());
            wishlist.setProductId(productId);
            wishlistRepository.save(wishlist);
            response.put("added", true);
            response.put("message", "Added to wishlist!");
        } else {
            wishlistRepository.deleteByCustomerIdAndProductId(currentUser.getUserId(), productId);
            response.put("added", false);
            response.put("message", "Removed from wishlist!");
        }
        
        response.put("success", true);
        response.put("count", wishlistRepository.countByCustomerId(currentUser.getUserId()));
        
        return response;
    }
    
    // Toggle wishlist (add/remove)
    @PostMapping("/api/wishlist/toggle")
    @ResponseBody
    public Map<String, Object> toggleWishlist(@RequestParam Integer productId,
                                              HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Please login first!");
            response.put("loginRequired", true);
            return response;
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Product not found!");
            return response;
        }
        
        boolean exists = wishlistRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId);
        
        if (exists) {
            wishlistRepository.deleteByCustomerIdAndProductId(currentUser.getUserId(), productId);
            response.put("inWishlist", false);
            response.put("message", "Removed from wishlist!");
        } else {
            WishlistEntity wishlist = new WishlistEntity();
            wishlist.setCustomerId(currentUser.getUserId());
            wishlist.setProductId(productId);
            wishlistRepository.save(wishlist);
            response.put("inWishlist", true);
            response.put("message", "Added to wishlist!");
        }
        
        response.put("success", true);
        response.put("count", wishlistRepository.countByCustomerId(currentUser.getUserId()));
        
        return response;
    }
    
    // Check if product is in wishlist (AJAX)
    @GetMapping("/api/wishlist/check/{productId}")
    @ResponseBody
    public Map<String, Object> checkWishlist(@PathVariable Integer productId,
                                             HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("inWishlist", false);
            response.put("loggedIn", false);
            return response;
        }
        
        boolean inWishlist = wishlistRepository.existsByCustomerIdAndProductId(currentUser.getUserId(), productId);
        
        response.put("inWishlist", inWishlist);
        response.put("loggedIn", true);
        
        return response;
    }
    
    // View wishlist - FIXED: Handle Float to Double conversion properly
    @GetMapping("/wishlist")
    public String viewWishlist(@RequestParam(required = false, defaultValue = "0") int page,
                               HttpSession session,
                               Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Pageable pageable = PageRequest.of(page, 12, Sort.by("addedAt").descending());
        Page<Object[]> wishlistPage = wishlistRepository.findWishlistWithProductDetails(currentUser.getUserId(), pageable);
        
        List<Map<String, Object>> items = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
        
        for (Object[] row : wishlistPage.getContent()) {
            try {
                // Row structure: [WishlistEntity, productName, price, imageUrl, stockQuantity]
                WishlistEntity wishlist = (WishlistEntity) row[0];
                String productName = (String) row[1];
                
                // Handle price - it's Float in entity but might come as different types
                Float price = 0.0f;
                if (row[2] instanceof Float) {
                    price = (Float) row[2];
                } else if (row[2] instanceof Double) {
                    price = ((Double) row[2]).floatValue();
                } else if (row[2] instanceof Integer) {
                    price = ((Integer) row[2]).floatValue();
                } else if (row[2] instanceof Number) {
                    price = ((Number) row[2]).floatValue();
                }
                
                String imageUrl = (String) row[3];
                Integer stockQuantity = (Integer) row[4];
                
                Map<String, Object> map = new HashMap<>();
                map.put("wishlistId", wishlist.getWishlistId());
                map.put("productId", wishlist.getProductId());
                map.put("productName", productName);
                map.put("price", price); // Keep as Float for display
                map.put("imageUrl", imageUrl);
                map.put("stockQuantity", stockQuantity);
                map.put("addedAt", wishlist.getFormattedDate());
                map.put("inStock", stockQuantity != null && stockQuantity > 0);
                
                // Get discount from product entity separately if needed
                Optional<ProductEntity> productOpt = productRepository.findById(wishlist.getProductId());
                if (productOpt.isPresent()) {
                    ProductEntity product = productOpt.get();
                    Float discountPercent = product.getDiscountPercent(); // This should be Float if exists
                    if (discountPercent != null && discountPercent > 0) {
                        map.put("discountPercent", discountPercent);
                        float discountedPrice = price * (1 - discountPercent / 100);
                        map.put("discountedPrice", discountedPrice);
                    }
                }
                
                items.add(map);
            } catch (Exception e) {
                // Log the error but continue processing other items
                System.err.println("Error processing wishlist item: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        Long totalCount = wishlistRepository.countByCustomerId(currentUser.getUserId());
        
        model.addAttribute("wishlistItems", items);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", wishlistPage.getTotalPages());
        model.addAttribute("totalItems", totalCount);
        
        return "wishlist";
    }
    
    // Remove from wishlist
    @GetMapping("/wishlist/remove/{wishlistId}")
    public String removeFromWishlist(@PathVariable Integer wishlistId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<WishlistEntity> wishlistOpt = wishlistRepository.findById(wishlistId);
        if (wishlistOpt.isPresent() && wishlistOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            wishlistRepository.delete(wishlistOpt.get());
            redirectAttributes.addFlashAttribute("success", "Item removed from wishlist!");
        }
        
        return "redirect:/wishlist";
    }
    
    // Remove by product ID
    @GetMapping("/wishlist/remove-product/{productId}")
    public String removeProductFromWishlist(@PathVariable Integer productId,
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        wishlistRepository.deleteByCustomerIdAndProductId(currentUser.getUserId(), productId);
        redirectAttributes.addFlashAttribute("success", "Item removed from wishlist!");
        
        return "redirect:/wishlist";
    }
    
    // Clear wishlist
    @GetMapping("/wishlist/clear")
    public String clearWishlist(HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        wishlistRepository.deleteByCustomerId(currentUser.getUserId());
        redirectAttributes.addFlashAttribute("success", "Wishlist cleared successfully!");
        
        return "redirect:/wishlist";
    }
    
    // Move to cart
    @GetMapping("/wishlist/move-to-cart/{wishlistId}")
    public String moveToCart(@PathVariable Integer wishlistId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<WishlistEntity> wishlistOpt = wishlistRepository.findById(wishlistId);
        if (wishlistOpt.isPresent() && wishlistOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            Integer productId = wishlistOpt.get().getProductId();
            
            // Remove from wishlist
            wishlistRepository.delete(wishlistOpt.get());
            
            // Redirect to add to cart
            redirectAttributes.addFlashAttribute("success", "Item moved to cart!");
            return "redirect:/cart/add?productId=" + productId + "&quantity=1";
        }
        
        return "redirect:/wishlist";
    }
    
    // ==================== ADMIN SIDE ====================
    
    // Admin: View wishlist statistics
    @GetMapping("/admin/wishlist-stats")
    public String adminWishlistStats(HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/login";
        }
        
        // Get statistics
        long totalWishlistItems = wishlistRepository.count();
        long usersWithWishlist = wishlistRepository.countUsersWithWishlist();
        Double avgWishlistSize = wishlistRepository.getAverageWishlistSize();
        
        // Get most wishlisted products
        Pageable top10 = PageRequest.of(0, 10);
        List<Object[]> mostWishlisted = wishlistRepository.getMostWishlistedProducts(top10);
        
        List<Map<String, Object>> topProducts = new ArrayList<>();
        for (Object[] row : mostWishlisted) {
            Integer productId = (Integer) row[0];
            Long count = (Long) row[1];
            
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isPresent()) {
                ProductEntity product = productOpt.get();
                Map<String, Object> map = new HashMap<>();
                map.put("productId", productId);
                map.put("productName", product.getProductName());
                map.put("image", product.getMainImageURL());
                map.put("price", product.getPrice());
                map.put("wishlistCount", count);
                topProducts.add(map);
            }
        }
        
        model.addAttribute("totalItems", totalWishlistItems);
        model.addAttribute("usersWithWishlist", usersWithWishlist);
        model.addAttribute("avgWishlistSize", avgWishlistSize != null ? String.format("%.1f", avgWishlistSize) : "0");
        model.addAttribute("topProducts", topProducts);
        
        return "adminWishlistStats";
    }
    
    // ==================== API ENDPOINTS ====================
    
    // Get wishlist count for a product
    @GetMapping("/api/wishlist/count/{productId}")
    @ResponseBody
    public Map<String, Object> getWishlistCount(@PathVariable Integer productId) {
        
        Map<String, Object> response = new HashMap<>();
        
        List<Integer> productIds = new ArrayList<>();
        productIds.add(productId);
        List<Object[]> counts = wishlistRepository.getWishlistCountsForProducts(productIds);
        
        long count = 0;
        if (!counts.isEmpty()) {
            count = (Long) counts.get(0)[1];
        }
        
        response.put("productId", productId);
        response.put("count", count);
        
        return response;
    }
    
    // Get wishlist status for multiple products
    @PostMapping("/api/wishlist/status")
    @ResponseBody
    public Map<String, Object> getWishlistStatus(@RequestParam List<Integer> productIds,
                                                 HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("loggedIn", false);
            return response;
        }
        
        List<Integer> wishlistedIds = wishlistRepository.findWishlistedProductIds(currentUser.getUserId(), productIds);
        
        Map<Integer, Boolean> statusMap = new HashMap<>();
        for (Integer productId : productIds) {
            statusMap.put(productId, wishlistedIds.contains(productId));
        }
        
        response.put("loggedIn", true);
        response.put("status", statusMap);
        
        return response;
    }
    
    // Get wishlist summary for user
    @GetMapping("/api/wishlist/summary")
    @ResponseBody
    public Map<String, Object> getWishlistSummary(HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("loggedIn", false);
            return response;
        }
        
        long count = wishlistRepository.countByCustomerId(currentUser.getUserId());
        List<Object[]> recentItems = wishlistRepository.findWishlistWithProductDetails(currentUser.getUserId());
        
        List<Map<String, Object>> items = new ArrayList<>();
        int limit = Math.min(5, recentItems.size());
        for (int i = 0; i < limit; i++) {
            try {
                Object[] row = recentItems.get(i);
                WishlistEntity wishlist = (WishlistEntity) row[0];
                String productName = (String) row[1];
                String imageUrl = (String) row[3];
                
                Map<String, Object> item = new HashMap<>();
                item.put("wishlistId", wishlist.getWishlistId());
                item.put("productId", wishlist.getProductId());
                item.put("productName", productName);
                item.put("imageUrl", imageUrl);
                item.put("addedAt", wishlist.getFormattedDate());
                items.add(item);
            } catch (Exception e) {
                // Skip problematic item
                System.err.println("Error processing recent wishlist item: " + e.getMessage());
            }
        }
        
        response.put("loggedIn", true);
        response.put("count", count);
        response.put("recentItems", items);
        
        return response;
    }
}