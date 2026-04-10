package com.grownited.repository;

import com.grownited.entity.ReturnRefundEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Integer;
import java.lang.Long;
import java.lang.Object;
import java.lang.String;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.function.LongSupplier;
import org.springframework.aot.generate.Generated;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.DeclaredQuery;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;
import org.springframework.data.support.PageableExecutionUtils;

/**
 * AOT generated JPA repository implementation for {@link ReturnRefundRepository}.
 */
@Generated
public class ReturnRefundRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public ReturnRefundRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#countByReturnStatus(com.grownited.entity.ReturnRefundEntity$ReturnStatus)}.
   */
  public Long countByReturnStatus(ReturnRefundEntity.ReturnStatus status) {
    String queryString = "SELECT COUNT(r) FROM ReturnRefundEntity r WHERE r.returnStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#existsByOrderItemId(java.lang.Integer)}.
   */
  public boolean existsByOrderItemId(Integer orderItemId) {
    String queryString = "SELECT r.returnId returnId FROM ReturnRefundEntity r WHERE r.orderItemId = :orderItemId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderItemId", orderItemId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByCustomerId(java.lang.Integer)}.
   */
  public List<ReturnRefundEntity> findByCustomerId(Integer customerId) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.orderItemId IN (SELECT od.orderItemId FROM OrderDetailEntity od WHERE od.orderId IN (SELECT o.orderId FROM OrderEntity o WHERE o.customerId = :customerId))";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<ReturnRefundEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByOrderId(java.lang.Integer)}.
   */
  public List<ReturnRefundEntity> findByOrderId(Integer orderId) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.orderItemId IN (SELECT od.orderItemId FROM OrderDetailEntity od WHERE od.orderId = :orderId)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    return (List<ReturnRefundEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByOrderItemId(java.lang.Integer)}.
   */
  public Optional<ReturnRefundEntity> findByOrderItemId(Integer orderItemId) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.orderItemId = :orderItemId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderItemId", orderItemId);

    return Optional.ofNullable((ReturnRefundEntity) convertOne(query.getSingleResultOrNull(), false, ReturnRefundEntity.class));
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByRequestedAtBetween(java.time.LocalDateTime,java.time.LocalDateTime)}.
   */
  public List<ReturnRefundEntity> findByRequestedAtBetween(LocalDateTime startDate,
      LocalDateTime endDate) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.requestedAt BETWEEN :startDate AND :endDate";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("startDate", startDate);
    query.setParameter("endDate", endDate);

    return (List<ReturnRefundEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByReturnStatus(com.grownited.entity.ReturnRefundEntity$ReturnStatus)}.
   */
  public List<ReturnRefundEntity> findByReturnStatus(ReturnRefundEntity.ReturnStatus status) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.returnStatus = :status";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);

    return (List<ReturnRefundEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByReturnStatus(com.grownited.entity.ReturnRefundEntity$ReturnStatus,org.springframework.data.domain.Pageable)}.
   */
  public Page<ReturnRefundEntity> findByReturnStatus(ReturnRefundEntity.ReturnStatus status,
      Pageable pageable) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.returnStatus = :status";
    String countQueryString = "SELECT COUNT(r) FROM ReturnRefundEntity r WHERE r.returnStatus = :status";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReturnRefundEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("status", status);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ReturnRefundEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findByReturnStatusOrderByRequestedAtAsc(com.grownited.entity.ReturnRefundEntity$ReturnStatus,org.springframework.data.domain.Pageable)}.
   */
  public Page<ReturnRefundEntity> findByReturnStatusOrderByRequestedAtAsc(
      ReturnRefundEntity.ReturnStatus status, Pageable pageable) {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.returnStatus = :status ORDER BY r.requestedAt asc";
    String countQueryString = "SELECT COUNT(r) FROM ReturnRefundEntity r WHERE r.returnStatus = :status";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReturnRefundEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("status", status);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("status", status);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ReturnRefundEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#findPendingReturns()}.
   */
  public List<ReturnRefundEntity> findPendingReturns() {
    String queryString = "SELECT r FROM ReturnRefundEntity r WHERE r.returnStatus = 'REQUESTED' ORDER BY r.requestedAt ASC";
    Query query = this.entityManager.createQuery(queryString);

    return (List<ReturnRefundEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#getMonthlyReturnRequests(int)}.
   */
  public List<Object[]> getMonthlyReturnRequests(int year) {
    String queryString = "SELECT MONTH(r.requestedAt), COUNT(r) FROM ReturnRefundEntity r WHERE YEAR(r.requestedAt) = :year GROUP BY MONTH(r.requestedAt)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("year", year);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReturnRefundRepository#getReturnStatistics()}.
   */
  public List<Object[]> getReturnStatistics() {
    String queryString = "SELECT r.returnStatus, COUNT(r) FROM ReturnRefundEntity r GROUP BY r.returnStatus";
    Query query = this.entityManager.createQuery(queryString);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }
}
