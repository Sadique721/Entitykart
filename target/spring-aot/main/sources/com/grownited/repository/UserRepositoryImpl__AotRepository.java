package com.grownited.repository;

import com.grownited.entity.UserEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.String;
import java.util.List;
import java.util.Optional;
import org.springframework.aot.generate.Generated;
import org.springframework.data.jpa.repository.aot.AotRepositoryFragmentSupport;
import org.springframework.data.jpa.repository.query.QueryEnhancerSelector;
import org.springframework.data.repository.core.support.RepositoryFactoryBeanSupport;

/**
 * AOT generated JPA repository implementation for {@link UserRepository}.
 */
@Generated
public class UserRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public UserRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link UserRepository#findByEmail(java.lang.String)}.
   */
  public Optional<UserEntity> findByEmail(String email) {
    String queryString = "SELECT u FROM UserEntity u WHERE u.email = :email";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("email", email);

    return Optional.ofNullable((UserEntity) convertOne(query.getSingleResultOrNull(), false, UserEntity.class));
  }

  /**
   * AOT generated implementation of {@link UserRepository#findByRole(java.lang.String)}.
   */
  public List<UserEntity> findByRole(String role) {
    String queryString = "SELECT u FROM UserEntity u WHERE u.role = :role";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("role", role);

    return (List<UserEntity>) query.getResultList();
  }
}
