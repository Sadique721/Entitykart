package com.grownited.repository;

import com.grownited.entity.OrderDetailEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Integer;
import java.lang.Object;
import java.lang.String;
import java.util.List;
import org.springframework.aot.generate.Generated;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.DeclaredQuery;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link OrderDetailRepository}.
 */
@Generated
public class OrderDetailRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public OrderDetailRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#deleteByOrderId(java.lang.Integer)}.
   */
  public void deleteByOrderId(Integer orderId) {
    String queryString = "SELECT o FROM OrderDetailEntity o WHERE o.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#findByOrderId(java.lang.Integer)}.
   */
  public List<OrderDetailEntity> findByOrderId(Integer orderId) {
    String queryString = "SELECT o FROM OrderDetailEntity o WHERE o.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    return (List<OrderDetailEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#findByProductId(java.lang.Integer)}.
   */
  public List<OrderDetailEntity> findByProductId(Integer productId) {
    String queryString = "SELECT o FROM OrderDetailEntity o WHERE o.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (List<OrderDetailEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#findOrderDetailsWithProductInfo(java.lang.Integer)}.
   */
  public List<Object[]> findOrderDetailsWithProductInfo(Integer orderId) {
    String queryString = "SELECT od, p.productName, p.mainImageURL FROM OrderDetailEntity od JOIN ProductEntity p ON od.productId = p.productId WHERE od.orderId = :orderId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("orderId", orderId);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#findTopSellingProducts(org.springframework.data.domain.Pageable)}.
   */
  public List<Object[]> findTopSellingProducts(Pageable pageable) {
    String queryString = "SELECT od.productId, SUM(od.quantity) as totalSold FROM OrderDetailEntity od GROUP BY od.productId ORDER BY totalSold DESC";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), OrderDetailEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#getBestSellingProducts()}.
   */
  public List<Object[]> getBestSellingProducts() {
    String queryString = "SELECT od.productId, SUM(od.quantity) as totalSold FROM OrderDetailEntity od GROUP BY od.productId ORDER BY totalSold DESC";
    Query query = this.entityManager.createQuery(queryString);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#getMonthlySales(int)}.
   */
  public List<Object[]> getMonthlySales(int year) {
    String queryString = "SELECT MONTH(od.createdAt), SUM(od.quantity * od.price) FROM OrderDetailEntity od WHERE YEAR(od.createdAt) = :year GROUP BY MONTH(od.createdAt)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("year", year);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link OrderDetailRepository#getTotalSoldQuantity(java.lang.Integer)}.
   */
  public Integer getTotalSoldQuantity(Integer productId) {
    String queryString = "SELECT COALESCE(SUM(od.quantity), 0) FROM OrderDetailEntity od WHERE od.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (Integer) convertOne(query.getSingleResultOrNull(), false, Integer.class);
  }
}
