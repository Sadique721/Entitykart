package com.grownited.repository;

import com.grownited.entity.PaymentEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Double;
import java.lang.Integer;
import java.lang.Long;
import java.lang.Object;
import java.lang.String;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link PaymentRepository}.
 */
@Generated
public class PaymentRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public PaymentRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#countByPaymentStatus(com.grownited.entity.PaymentEntity$PaymentGatewayStatus)}.
   */
  public Long countByPaymentStatus(PaymentEntity.PaymentGatewayStatus status) {
    String queryString = "SELECT COUNT(p) FROM PaymentEntity p WHERE p.paymentStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#deleteByOrderId(java.lang.Integer)}.
   */
  public void deleteByOrderId(Integer orderId) {
    String queryString = "SELECT p FROM PaymentEntity p WHERE p.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#existsByOrderId(java.lang.Integer)}.
   */
  public boolean existsByOrderId(Integer orderId) {
    String queryString = "SELECT p.paymentId paymentId FROM PaymentEntity p WHERE p.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#findByOrderId(java.lang.Integer)}.
   */
  public Optional<PaymentEntity> findByOrderId(Integer orderId) {
    String queryString = "SELECT p FROM PaymentEntity p WHERE p.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    return Optional.ofNullable((PaymentEntity) convertOne(query.getSingleResultOrNull(), false, PaymentEntity.class));
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#findByPaymentMode(com.grownited.entity.PaymentEntity$PaymentMode)}.
   */
  public List<PaymentEntity> findByPaymentMode(PaymentEntity.PaymentMode mode) {
    String queryString = "SELECT p FROM PaymentEntity p WHERE p.paymentMode = :mode";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("mode", mode);

    return (List<PaymentEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#findByPaymentStatus(com.grownited.entity.PaymentEntity$PaymentGatewayStatus)}.
   */
  public List<PaymentEntity> findByPaymentStatus(PaymentEntity.PaymentGatewayStatus status) {
    String queryString = "SELECT p FROM PaymentEntity p WHERE p.paymentStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (List<PaymentEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#getDailyRevenue(java.time.LocalDateTime,java.time.LocalDateTime)}.
   */
  public List<Object[]> getDailyRevenue(LocalDateTime startDate, LocalDateTime endDate) {
    String queryString = "SELECT DATE(p.paymentDate), COALESCE(SUM(p.amount), 0) FROM PaymentEntity p WHERE p.paymentStatus = 'SUCCESS' AND p.paymentDate BETWEEN :startDate AND :endDate GROUP BY DATE(p.paymentDate) ORDER BY DATE(p.paymentDate)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("startDate", startDate);
    query.setParameter("endDate", endDate);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#getRevenueByPaymentMode()}.
   */
  public List<Object[]> getRevenueByPaymentMode() {
    String queryString = "SELECT p.paymentMode, COALESCE(SUM(p.amount), 0) FROM PaymentEntity p WHERE p.paymentStatus = 'SUCCESS' GROUP BY p.paymentMode";
    Query query = this.entityManager.createQuery(queryString);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link PaymentRepository#getTotalRevenueBetweenDates(java.time.LocalDateTime,java.time.LocalDateTime)}.
   */
  public Double getTotalRevenueBetweenDates(LocalDateTime startDate, LocalDateTime endDate) {
    String queryString = "SELECT COALESCE(SUM(p.amount), 0) FROM PaymentEntity p WHERE p.paymentStatus = 'SUCCESS' AND p.paymentDate BETWEEN :startDate AND :endDate";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("startDate", startDate);
    query.setParameter("endDate", endDate);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }
}
