package com.grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.OrderDetailEntity;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetailEntity, Integer> {

    // Find all items for an order
    List<OrderDetailEntity> findByOrderId(Integer orderId);
    
    // Find items by product
    List<OrderDetailEntity> findByProductId(Integer productId);
    
    // Delete all items for an order
    void deleteByOrderId(Integer orderId);
    
    // Get total quantity sold for a product
    @Query("SELECT COALESCE(SUM(od.quantity), 0) FROM OrderDetailEntity od WHERE od.productId = :productId")
    Integer getTotalSoldQuantity(@Param("productId") Integer productId);
    
    // Get best selling products
    @Query("SELECT od.productId, SUM(od.quantity) as totalSold " +
           "FROM OrderDetailEntity od " +
           "GROUP BY od.productId " +
           "ORDER BY totalSold DESC")
    List<Object[]> getBestSellingProducts();
    
    // Get order details with product info
    @Query("SELECT od, p.productName, p.mainImageURL " +
           "FROM OrderDetailEntity od " +
           "JOIN ProductEntity p ON od.productId = p.productId " +
           "WHERE od.orderId = :orderId")
    List<Object[]> findOrderDetailsWithProductInfo(@Param("orderId") Integer orderId);
    
    // Get monthly sales
    @Query("SELECT MONTH(od.createdAt), SUM(od.quantity * od.price) " +
           "FROM OrderDetailEntity od " +
           "WHERE YEAR(od.createdAt) = :year " +
           "GROUP BY MONTH(od.createdAt)")
    List<Object[]> getMonthlySales(@Param("year") int year);
    
    // Get top selling products with limit
    @Query("SELECT od.productId, SUM(od.quantity) as totalSold " +
           "FROM OrderDetailEntity od " +
           "GROUP BY od.productId " +
           "ORDER BY totalSold DESC")
    List<Object[]> findTopSellingProducts(org.springframework.data.domain.Pageable pageable);
}