package com.grownited.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.OrderEntity;
import com.grownited.entity.OrderEntity.OrderStatus;
import com.grownited.entity.OrderEntity.PaymentStatus;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

    // Find orders by customer
    List<OrderEntity> findByCustomerId(Integer customerId);
    
    // Find orders by customer with latest first
    List<OrderEntity> findByCustomerIdOrderByOrderDateDesc(Integer customerId);
    
    // Find orders by status
    List<OrderEntity> findByOrderStatus(OrderStatus status);
    
    // Find orders by payment status
    List<OrderEntity> findByPaymentStatus(PaymentStatus paymentStatus);
    
    // Find orders by customer and status
    List<OrderEntity> findByCustomerIdAndOrderStatus(Integer customerId, OrderStatus status);
    
    // Get recent orders
    List<OrderEntity> findTop10ByOrderByOrderDateDesc();
    
    // Count orders by status
    @Query("SELECT COUNT(o) FROM OrderEntity o WHERE o.orderStatus = :status")
    Long countByOrderStatus(@Param("status") OrderEntity.OrderStatus status);
    
    // Calculate total revenue
    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM OrderEntity o WHERE o.paymentStatus = 'PAID'")
    Double getTotalRevenue();
    
    // Check if customer has any orders
    boolean existsByCustomerId(Integer customerId);
    
    @Query("SELECT COUNT(o) FROM OrderEntity o WHERE o.orderDate BETWEEN :start AND :end")
    long countByOrderDateBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM OrderEntity o WHERE o.paymentStatus = 'PAID' AND o.orderDate BETWEEN :start AND :end")
    double getTotalRevenueBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);
    
}