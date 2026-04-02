package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.grownited.entity.WishlistEntity;

@Repository
public interface WishlistRepository extends JpaRepository<WishlistEntity, Integer> {

    // Find wishlist items for a customer
    List<WishlistEntity> findByCustomerId(Integer customerId);
    
    // Find wishlist items for a customer with pagination
    Page<WishlistEntity> findByCustomerIdOrderByAddedAtDesc(Integer customerId, Pageable pageable);
    
    // Find specific wishlist item
    Optional<WishlistEntity> findByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Delete wishlist item
    @Modifying
    @Transactional
    void deleteByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Check if product is in customer's wishlist
    boolean existsByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Count wishlist items for customer
    Long countByCustomerId(Integer customerId);
    
    // Get wishlist items with product details - FIXED: Cast price as Float to match entity
    @Query("SELECT w, p.productName, CAST(p.price AS float), p.mainImageURL, p.stockQuantity " +
           "FROM WishlistEntity w " +
           "JOIN ProductEntity p ON w.productId = p.productId " +
           "WHERE w.customerId = :customerId " +
           "ORDER BY w.addedAt DESC")
    List<Object[]> findWishlistWithProductDetails(@Param("customerId") Integer customerId);
    
    // Get wishlist items with product details with pagination - FIXED: Cast price as Float
    @Query("SELECT w, p.productName, CAST(p.price AS float), p.mainImageURL, p.stockQuantity " +
           "FROM WishlistEntity w " +
           "JOIN ProductEntity p ON w.productId = p.productId " +
           "WHERE w.customerId = :customerId " +
           "ORDER BY w.addedAt DESC")
    Page<Object[]> findWishlistWithProductDetails(@Param("customerId") Integer customerId, Pageable pageable);
    
    // Get most wishlisted products
    @Query("SELECT w.productId, COUNT(w) as wishlistCount " +
           "FROM WishlistEntity w " +
           "GROUP BY w.productId " +
           "ORDER BY wishlistCount DESC")
    List<Object[]> getMostWishlistedProducts(Pageable pageable);
    
    // Delete all wishlist items for a customer
    @Modifying
    @Transactional
    void deleteByCustomerId(Integer customerId);
    
    // Get wishlist count for multiple products (for product listing)
    @Query("SELECT w.productId, COUNT(w) FROM WishlistEntity w WHERE w.productId IN :productIds GROUP BY w.productId")
    List<Object[]> getWishlistCountsForProducts(@Param("productIds") List<Integer> productIds);
    
    // Check if products are in wishlist for a customer (bulk check)
    @Query("SELECT w.productId FROM WishlistEntity w WHERE w.customerId = :customerId AND w.productId IN :productIds")
    List<Integer> findWishlistedProductIds(@Param("customerId") Integer customerId, 
                                           @Param("productIds") List<Integer> productIds);
    
    // Get wishlist statistics
    @Query("SELECT COUNT(DISTINCT w.customerId) FROM WishlistEntity w")
    Long countUsersWithWishlist();
    
    @Query("SELECT AVG(wcount) FROM (SELECT COUNT(w) as wcount FROM WishlistEntity w GROUP BY w.customerId)")
    Double getAverageWishlistSize();
}