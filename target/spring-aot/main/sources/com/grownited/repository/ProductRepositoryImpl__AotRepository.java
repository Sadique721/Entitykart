package com.grownited.repository;

import com.grownited.entity.ProductEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.lang.Double;
import java.lang.Float;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.List;
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
 * AOT generated JPA repository implementation for {@link ProductRepository}.
 */
@Generated
public class ProductRepositoryImpl__AotRepository extends AotRepositoryFragmentSupport {
  private final RepositoryFactoryBeanSupport.FragmentCreationContext context;

  private final EntityManager entityManager;

  public ProductRepositoryImpl__AotRepository(EntityManager entityManager,
      RepositoryFactoryBeanSupport.FragmentCreationContext context) {
    super(QueryEnhancerSelector.DEFAULT_SELECTOR, context);
    this.entityManager = entityManager;
    this.context = context;
  }

  /**
   * AOT generated implementation of {@link ProductRepository#countByCategoryId(java.lang.Integer)}.
   */
  public Long countByCategoryId(Integer categoryId) {
    String queryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.categoryId = :categoryId";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#countBySubCategoryId(java.lang.String)}.
   */
  public long countBySubCategoryId(String valueOf) {
    String queryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.subCategoryId = :valueOf";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("valueOf", valueOf);

    return (Long) convertOne(query.getSingleResultOrNull(), false, Long.class);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByBrand(java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByBrand(String brand, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.brand = :brand";
    String countQueryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.brand = :brand";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("brand", brand);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("brand", brand);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByCategoryId(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByCategoryId(Integer categoryId, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.categoryId = :categoryId";
    String countQueryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.categoryId = :categoryId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("categoryId", categoryId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByPriceRange(java.lang.Float,java.lang.Float,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByPriceRange(Float minPrice, Float maxPrice, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.price BETWEEN :minPrice AND :maxPrice";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE p.price BETWEEN :minPrice AND :maxPrice";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("minPrice", minPrice);
    query.setParameter("maxPrice", maxPrice);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("minPrice", minPrice);
      countQuery.setParameter("maxPrice", maxPrice);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByProductNameContainingIgnoreCase(java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByProductNameContainingIgnoreCase(String search,
      Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%'))";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%'))";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("search", search);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("search", search);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByStatus(java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByStatus(String status, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.status = :status";
    String countQueryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.status = :status";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
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

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findBySubCategoryId(java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findBySubCategoryId(String subCategoryId, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.subCategoryId = :subCategoryId";
    String countQueryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.subCategoryId = :subCategoryId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("subCategoryId", subCategoryId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("subCategoryId", subCategoryId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findByUserId(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findByUserId(Integer userId, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.userId = :userId";
    String countQueryString = "SELECT COUNT(p) FROM ProductEntity p WHERE p.userId = :userId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("userId", userId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("userId", userId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findDealProducts(org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findDealProducts(Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.discountPercent > 20 ORDER BY p.discountPercent DESC";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE p.discountPercent > 20";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findDistinctBrandsByCategory(java.lang.Integer)}.
   */
  public List<String> findDistinctBrandsByCategory(Integer categoryId) {
    String queryString = "SELECT DISTINCT p.brand FROM ProductEntity p WHERE p.brand IS NOT NULL AND (:categoryId IS NULL OR p.categoryId = :categoryId)";
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);

    return (List<String>) convertMany(query.getResultList(), false, String.class);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findFeaturedProducts(org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findFeaturedProducts(Pageable pageable) {
    String queryString = "SELECT p.* FROM product p LEFT JOIN order_details od ON p.product_id = od.product_id GROUP BY p.product_id ORDER BY COUNT(od.order_item_id) DESC, p.created_at DESC";
    String countQueryString = "select count(p.*) FROM product p LEFT JOIN order_details od ON p.product_id = od.product_id GROUP BY p.product_id";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.nativeQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createNativeQuery(queryString, ProductEntity.class);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createNativeQuery(countQueryString, Long.class);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findFrequentlyBoughtTogether(java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findFrequentlyBoughtTogether(Integer productId, Pageable pageable) {
    String queryString = "SELECT p.* FROM product p JOIN order_details od ON p.product_id = od.product_id WHERE od.order_id IN (   SELECT DISTINCT order_id FROM order_details WHERE product_id = :productId) AND p.product_id != :productId GROUP BY p.product_id ORDER BY COUNT(*) DESC";
    String countQueryString = "select count(p.*) FROM product p JOIN order_details od ON p.product_id = od.product_id WHERE od.order_id IN (   SELECT DISTINCT order_id FROM order_details WHERE product_id = :productId) AND p.product_id != :productId GROUP BY p.product_id";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.nativeQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createNativeQuery(queryString, ProductEntity.class);
    query.setParameter("productId", productId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createNativeQuery(countQueryString, Long.class);
      countQuery.setParameter("productId", productId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findInStockProducts(org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findInStockProducts(Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.stockQuantity > 0";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE p.stockQuantity > 0";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findLowStockProducts(org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findLowStockProducts(Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.stockQuantity > 0 AND p.stockQuantity < 10";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE p.stockQuantity > 0 AND p.stockQuantity < 10";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findMaxPrice()}.
   */
  public Float findMaxPrice() {
    String queryString = "SELECT MAX(p.price) FROM ProductEntity p";
    Query query = this.entityManager.createQuery(queryString);

    return (Float) convertOne(query.getSingleResultOrNull(), false, Float.class);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findMinPrice()}.
   */
  public Float findMinPrice() {
    String queryString = "SELECT MIN(p.price) FROM ProductEntity p";
    Query query = this.entityManager.createQuery(queryString);

    return (Float) convertOne(query.getSingleResultOrNull(), false, Float.class);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findSimilarProducts(java.lang.Integer,java.lang.Integer,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findSimilarProducts(Integer categoryId, Integer productId,
      Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE p.categoryId = :categoryId AND p.productId != :productId ORDER BY p.createdAt DESC";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE p.categoryId = :categoryId AND p.productId != :productId";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);
    query.setParameter("productId", productId);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("categoryId", categoryId);
      countQuery.setParameter("productId", productId);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#findWithFilters(java.lang.Integer,java.lang.String,java.lang.Double,java.lang.Double,java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> findWithFilters(Integer categoryId, String brand, Double minPrice,
      Double maxPrice, String inStock, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE (:categoryId IS NULL OR p.categoryId = :categoryId) AND (:brand IS NULL OR p.brand = :brand) AND (:minPrice IS NULL OR p.price >= :minPrice) AND (:maxPrice IS NULL OR p.price <= :maxPrice) AND (:inStock IS NULL OR (:inStock = 'true' AND p.stockQuantity > 0))";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE (:categoryId IS NULL OR p.categoryId = :categoryId) AND (:brand IS NULL OR p.brand = :brand) AND (:minPrice IS NULL OR p.price >= :minPrice) AND (:maxPrice IS NULL OR p.price <= :maxPrice) AND (:inStock IS NULL OR (:inStock = 'true' AND p.stockQuantity > 0))";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("categoryId", categoryId);
    query.setParameter("brand", brand);
    query.setParameter("minPrice", minPrice);
    query.setParameter("maxPrice", maxPrice);
    query.setParameter("inStock", inStock);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("categoryId", categoryId);
      countQuery.setParameter("brand", brand);
      countQuery.setParameter("minPrice", minPrice);
      countQuery.setParameter("maxPrice", maxPrice);
      countQuery.setParameter("inStock", inStock);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }

  /**
   * AOT generated implementation of {@link ProductRepository#searchProducts(java.lang.String,org.springframework.data.domain.Pageable)}.
   */
  public Page<ProductEntity> searchProducts(String search, Pageable pageable) {
    String queryString = "SELECT p FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :search, '%'))";
    String countQueryString = "SELECT count(p) FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :search, '%'))";
    Pageable pageable_1 = pageable != null ? pageable : Pageable.unpaged();
    if (pageable_1.getSort().isSorted()) {
      DeclaredQuery declaredQuery = DeclaredQuery.jpqlQuery(queryString);
      queryString = rewriteQuery(declaredQuery, pageable_1.getSort(), ProductEntity.class);
    }
    Query query = this.entityManager.createQuery(queryString);
    query.setParameter("search", search);
    if (pageable_1.isPaged()) {
      query.setFirstResult(Long.valueOf(pageable_1.getOffset()).intValue());
      query.setMaxResults(pageable_1.getPageSize());
    }
    LongSupplier countAll = () -> {
      Query countQuery = this.entityManager.createQuery(countQueryString);
      countQuery.setParameter("search", search);
      return getCount(countQuery);
    };

    return PageableExecutionUtils.getPage((List<ProductEntity>) query.getResultList(), pageable_1, countAll);
  }
}
