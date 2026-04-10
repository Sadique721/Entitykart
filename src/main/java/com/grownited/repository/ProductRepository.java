package com.grownited.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ProductEntity;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

    // Find products by category
    Page<ProductEntity> findByCategoryId(Integer categoryId, Pageable pageable);
    
    @Query("SELECT DISTINCT p.userId FROM ProductEntity p")
    List<Integer> findDistinctUserIds();
    
    // Find products by subcategory (subCategoryId is String in your entity)
    Page<ProductEntity> findBySubCategoryId(String subCategoryId, Pageable pageable);
    
    // Search products by name
    @Query("SELECT p FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%'))")
    Page<ProductEntity> findByProductNameContainingIgnoreCase(@Param("search") String search, Pageable pageable);
    
    // Find products by status
    Page<ProductEntity> findByStatus(String status, Pageable pageable);
    
    // Find products by user (seller)
    Page<ProductEntity> findByUserId(Integer userId, Pageable pageable);
    
    // Count products by category
    Long countByCategoryId(Integer categoryId);
    
    // Get products in stock
    @Query("SELECT p FROM ProductEntity p WHERE p.stockQuantity > 0")
    Page<ProductEntity> findInStockProducts(Pageable pageable);
    
    // Get products by price range
    @Query("SELECT p FROM ProductEntity p WHERE p.price BETWEEN :minPrice AND :maxPrice")
    Page<ProductEntity> findByPriceRange(@Param("minPrice") Float minPrice, 
                                         @Param("maxPrice") Float maxPrice, 
                                         Pageable pageable);
    
    // Find products with filters
    @Query("SELECT p FROM ProductEntity p WHERE " +
           "(:categoryId IS NULL OR p.categoryId = :categoryId) AND " +
           "(:brand IS NULL OR p.brand = :brand) AND " +
           "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
           "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
           "(:inStock IS NULL OR (:inStock = 'true' AND p.stockQuantity > 0))")
    Page<ProductEntity> findWithFilters(
            @Param("categoryId") Integer categoryId,
            @Param("brand") String brand,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("inStock") String inStock,
            Pageable pageable);

    // Search products by name or description
    @Query("SELECT p FROM ProductEntity p WHERE " +
           "LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(p.description) LIKE LOWER(CONCAT('%', :search, '%'))")
    Page<ProductEntity> searchProducts(@Param("search") String search, Pageable pageable);

    // Find distinct brands by category
    @Query("SELECT DISTINCT p.brand FROM ProductEntity p WHERE p.brand IS NOT NULL AND " +
           "(:categoryId IS NULL OR p.categoryId = :categoryId)")
    List<String> findDistinctBrandsByCategory(@Param("categoryId") Integer categoryId);

    // Find similar products (same category, different product)
    @Query("SELECT p FROM ProductEntity p WHERE p.categoryId = :categoryId " +
           "AND p.productId != :productId ORDER BY p.createdAt DESC")
    Page<ProductEntity> findSimilarProducts(
            @Param("categoryId") Integer categoryId,
            @Param("productId") Integer productId,
            Pageable pageable);

    // Find frequently bought together (based on order history)
    @Query(value = "SELECT p.* FROM product p " +
           "JOIN order_details od ON p.product_id = od.product_id " +
           "WHERE od.order_id IN (" +
           "   SELECT DISTINCT order_id FROM order_details WHERE product_id = :productId" +
           ") AND p.product_id != :productId " +
           "GROUP BY p.product_id " +
           "ORDER BY COUNT(*) DESC", nativeQuery = true)
    Page<ProductEntity> findFrequentlyBoughtTogether(
            @Param("productId") Integer productId,
            Pageable pageable);

//    // Get deal of the day products (high discount)
//    @Query("SELECT p FROM ProductEntity p WHERE p.discountPercent > 20 " +
//           "ORDER BY p.discountPercent DESC")
//    Page<ProductEntity> findDealProducts(Pageable pageable);
//
//    // Get featured products (based on popularity)
//    @Query(value = "SELECT p.* FROM product p " +
//           "LEFT JOIN order_details od ON p.product_id = od.product_id " +
//           "GROUP BY p.product_id " +
//           "ORDER BY COUNT(od.order_item_id) DESC, p.created_at DESC", 
//           nativeQuery = true)
//    Page<ProductEntity> findFeaturedProducts(Pageable pageable);
    
    // Find minimum price
    @Query("SELECT MIN(p.price) FROM ProductEntity p")
    Float findMinPrice();
    
    // Find maximum price
    @Query("SELECT MAX(p.price) FROM ProductEntity p")
    Float findMaxPrice();
    
    // Find products by brand
    Page<ProductEntity> findByBrand(String brand, Pageable pageable);
    
    // Find products in stock with low stock
    @Query("SELECT p FROM ProductEntity p WHERE p.stockQuantity > 0 AND p.stockQuantity < 10")
    Page<ProductEntity> findLowStockProducts(Pageable pageable);
    
 // Find featured products
    @Query(value = "SELECT p.* FROM product p " +
           "LEFT JOIN order_details od ON p.product_id = od.product_id " +
           "GROUP BY p.product_id " +
           "ORDER BY COUNT(od.order_item_id) DESC, p.created_at DESC", 
           nativeQuery = true)
    Page<ProductEntity> findFeaturedProducts(Pageable pageable);

    // Find deal products
    @Query("SELECT p FROM ProductEntity p WHERE p.discountPercent > 20 " +
           "ORDER BY p.discountPercent DESC")
    Page<ProductEntity> findDealProducts(Pageable pageable);

	long countBySubCategoryId(String valueOf);
}