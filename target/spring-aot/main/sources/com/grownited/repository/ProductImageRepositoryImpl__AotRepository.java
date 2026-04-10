package com.grownited.repository;

import com.grownited.entity.ProductImageEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.List;
import java.util.Optional;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link ProductImageRepository}.
 */
@Generated
public class ProductImageRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public ProductImageRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#countByProductId(java.lang.Integer)}.
   */
  public Long countByProductId(Integer productId) {
    String queryString = "SELECT COUNT(p) FROM ProductImageEntity p WHERE p.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#deleteByProductId(java.lang.Integer)}.
   */
  public void deleteByProductId(Integer productId) {
    String queryString = "SELECT p FROM ProductImageEntity p WHERE p.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#existsByProductId(java.lang.Integer)}.
   */
  public boolean existsByProductId(Integer productId) {
    String queryString = "SELECT p.productImageId productImageId FROM ProductImageEntity p WHERE p.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#findByProductIdAndIsPrimaryTrue(java.lang.Integer)}.
   */
  public Optional<ProductImageEntity> findByProductIdAndIsPrimaryTrue(Integer productId) {
    String queryString = "SELECT p FROM ProductImageEntity p WHERE p.productId = :productId AND p.isPrimary = TRUE";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return Optional.ofNullable((ProductImageEntity) convertOne(query.getSingleResultOrNull(), false, ProductImageEntity.class));
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#findByProductIdOrderByDisplayOrderAsc(java.lang.Integer)}.
   */
  public List<ProductImageEntity> findByProductIdOrderByDisplayOrderAsc(Integer productId) {
    String queryString = "SELECT p FROM ProductImageEntity p WHERE p.productId = :productId ORDER BY p.displayOrder asc";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (List<ProductImageEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#findGalleryImagesByProductId(java.lang.Integer)}.
   */
  public List<ProductImageEntity> findGalleryImagesByProductId(Integer productId) {
    String queryString = "SELECT p FROM ProductImageEntity p WHERE p.productId = :productId AND p.isPrimary = false ORDER BY p.displayOrder ASC";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (List<ProductImageEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#getMaxDisplayOrder(java.lang.Integer)}.
   */
  public Integer getMaxDisplayOrder(Integer productId) {
    String queryString = "SELECT COALESCE(MAX(p.displayOrder), 0) FROM ProductImageEntity p WHERE p.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (Integer) convertOne(query.getSingleResultOrNull(), false, Integer.class);
  }

  /**
   * AOT generated implementation of {@link ProductImageRepository#resetPrimaryForProduct(java.lang.Integer)}.
   */
  public void resetPrimaryForProduct(Integer productId) {
    String queryString = "UPDATE ProductImageEntity p SET p.isPrimary = false WHERE p.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    query.executeUpdate();
  }
}
