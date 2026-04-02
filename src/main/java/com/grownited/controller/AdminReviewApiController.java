package com.grownited.controller;

import java.time.LocalDateTime;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.grownited.repository.ProductRepository;
import com.grownited.repository.ReviewRatingRepository;
import com.grownited.repository.UserRepository;

@RestController
@RequestMapping("/api/admin")
public class AdminReviewApiController {

    @Autowired
    private ReviewRatingRepository reviewRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/review-stats")
    public Map<String, Object> getReviewStats() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalReviews = reviewRepository.count();
        Double avgRating = reviewRepository.getOverallAverageRating();
        long productsWithReviews = reviewRepository.countProductsWithReviews();
        long activeReviewers = reviewRepository.countDistinctCustomers();
        
        stats.put("totalReviews", totalReviews);
        stats.put("avgRating", avgRating != null ? avgRating : 0.0);
        stats.put("productsWithReviews", productsWithReviews);
        stats.put("activeReviewers", activeReviewers);
        
        return stats;
    }
    
    @GetMapping("/rating-distribution")
    public Map<String, Object> getRatingDistribution() {
        Map<String, Object> distribution = new HashMap<>();
        
        List<Object[]> ratingCounts = reviewRepository.getRatingDistributionAll();
        
        long oneStar = 0, twoStar = 0, threeStar = 0, fourStar = 0, fiveStar = 0;
        
        for (Object[] row : ratingCounts) {
            Integer rating = (Integer) row[0];
            Long count = (Long) row[1];
            
            switch(rating) {
                case 1: oneStar = count; break;
                case 2: twoStar = count; break;
                case 3: threeStar = count; break;
                case 4: fourStar = count; break;
                case 5: fiveStar = count; break;
            }
        }
        
        distribution.put("oneStar", oneStar);
        distribution.put("twoStar", twoStar);
        distribution.put("threeStar", threeStar);
        distribution.put("fourStar", fourStar);
        distribution.put("fiveStar", fiveStar);
        
        // Add totals
        long totalReviews = reviewRepository.count();
        distribution.put("totalReviews", totalReviews);
        
        Double avgRating = reviewRepository.getOverallAverageRating();
        distribution.put("avgRating", avgRating != null ? avgRating : 0.0);
        
        long productsWithReviews = reviewRepository.countProductsWithReviews();
        distribution.put("productsWithReviews", productsWithReviews);
        
        long activeReviewers = reviewRepository.countDistinctCustomers();
        distribution.put("activeReviewers", activeReviewers);
        
        return distribution;
    }
    
    @GetMapping("/monthly-reviews")
    public Map<String, Object> getMonthlyReviews(@RequestParam(required = false) Integer year) {
        Map<String, Object> response = new HashMap<>();
        
        if (year == null) {
            year = Year.now().getValue();
        }
        
        List<Integer> monthlyData = new ArrayList<>(12);
        for (int i = 0; i < 12; i++) {
            monthlyData.add(0);
        }
        
        List<Object[]> monthlyCounts = reviewRepository.getMonthlyReviewStats(year);
        
        for (Object[] row : monthlyCounts) {
            Integer month = (Integer) row[0];
            Long count = (Long) row[1];
            
            if (month >= 1 && month <= 12) {
                monthlyData.set(month - 1, count.intValue());
            }
        }
        
        response.put("year", year);
        response.put("monthlyData", monthlyData);
        
        return response;
    }
}