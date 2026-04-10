package com.grownited.repository;

import com.grownited.entity.AddressEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Integer;
import java.lang.String;
import java.util.List;
import java.util.Optional;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link AddressRepository}.
 */
@Generated
public class AddressRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public AddressRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link AddressRepository#findByUserId(java.lang.Integer)}.
   */
  public List<AddressEntity> findByUserId(Integer userId) {
    String queryString = "SELECT a FROM AddressEntity a WHERE a.userId = :userId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("userId", userId);

    return (List<AddressEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link AddressRepository#findByUserIdAndIsDefaultTrue(java.lang.Integer)}.
   */
  public Optional<AddressEntity> findByUserIdAndIsDefaultTrue(Integer userId) {
    String queryString = "SELECT a FROM AddressEntity a WHERE a.userId = :userId AND a.isDefault = TRUE";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("userId", userId);

    return Optional.ofNullable((AddressEntity) convertOne(query.getSingleResultOrNull(), false, AddressEntity.class));
  }
}
