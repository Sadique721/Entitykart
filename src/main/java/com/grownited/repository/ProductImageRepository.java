package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ProductImageEntity;

import jakarta.transaction.Transactional;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImageEntity, Integer> {

    // 1. Find all images for a specific product (ordered by displayOrder)
    List<ProductImageEntity> findByProductIdOrderByDisplayOrderAsc(Integer productId);
    
    // 2. Find the primary image for a product
    Optional<ProductImageEntity> findByProductIdAndIsPrimaryTrue(Integer productId);
    
    // 3. Check if a product has any images
    boolean existsByProductId(Integer productId);
    
    // 4. Count how many images a product has
    Long countByProductId(Integer productId);
    
    // 5. Delete all images for a product (used when deleting product)
    void deleteByProductId(Integer productId);
    
    // 6. Custom query to reset primary status for a product
    @Modifying
    @Transactional
    @Query("UPDATE ProductImageEntity p SET p.isPrimary = false WHERE p.productId = :productId")
    void resetPrimaryForProduct(@Param("productId") Integer productId);
    
    // 7. Find all images except the primary one (for gallery)
    @Query("SELECT p FROM ProductImageEntity p WHERE p.productId = :productId AND p.isPrimary = false ORDER BY p.displayOrder ASC")
    List<ProductImageEntity> findGalleryImagesByProductId(@Param("productId") Integer productId);
    
    // 8. Find maximum display order for a product
    @Query("SELECT COALESCE(MAX(p.displayOrder), 0) FROM ProductImageEntity p WHERE p.productId = :productId")
    Integer getMaxDisplayOrder(@Param("productId") Integer productId);
}