package com.grownited.repository;

import com.grownited.entity.SubCategoryEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.List;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link SubCategoryRepository}.
 */
@Generated
public class SubCategoryRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public SubCategoryRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link SubCategoryRepository#countByCategoryId(java.lang.Integer)}.
   */
  public Long countByCategoryId(Integer categoryId) {
    String queryString = "SELECT COUNT(s) FROM SubCategoryEntity s WHERE s.categoryId = :categoryId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link SubCategoryRepository#findByCategoryId(java.lang.Integer)}.
   */
  public List<SubCategoryEntity> findByCategoryId(Integer categoryId) {
    String queryString = "SELECT s FROM SubCategoryEntity s WHERE s.categoryId = :categoryId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);

    return (List<SubCategoryEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link SubCategoryRepository#findByCategoryIdAndActiveTrue(java.lang.Integer)}.
   */
  public List<SubCategoryEntity> findByCategoryIdAndActiveTrue(Integer categoryId) {
    String queryString = "SELECT s FROM SubCategoryEntity s WHERE s.categoryId = :categoryId AND s.active = TRUE";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);

    return (List<SubCategoryEntity>) query.getResultList();
  }
}
