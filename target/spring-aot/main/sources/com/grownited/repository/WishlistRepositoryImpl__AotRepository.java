package com.grownited.repository;

import com.grownited.entity.WishlistEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Double;
import java.lang.Integer;
import java.lang.Long;
import java.lang.Object;
import java.lang.String;
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
 * AOT generated JPA repository implementation for {@link WishlistRepository}.
 */
@Generated
public class WishlistRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public WishlistRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#countByCustomerId(java.lang.Integer)}.
   */
  public Long countByCustomerId(Integer customerId) {
    String queryString = "SELECT COUNT(w) FROM WishlistEntity w WHERE w.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#countUsersWithWishlist()}.
   */
  public Long countUsersWithWishlist() {
    String queryString = "SELECT COUNT(DISTINCT w.customerId) FROM WishlistEntity w";
    Query query = this.entityManager.createQuery(queryString);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#deleteByCustomerId(java.lang.Integer)}.
   */
  public void deleteByCustomerId(Integer customerId) {
    String queryString = "SELECT w FROM WishlistEntity w WHERE w.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#deleteByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public void deleteByCustomerIdAndProductId(Integer customerId, Integer productId) {
    String queryString = "SELECT w FROM WishlistEntity w WHERE w.customerId = :customerId AND w.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);

    List resultList = query.getResultList();
    resultList.forEach(entityManager::remove);
    return;
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#existsByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public boolean existsByCustomerIdAndProductId(Integer customerId, Integer productId) {
    String queryString = "SELECT w.wishlistId wishlistId FROM WishlistEntity w WHERE w.customerId = :customerId AND w.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findByCustomerId(java.lang.Integer)}.
   */
  public List<WishlistEntity> findByCustomerId(Integer customerId) {
    String queryString = "SELECT w FROM WishlistEntity w WHERE w.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<WishlistEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public Optional<WishlistEntity> findByCustomerIdAndProductId(Integer customerId,
      Integer productId) {
    String queryString = "SELECT w FROM WishlistEntity w WHERE w.customerId = :customerId AND w.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);

    return Optional.ofNullable((WishlistEntity) convertOne(query.getSingleResultOrNull(), false, WishlistEntity.class));
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findByCustomerIdOrderByAddedAtDesc(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<WishlistEntity> findByCustomerIdOrderByAddedAtDesc(Integer customerId,
      Pageable pageable) {
    String queryString = "SELECT w FROM WishlistEntity w WHERE w.customerId = :customerId ORDER BY w.addedAt desc";
    String countQueryString = "SELECT COUNT(w) FROM WishlistEntity w WHERE w.customerId = :customerId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), WishlistEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("customerId", customerId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<WishlistEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findWishlistWithProductDetails(java.lang.Integer)}.
   */
  public List<Object[]> findWishlistWithProductDetails(Integer customerId) {
    String queryString = "SELECT w, p.productName, CAST(p.price AS float), p.mainImageURL, p.stockQuantity FROM WishlistEntity w JOIN ProductEntity p ON w.productId = p.productId WHERE w.customerId = :customerId ORDER BY w.addedAt DESC";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findWishlistWithProductDetails(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<Object[]> findWishlistWithProductDetails(Integer customerId, Pageable pageable) {
    String queryString = "SELECT w, p.productName, CAST(p.price AS float), p.mainImageURL, p.stockQuantity FROM WishlistEntity w JOIN ProductEntity p ON w.productId = p.productId WHERE w.customerId = :customerId ORDER BY w.addedAt DESC";
    String countQueryString = "SELECT count(w) FROM WishlistEntity w JOIN ProductEntity p ON w.productId = p.productId WHERE w.customerId = :customerId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), WishlistEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("customerId", customerId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<Object[]>) convertMany(query.getResultList(), false, Object[].class), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#findWishlistedProductIds(java.lang.Integer,java.util.List)}.
   */
  public List<Integer> findWishlistedProductIds(Integer customerId, List<Integer> productIds) {
    String queryString = "SELECT w.productId FROM WishlistEntity w WHERE w.customerId = :customerId AND w.productId IN :productIds";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productIds", productIds);

    return (List<Integer>) convertMany(query.getResultList(), false, Integer.class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#getAverageWishlistSize()}.
   */
  public Double getAverageWishlistSize() {
    String queryString = "SELECT AVG(wcount) FROM (SELECT COUNT(w) as wcount FROM WishlistEntity w GROUP BY w.customerId)";
    Query query = this.entityManager.createQuery(queryString);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#getMostWishlistedProducts(org.springframework.data.domain.Pageable)}.
   */
  public List<Object[]> getMostWishlistedProducts(Pageable pageable) {
    String queryString = "SELECT w.productId, COUNT(w) as wishlistCount FROM WishlistEntity w GROUP BY w.productId ORDER BY wishlistCount DESC";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), WishlistEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link WishlistRepository#getWishlistCountsForProducts(java.util.List)}.
   */
  public List<Object[]> getWishlistCountsForProducts(List<Integer> productIds) {
    String queryString = "SELECT w.productId, COUNT(w) FROM WishlistEntity w WHERE w.productId IN :productIds GROUP BY w.productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productIds", productIds);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }
}
