package com.grownited.repository;

import com.grownited.entity.OrderEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Double;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.List;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link OrderRepository}.
 */
@Generated
public class OrderRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public OrderRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link OrderRepository#countByOrderStatus(com.grownited.entity.OrderEntity$OrderStatus)}.
   */
  public Long countByOrderStatus(OrderEntity.OrderStatus status) {
    String queryString = "SELECT COUNT(o) FROM OrderEntity o WHERE o.orderStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link OrderRepository#existsByCustomerId(java.lang.Integer)}.
   */
  public boolean existsByCustomerId(Integer customerId) {
    String queryString = "SELECT o.orderId orderId FROM OrderEntity o WHERE o.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findByCustomerId(java.lang.Integer)}.
   */
  public List<OrderEntity> findByCustomerId(Integer customerId) {
    String queryString = "SELECT o FROM OrderEntity o WHERE o.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findByCustomerIdAndOrderStatus(java.lang.Integer,com.grownited.entity.OrderEntity$OrderStatus)}.
   */
  public List<OrderEntity> findByCustomerIdAndOrderStatus(Integer customerId,
      OrderEntity.OrderStatus status) {
    String queryString = "SELECT o FROM OrderEntity o WHERE o.customerId = :customerId AND o.orderStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("status", status);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findByCustomerIdOrderByOrderDateDesc(java.lang.Integer)}.
   */
  public List<OrderEntity> findByCustomerIdOrderByOrderDateDesc(Integer customerId) {
    String queryString = "SELECT o FROM OrderEntity o WHERE o.customerId = :customerId ORDER BY o.orderDate desc";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findByOrderStatus(com.grownited.entity.OrderEntity$OrderStatus)}.
   */
  public List<OrderEntity> findByOrderStatus(OrderEntity.OrderStatus status) {
    String queryString = "SELECT o FROM OrderEntity o WHERE o.orderStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findByPaymentStatus(com.grownited.entity.OrderEntity$PaymentStatus)}.
   */
  public List<OrderEntity> findByPaymentStatus(OrderEntity.PaymentStatus paymentStatus) {
    String queryString = "SELECT o FROM OrderEntity o WHERE o.paymentStatus = :paymentStatus";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("paymentStatus", paymentStatus);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#findTop10ByOrderByOrderDateDesc()}.
   */
  public List<OrderEntity> findTop10ByOrderByOrderDateDesc() {
    String queryString = "SELECT o FROM OrderEntity o ORDER BY o.orderDate desc";
    Query query = this.entityManager.createQuery(queryString);
    if (query.getMaxResults() != Integer.MAX_VALUE) {
      if (query.getMaxResults() > 10 && query.getFirstResult() > 0) {
        query.setFirstResult(query.getFirstResult() - (query.getMaxResults() - 10));
      }
    }
    query.setMaxResults(10);

    return (List<OrderEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderRepository#getTotalRevenue()}.
   */
  public Double getTotalRevenue() {
    String queryString = "SELECT COALESCE(SUM(o.totalAmount), 0) FROM OrderEntity o WHERE o.paymentStatus = 'PAID'";
    Query query = this.entityManager.createQuery(queryString);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }
}
