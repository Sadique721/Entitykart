package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.grownited.entity.CartEntity;

@Repository
public interface CartRepository extends JpaRepository<CartEntity, Integer> {

    // Find all cart items for a customer
    List<CartEntity> findByCustomerId(Integer customerId);
    
    // Find specific cart item
    Optional<CartEntity> findByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Delete cart item
    void deleteByCustomerIdAndProductId(Integer customerId, Integer productId);
    
    // Delete all cart items for a customer
    void deleteByCustomerId(Integer customerId);
    
    // Count items in cart
    Long countByCustomerId(Integer customerId);
    
    // Get cart total for a customer
    @Query("SELECT COALESCE(SUM(c.price * c.quantity), 0) FROM CartEntity c WHERE c.customerId = :customerId")
    Double getCartTotal(@Param("customerId") Integer customerId);
    
    // Get cart items with product details
    @Query("SELECT c, p.productName, p.mainImageURL, p.stockQuantity " +
           "FROM CartEntity c " +
           "JOIN ProductEntity p ON c.productId = p.productId " +
           "WHERE c.customerId = :customerId")
    List<Object[]> findCartWithProductDetails(@Param("customerId") Integer customerId);
    
    // Clear cart after order placement
    @Modifying
    @Transactional
    @Query("DELETE FROM CartEntity c WHERE c.customerId = :customerId")
    void clearCart(@Param("customerId") Integer customerId);
    
    
}