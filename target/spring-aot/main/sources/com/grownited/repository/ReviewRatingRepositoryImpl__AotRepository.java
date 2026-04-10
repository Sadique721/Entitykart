package com.grownited.repository;

import com.grownited.entity.ReviewRatingEntity;
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
 * AOT generated JPA repository implementation for {@link ReviewRatingRepository}.
 */
@Generated
public class ReviewRatingRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public ReviewRatingRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#countDistinctCustomers()}.
   */
  public Long countDistinctCustomers() {
    String queryString = "SELECT COUNT(DISTINCT r.customerId) FROM ReviewRatingEntity r";
    Query query = this.entityManager.createQuery(queryString);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#countProductsWithReviews()}.
   */
  public Long countProductsWithReviews() {
    String queryString = "SELECT COUNT(DISTINCT r.productId) FROM ReviewRatingEntity r";
    Query query = this.entityManager.createQuery(queryString);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#existsByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public boolean existsByCustomerIdAndProductId(Integer customerId, Integer productId) {
    String queryString = "SELECT r.reviewId reviewId FROM ReviewRatingEntity r WHERE r.customerId = :customerId AND r.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);
    query.setMaxResults(1);

    return !query.getResultList().isEmpty();
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findByCustomerId(java.lang.Integer)}.
   */
  public List<ReviewRatingEntity> findByCustomerId(Integer customerId) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.customerId = :customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<ReviewRatingEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findByCustomerIdAndProductId(java.lang.Integer,java.lang.Integer)}.
   */
  public Optional<ReviewRatingEntity> findByCustomerIdAndProductId(Integer customerId,
      Integer productId) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.customerId = :customerId AND r.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);
    query.setParameter("productId", productId);

    return Optional.ofNullable((ReviewRatingEntity) convertOne(query.getSingleResultOrNull(), false, ReviewRatingEntity.class));
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findByCustomerIdOrderByCreatedAtDesc(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ReviewRatingEntity> findByCustomerIdOrderByCreatedAtDesc(Integer customerId,
      Pageable pageable) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.customerId = :customerId ORDER BY r.createdAt desc";
    String countQueryString = "SELECT COUNT(r) FROM ReviewRatingEntity r WHERE r.customerId = :customerId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReviewRatingEntity.class);
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

    return PageableExecutionUtils.getPage((List<ReviewRatingEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findByProductIdOrderByCreatedAtDesc(java.lang.Integer)}.
   */
  public List<ReviewRatingEntity> findByProductIdOrderByCreatedAtDesc(Integer productId) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.productId = :productId ORDER BY r.createdAt desc";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (List<ReviewRatingEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findByProductIdOrderByCreatedAtDesc(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ReviewRatingEntity> findByProductIdOrderByCreatedAtDesc(Integer productId,
      Pageable pageable) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.productId = :productId ORDER BY r.createdAt desc";
    String countQueryString = "SELECT COUNT(r) FROM ReviewRatingEntity r WHERE r.productId = :productId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReviewRatingEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("productId", productId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ReviewRatingEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findReviewsWithUserDetails(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public List<Object[]> findReviewsWithUserDetails(Integer productId, Pageable pageable) {
    String queryString = "SELECT r, u.name, u.profilePicURL FROM ReviewRatingEntity r JOIN UserEntity u ON r.customerId = u.userId WHERE r.productId = :productId ORDER BY r.createdAt DESC";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReviewRatingEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#findTop10ByOrderByCreatedAtDesc()}.
   */
  public List<ReviewRatingEntity> findTop10ByOrderByCreatedAtDesc() {
    String queryString = "SELECT r FROM ReviewRatingEntity r ORDER BY r.createdAt desc";
    Query query = this.entityManager.createQuery(queryString);
    if (query.getMaxResults() != Integer.MAX_VALUE) {
      if (query.getMaxResults() > 10 && query.getFirstResult() > 0) {
        query.setFirstResult(query.getFirstResult() - (query.getMaxResults() - 10));
      }
    }
    query.setMaxResults(10);

    return (List<ReviewRatingEntity>) query.getResultList();
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getAverageRatingForProduct(java.lang.Integer)}.
   */
  public Double getAverageRatingForProduct(Integer productId) {
    String queryString = "SELECT COALESCE(AVG(r.rating), 0) FROM ReviewRatingEntity r WHERE r.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getCustomerReviewSummary(java.lang.Integer)}.
   */
  public List<Object[]> getCustomerReviewSummary(Integer customerId) {
    String queryString = "SELECT r.customerId, AVG(r.rating), COUNT(r) FROM ReviewRatingEntity r WHERE r.customerId = :customerId GROUP BY r.customerId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("customerId", customerId);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getMonthlyReviewStats(int)}.
   */
  public List<Object[]> getMonthlyReviewStats(int year) {
    String queryString = "SELECT MONTH(r.createdAt), COUNT(r) FROM ReviewRatingEntity r WHERE YEAR(r.createdAt) = :year GROUP BY MONTH(r.createdAt) ORDER BY MONTH(r.createdAt)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("year", year);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getOverallAverageRating()}.
   */
  public Double getOverallAverageRating() {
    String queryString = "SELECT COALESCE(AVG(r.rating), 0) FROM ReviewRatingEntity r";
    Query query = this.entityManager.createQuery(queryString);

    return (Double) convertOne(query.getSingleResultOrNull(), false, Double.class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getRatingDistribution(java.lang.Integer)}.
   */
  public List<Object[]> getRatingDistribution(Integer productId) {
    String queryString = "SELECT r.rating, COUNT(r) FROM ReviewRatingEntity r WHERE r.productId = :productId GROUP BY r.rating ORDER BY r.rating";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getRatingDistributionAll()}.
   */
  public List<Object[]> getRatingDistributionAll() {
    String queryString = "SELECT r.rating, COUNT(r) FROM ReviewRatingEntity r GROUP BY r.rating ORDER BY r.rating";
    Query query = this.entityManager.createQuery(queryString);

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getReviewCountForProduct(java.lang.Integer)}.
   */
  public Long getReviewCountForProduct(Integer productId) {
    String queryString = "SELECT COUNT(r) FROM ReviewRatingEntity r WHERE r.productId = :productId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#getTopRatedProducts(org.springframework.data.domain.Pageable)}.
   */
  public List<Object[]> getTopRatedProducts(Pageable pageable) {
    String queryString = "SELECT r.productId, AVG(r.rating) as avgRating, COUNT(r) as reviewCount FROM ReviewRatingEntity r GROUP BY r.productId HAVING COUNT(r) >= 3 ORDER BY avgRating DESC, reviewCount DESC";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ReviewRatingEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }

    return (List<Object[]>) convertMany(query.getResultList(), false, Object[].class);
  }

  /**
   * AOT generated implementation of {@link ReviewRatingRepository#searchReviews(java.lang.Integer,java.lang.String)}.
   */
  public List<ReviewRatingEntity> searchReviews(Integer productId, String keyword) {
    String queryString = "SELECT r FROM ReviewRatingEntity r WHERE r.productId = :productId AND LOWER(r.comment) LIKE LOWER(CONCAT('%', :keyword, '%'))";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("productId", productId);
    query.setParameter("keyword", keyword);

    return (List<ReviewRatingEntity>) query.getResultList();
  }
}
