package com.grownited.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.PaymentEntity;
import com.grownited.entity.PaymentEntity.PaymentGatewayStatus;
import com.grownited.entity.PaymentEntity.PaymentMode;

@Repository
public interface PaymentRepository extends JpaRepository<PaymentEntity, Integer> {

    // Find payment by order
    Optional<PaymentEntity> findByOrderId(Integer orderId);
    
    // Find payments by status
    List<PaymentEntity> findByPaymentStatus(PaymentGatewayStatus status);
    
    // Find payments by mode
    List<PaymentEntity> findByPaymentMode(PaymentMode mode);
    
    // Check if payment exists for order
    boolean existsByOrderId(Integer orderId);
    
    // Delete payment by order
    void deleteByOrderId(Integer orderId);
    
    // Get recent payments with pagination
    Page<PaymentEntity> findAll(Pageable pageable);

    // Get daily revenue between dates - SINGLE METHOD (remove duplicates)
    @Query("SELECT DATE(p.paymentDate), COALESCE(SUM(p.amount), 0) FROM PaymentEntity p " +
           "WHERE p.paymentStatus = 'SUCCESS' AND p.paymentDate BETWEEN :startDate AND :endDate " +
           "GROUP BY DATE(p.paymentDate) ORDER BY DATE(p.paymentDate)")
    List<Object[]> getDailyRevenue(@Param("startDate") LocalDateTime startDate,
                                   @Param("endDate") LocalDateTime endDate);
    
    // Get total revenue by payment mode
    @Query("SELECT p.paymentMode, COALESCE(SUM(p.amount), 0) FROM PaymentEntity p " +
           "WHERE p.paymentStatus = 'SUCCESS' GROUP BY p.paymentMode")
    List<Object[]> getRevenueByPaymentMode();
    
    // Get total revenue for a date range
    @Query("SELECT COALESCE(SUM(p.amount), 0) FROM PaymentEntity p " +
           "WHERE p.paymentStatus = 'SUCCESS' AND p.paymentDate BETWEEN :startDate AND :endDate")
    Double getTotalRevenueBetweenDates(@Param("startDate") LocalDateTime startDate,
                                       @Param("endDate") LocalDateTime endDate);
    
    // Get payment count by status
    @Query("SELECT COUNT(p) FROM PaymentEntity p WHERE p.paymentStatus = :status")
    Long countByPaymentStatus(@Param("status") PaymentGatewayStatus status);
}