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

import com.grownited.entity.ReturnRefundEntity;
import com.grownited.entity.ReturnRefundEntity.ReturnStatus;

@Repository
public interface ReturnRefundRepository extends JpaRepository<ReturnRefundEntity, Integer> {

    // Find return by order item
    Optional<ReturnRefundEntity> findByOrderItemId(Integer orderItemId);
    
    // Find returns by status
    List<ReturnRefundEntity> findByReturnStatus(ReturnStatus status);
    
    // Find returns by status with pagination
    Page<ReturnRefundEntity> findByReturnStatus(ReturnStatus status, Pageable pageable);
    
    // Find all returns for an order
    @Query("SELECT r FROM ReturnRefundEntity r WHERE r.orderItemId IN " +
           "(SELECT od.orderItemId FROM OrderDetailEntity od WHERE od.orderId = :orderId)")
    List<ReturnRefundEntity> findByOrderId(@Param("orderId") Integer orderId);
    
    // Check if return already requested for order item
    boolean existsByOrderItemId(Integer orderItemId);
    
    // Count returns by status
    @Query("SELECT COUNT(r) FROM ReturnRefundEntity r WHERE r.returnStatus = :status")
    Long countByReturnStatus(@Param("status") ReturnStatus status);
    
    // Get pending returns
    @Query("SELECT r FROM ReturnRefundEntity r WHERE r.returnStatus = 'REQUESTED' ORDER BY r.requestedAt ASC")
    List<ReturnRefundEntity> findPendingReturns();
    
    // Get pending returns with pagination
    Page<ReturnRefundEntity> findByReturnStatusOrderByRequestedAtAsc(ReturnStatus status, Pageable pageable);
    
    // Get return statistics
    @Query("SELECT r.returnStatus, COUNT(r) FROM ReturnRefundEntity r GROUP BY r.returnStatus")
    List<Object[]> getReturnStatistics();
    
    // Get monthly return requests
    @Query("SELECT MONTH(r.requestedAt), COUNT(r) FROM ReturnRefundEntity r " +
           "WHERE YEAR(r.requestedAt) = :year GROUP BY MONTH(r.requestedAt)")
    List<Object[]> getMonthlyReturnRequests(@Param("year") int year);
    
    // Get returns between dates
    @Query("SELECT r FROM ReturnRefundEntity r WHERE r.requestedAt BETWEEN :startDate AND :endDate")
    List<ReturnRefundEntity> findByRequestedAtBetween(@Param("startDate") LocalDateTime startDate,
                                                      @Param("endDate") LocalDateTime endDate);
    
    // Get returns by customer
    @Query("SELECT r FROM ReturnRefundEntity r WHERE r.orderItemId IN " +
           "(SELECT od.orderItemId FROM OrderDetailEntity od WHERE od.orderId IN " +
           "(SELECT o.orderId FROM OrderEntity o WHERE o.customerId = :customerId))")
    List<ReturnRefundEntity> findByCustomerId(@Param("customerId") Integer customerId);
}