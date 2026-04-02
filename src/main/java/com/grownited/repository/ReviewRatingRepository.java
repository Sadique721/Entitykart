package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ReviewRatingEntity;

@Repository
public interface ReviewRatingRepository extends JpaRepository<ReviewRatingEntity, Integer> {

    // Find reviews for a product
    List<ReviewRatingEntity> findByProductIdOrderByCreatedAtDesc(Integer productId);
    
    // Find reviews for a product with pagination
    Page<ReviewRatingEntity> findByProductIdOrderByCreatedAtDesc(Integer productId, Pageable pageable);
    
    // Find reviews by customer
    List<ReviewRatingEntity> findByCustomerId(Integer customerId);
    
    // Find reviews by customer with pagination
    Page<ReviewRatingEntity> findByCustomerIdOrderByCreatedAtDesc(Integer customerId, Pageable pageable);
    
    // Find review by customer and product
    Optional<ReviewRatingEntity> findByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Check if customer already reviewed product
    boolean existsByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Get average rating for a product
    @Query("SELECT COALESCE(AVG(r.rating), 0) FROM ReviewRatingEntity r WHERE r.productId = :productId")
    Double getAverageRatingForProduct(@Param("productId") Integer productId);
    
    // Get total review count for a product
    @Query("SELECT COUNT(r) FROM ReviewRatingEntity r WHERE r.productId = :productId")
    Long getReviewCountForProduct(@Param("productId") Integer productId);
    
    // Get rating distribution for a product
    @Query("SELECT r.rating, COUNT(r) FROM ReviewRatingEntity r WHERE r.productId = :productId GROUP BY r.rating ORDER BY r.rating")
    List<Object[]> getRatingDistribution(@Param("productId") Integer productId);
    
    // Get recent reviews
    List<ReviewRatingEntity> findTop10ByOrderByCreatedAtDesc();
    
    // Get products with highest average ratings (minimum 3 reviews)
    @Query("SELECT r.productId, AVG(r.rating) as avgRating, COUNT(r) as reviewCount " +
           "FROM ReviewRatingEntity r " +
           "GROUP BY r.productId " +
           "HAVING COUNT(r) >= 3 " +
           "ORDER BY avgRating DESC, reviewCount DESC")
    List<Object[]> getTopRatedProducts(Pageable pageable);
    
    // Get customer review summary
    @Query("SELECT r.customerId, AVG(r.rating), COUNT(r) FROM ReviewRatingEntity r " +
           "WHERE r.customerId = :customerId GROUP BY r.customerId")
    List<Object[]> getCustomerReviewSummary(@Param("customerId") Integer customerId);
    
    // Search reviews by keyword
    @Query("SELECT r FROM ReviewRatingEntity r WHERE r.productId = :productId AND LOWER(r.comment) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<ReviewRatingEntity> searchReviews(@Param("productId") Integer productId, @Param("keyword") String keyword);
    
    // Get recent reviews for a product with customer names (join with UserEntity)
    @Query("SELECT r, u.name, u.profilePicURL FROM ReviewRatingEntity r " +
           "JOIN UserEntity u ON r.customerId = u.userId " +
           "WHERE r.productId = :productId " +
           "ORDER BY r.createdAt DESC")
    List<Object[]> findReviewsWithUserDetails(@Param("productId") Integer productId, Pageable pageable);
    
 // Add these methods to ReviewRatingRepository.java

 // Get overall average rating across all products
 @Query("SELECT COALESCE(AVG(r.rating), 0) FROM ReviewRatingEntity r")
 Double getOverallAverageRating();

 // Count distinct products that have reviews
 @Query("SELECT COUNT(DISTINCT r.productId) FROM ReviewRatingEntity r")
 Long countProductsWithReviews();

 // Count distinct customers who have written reviews
 @Query("SELECT COUNT(DISTINCT r.customerId) FROM ReviewRatingEntity r")
 Long countDistinctCustomers();

 // Get rating distribution across all products
 @Query("SELECT r.rating, COUNT(r) FROM ReviewRatingEntity r GROUP BY r.rating ORDER BY r.rating")
 List<Object[]> getRatingDistributionAll();

 // Get monthly review statistics for a year
 @Query("SELECT MONTH(r.createdAt), COUNT(r) FROM ReviewRatingEntity r " +
        "WHERE YEAR(r.createdAt) = :year GROUP BY MONTH(r.createdAt) ORDER BY MONTH(r.createdAt)")
 List<Object[]> getMonthlyReviewStats(@Param("year") int year);
}