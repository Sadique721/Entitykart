package com.grownited.repository;

import com.grownited.entity.CartEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Double;
import java.lang.Integer;
import java.lang.Long;
import java.lang.Object;
import java.lang.String;
import java.util.List;
import java.util.Optional;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link CartRepository}.
 */
@Generated
public class CartRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public CartRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link CartRepository#clearCart(java.lang.Integer)}.
   */
  public void clearCart(Integer customerId) {
    String queryString = "DELETE FROM CartEntity c WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    query.executeUpdate();
  }

  /**
   * AOT generated implementation of {@link CartRepository#countByCustomerId(java.lang.Integer)}.
   */
  public Long countByCustomerId(Integer customerId) {
    String queryString = "SELECT COUNT(c) FROM CartEntity c WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link CartRepository#deleteByCustomerId(java.lang.Integer)}.
   */
  public void deleteByCustomerId(Integer customerId) {
    String queryString = "SELECT c FROM CartEntity c WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link CartRepository#deleteByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public void deleteByCustomerIdAndProductId(Integer customerId, Integer productId) {
    String queryString = "SELECT c FROM CartEntity c WHERE c.customerId = :customerId AND c.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link CartRepository#findByCustomerId(java.lang.Integer)}.
   */
  public List<CartEntity> findByCustomerId(Integer customerId) {
    String queryString = "SELECT c FROM CartEntity c WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<CartEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link CartRepository#findByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public Optional<CartEntity> findByCustomerIdAndProductId(Integer customerId, Integer productId) {
    String queryString = "SELECT c FROM CartEntity c WHERE c.customerId = :customerId AND c.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);

    return Optional.ofNullable((CartEntity) convertOne(query.getSingleResultOrNull(), false, CartEntity.class));
  }

  /**
   * AOT generated implementation of {@link CartRepository#findCartWithProductDetails(java.lang.Integer)}.
   */
  public List<Object[]> findCartWithProductDetails(Integer customerId) {
    String queryString = "SELECT c, p.productName, p.mainImageURL, p.stockQuantity FROM CartEntity c JOIN ProductEntity p ON c.productId = p.productId WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link CartRepository#getCartTotal(java.lang.Integer)}.
   */
  public Double getCartTotal(Integer customerId) {
    String queryString = "SELECT COALESCE(SUM(c.price * c.quantity), 0) FROM CartEntity c WHERE c.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }
}
