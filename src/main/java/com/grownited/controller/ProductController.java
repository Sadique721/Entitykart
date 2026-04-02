package com.grownited.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.ProductImageEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ProductImageRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.WishlistRepository;

import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ProductController {
    
    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
    
    private static final int DEFAULT_PAGE_SIZE = 12;
    private static final int ADMIN_PAGE_SIZE = 10;
    private static final int MAX_RECENTLY_VIEWED = 10;
    private static final int RELATED_PRODUCTS_LIMIT = 8;
    private static final int LOW_STOCK_THRESHOLD = 10;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubCategoryRepository subCategoryRepository;
    
    @Autowired
    private WishlistRepository wishlistRepository;
    
    @Autowired
    private ProductImageRepository productImageRepository;

    @Autowired
    private Cloudinary cloudinary;

    // ========================= HELPER METHODS =========================
    
    private boolean isAdmin(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole());
    }
    
    private UserEntity getCurrentUser(HttpSession session) {
        return (UserEntity) session.getAttribute("user");
    }
    
    private String getCategoryName(Integer categoryId) {
        if (categoryId == null) return "";
        return categoryRepository.findById(categoryId)
            .map(CategoryEntity::getCategoryName)
            .orElse("");
    }
    
    private Optional<String> getCategoryNameOptional(Integer categoryId) {
        if (categoryId == null) return Optional.empty();
        return categoryRepository.findById(categoryId)
            .map(CategoryEntity::getCategoryName);
    }
    
    private String getSubCategoryName(String subCategoryId) {
        if (subCategoryId == null || subCategoryId.isEmpty()) return "";
        try {
            Integer id = Integer.parseInt(subCategoryId);
            return subCategoryRepository.findById(id)
                .map(SubCategoryEntity::getChildCategory)
                .orElse("");
        } catch (NumberFormatException e) {
            logger.warn("Invalid subcategory ID format: {}", subCategoryId);
            return "";
        }
    }
    
    @GetMapping("/category/{categoryId}/subcategories")
    @ResponseBody
    public List<Map<String, Object>> getSubCategoriesByCategory(@PathVariable Integer categoryId) {
        System.out.println("Fetching subcategories for categoryId: " + categoryId);
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            List<SubCategoryEntity> subCategories = subCategoryRepository.findByCategoryId(categoryId);
            System.out.println("Found " + subCategories.size() + " subcategories");
            for (SubCategoryEntity sub : subCategories) {
                Map<String, Object> map = new HashMap<>();
                map.put("subCategoryId", sub.getSubCategoryId());
                map.put("subCategoryName", sub.getChildCategory());
                result.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    // FIXED: Proper implementation of calculateDiscountPercent
    private Float calculateDiscountPercent(Integer mrp, Float price) {
        if (mrp == null || mrp <= 0 || price == null || price <= 0) {
            return 0.0f;
        }
        if (price >= mrp) {
            return 0.0f;
        }
        float discount = ((mrp - price) / (float) mrp) * 100;
        return Math.round(discount * 100.0f) / 100.0f;
    }

    // ========================= API ENDPOINTS FOR ADMIN PRODUCTS =========================

    @GetMapping("/api/admin/product-stats")
    @ResponseBody
    public Map<String, Object> getProductStats() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalProducts = productRepository.count();
        long inStockCount = productRepository.findInStockProducts(Pageable.unpaged()).getTotalElements();
        long lowStockCount = productRepository.findLowStockProducts(Pageable.unpaged()).getTotalElements();
        long outOfStockCount = productRepository.findByStatus("Out of Stock", Pageable.unpaged()).getTotalElements();
        
        // Calculate total images
        long totalImages = 0;
        for (ProductEntity product : productRepository.findAll()) {
            totalImages += productImageRepository.countByProductId(product.getProductId());
        }
        
        stats.put("totalProducts", totalProducts);
        stats.put("inStockCount", inStockCount);
        stats.put("lowStockCount", lowStockCount);
        stats.put("outOfStockCount", outOfStockCount);
        stats.put("totalImages", totalImages);
        
        return stats;
    }

    @GetMapping("/api/admin/products")
    @ResponseBody
    public List<Map<String, Object>> getFilteredProducts(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String sort) {
        
        List<ProductEntity> products = new ArrayList<>();
        Pageable limit10 = PageRequest.of(0, 10);
        
        if ("inStock".equals(status)) {
            products = productRepository.findInStockProducts(limit10).getContent();
        } else if ("lowStock".equals(status)) {
            products = productRepository.findLowStockProducts(limit10).getContent();
        } else if ("outOfStock".equals(status)) {
            products = productRepository.findByStatus("Out of Stock", limit10).getContent();
        } else if ("recent".equals(sort)) {
            products = productRepository.findAll(PageRequest.of(0, 10, Sort.by("createdAt").descending())).getContent();
        } else if ("topSelling".equals(sort)) {
            products = productRepository.findFeaturedProducts(limit10).getContent();
        }
        
        return products.stream().map(product -> {
            Map<String, Object> map = new HashMap<>();
            map.put("productId", product.getProductId());
            map.put("productName", product.getProductName());
            map.put("brand", product.getBrand());
            map.put("price", product.getPrice());
            map.put("mrp", product.getMrp());
            map.put("stockQuantity", product.getStockQuantity());
            map.put("status", product.getStatus());
            map.put("mainImageURL", product.getMainImageURL());
            map.put("categoryName", getCategoryName(product.getCategoryId()));
            map.put("imageCount", productImageRepository.countByProductId(product.getProductId()));
            return map;
        }).collect(Collectors.toList());
    }

    @GetMapping("/api/admin/products/category-distribution")
    @ResponseBody
    public List<Map<String, Object>> getCategoryDistribution() {
        List<Map<String, Object>> distribution = new ArrayList<>();
        List<CategoryEntity> categories = categoryRepository.findAll();
        
        for (CategoryEntity category : categories) {
            long count = productRepository.countByCategoryId(category.getCategoryId());
            if (count > 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", category.getCategoryName());
                map.put("count", count);
                distribution.add(map);
            }
        }
        
        return distribution;
    }

    @GetMapping("/api/admin/products/subcategory-distribution")
    @ResponseBody
    public List<Map<String, Object>> getSubcategoryDistribution() {
        List<Map<String, Object>> distribution = new ArrayList<>();
        List<SubCategoryEntity> subcategories = subCategoryRepository.findAll();
        
        for (SubCategoryEntity subcategory : subcategories) {
            long count = productRepository.countBySubCategoryId(String.valueOf(subcategory.getSubCategoryId()));
            if (count > 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", subcategory.getChildCategory());
                map.put("count", count);
                distribution.add(map);
            }
        }
        
        // Sort by count descending
        distribution.sort((a, b) -> 
            Long.compare((Long) b.get("count"), (Long) a.get("count")));
        
        return distribution;
    }
    
    // ========================= ADMIN: LOAD ADD PRODUCT PAGE =========================
    @GetMapping("/admin/product/add")
    public String loadAddProductPage(
            @RequestParam(required = false) Integer categoryId,
            Model model,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            // Load all categories
            List<CategoryEntity> categoryList = categoryRepository.findAll();
            model.addAttribute("categoryList", categoryList);

            // 🔥 FILTER SUBCATEGORIES
            List<SubCategoryEntity> subCategories = new ArrayList<>();

            if (categoryId != null) {
                subCategories = subCategoryRepository.findByCategoryId(categoryId);
            }

            model.addAttribute("subCategoryList", subCategories);

            // Keep selected category
            model.addAttribute("selectedCategoryId", categoryId);

            model.addAttribute("product", new ProductEntity());

        } catch (Exception e) {
            model.addAttribute("error", "Unable to load form data");
        }

        return "adminAddProduct";
    }
    // ========================= ADMIN: SAVE PRODUCT =========================
    @PostMapping("/admin/product/save")
    public String saveProduct(ProductEntity productEntity,
                              @RequestParam("mainImage") MultipartFile mainImage,
                              @RequestParam(value = "additionalImages", required = false) MultipartFile[] additionalImages,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            logger.warn("Unauthorized attempt to save product");
            return "redirect:/login";
        }

        UserEntity currentUser = getCurrentUser(session);

        // Validate required fields
        if (productEntity.getProductName() == null || productEntity.getProductName().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Product name is required");
            return "redirect:/admin/product/add";
        }

        if (mainImage == null || mainImage.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Main product image is required");
            return "redirect:/admin/product/add";
        }

        try {
            // Set owner & created date
            productEntity.setUserId(currentUser.getUserId());
            productEntity.setCreatedAt(LocalDate.now());
            
            // Calculate discount percent
            productEntity.setDiscountPercent(calculateDiscountPercent(
                productEntity.getMrp(), productEntity.getPrice()));

            // Upload main image to Cloudinary
            try {
                Map<?, ?> uploadResult = cloudinary.uploader().upload(mainImage.getBytes(), 
                    ObjectUtils.asMap(
                        "folder", "entitykart/products/main",
                        "public_id", "product_" + System.currentTimeMillis()
                    ));
                String imageUrl = (String) uploadResult.get("secure_url");
                productEntity.setMainImageURL(imageUrl);
                logger.info("Main image uploaded successfully: {}", imageUrl);
            } catch (Exception e) {
                logger.error("Main image upload failed: {}", e.getMessage());
                redirectAttributes.addFlashAttribute("error", "Main image upload failed. Please try again.");
                return "redirect:/admin/product/add";
            }

            // Save product first to get ID
            ProductEntity savedProduct = productRepository.save(productEntity);
            logger.info("Product saved successfully with ID: {}", savedProduct.getProductId());
            
            // Upload additional images if any
            if (additionalImages != null && additionalImages.length > 0) {
                int displayOrder = 1;
                int uploadedCount = 0;
                
                for (MultipartFile image : additionalImages) {
                    if (image != null && !image.isEmpty()) {
                        try {
                            Map<?, ?> uploadResult = cloudinary.uploader().upload(image.getBytes(),
                                ObjectUtils.asMap(
                                    "folder", "entitykart/products/" + savedProduct.getProductId(),
                                    "public_id", "image_" + displayOrder + "_" + System.currentTimeMillis()
                                ));
                            
                            String imageUrl = (String) uploadResult.get("secure_url");
                            
                            ProductImageEntity productImage = new ProductImageEntity();
                            productImage.setProductId(savedProduct.getProductId());
                            productImage.setImageURL(imageUrl);
                            productImage.setIsPrimary(false);
                            productImage.setDisplayOrder(displayOrder++);
                            
                            productImageRepository.save(productImage);
                            uploadedCount++;
                            
                        } catch (Exception e) {
                            logger.error("Additional image upload failed for order {}: {}", displayOrder, e.getMessage());
                        }
                    }
                }
                logger.info("Uploaded {} additional images for product ID: {}", uploadedCount, savedProduct.getProductId());
            }

            redirectAttributes.addFlashAttribute("success", "Product added successfully!");
            return "redirect:/admin/products";

        } catch (Exception e) {
            logger.error("Error saving product: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error saving product: " + e.getMessage());
            return "redirect:/admin/product/add";
        }
    }

    // ========================= ADMIN: PRODUCTS LIST =========================
    @GetMapping("/admin/products")
    public String adminProducts(@RequestParam(required = false, defaultValue = "0") int page,
                                @RequestParam(required = false, defaultValue = "10") int size,
                                @RequestParam(required = false) String search,
                                @RequestParam(required = false) Integer categoryId,
                                @RequestParam(required = false) String status,
                                @RequestParam(required = false) String stockFilter,
                                HttpSession session,
                                Model model) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
            Page<ProductEntity> productPage;
            
            if (search != null && !search.trim().isEmpty()) {
                productPage = productRepository.findByProductNameContainingIgnoreCase(search.trim(), pageable);
                model.addAttribute("search", search);
            } else if (categoryId != null) {
                productPage = productRepository.findByCategoryId(categoryId, pageable);
                model.addAttribute("categoryId", categoryId);
            } else {
                productPage = productRepository.findAll(pageable);
            }

            List<CategoryEntity> categoryList = categoryRepository.findAll();
            
            // Get image counts for each product
            Map<Integer, Long> imageCountMap = new HashMap<>();
            long totalImages = 0;
            long inStockCount = 0;
            long lowStockCount = 0;
            long outOfStockCount = 0;
            
            for (ProductEntity product : productPage.getContent()) {
                long count = productImageRepository.countByProductId(product.getProductId());
                imageCountMap.put(product.getProductId(), count);
                totalImages += count;
                
                if (product.getStockQuantity() > 0) {
                    inStockCount++;
                    if (product.getStockQuantity() < LOW_STOCK_THRESHOLD) {
                        lowStockCount++;
                    }
                } else {
                    outOfStockCount++;
                }
            }

            model.addAttribute("products", productPage.getContent());
            model.addAttribute("imageCountMap", imageCountMap);
            model.addAttribute("categoryList", categoryList);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", productPage.getTotalPages());
            model.addAttribute("totalItems", productPage.getTotalElements());
            model.addAttribute("totalImages", totalImages);
            model.addAttribute("inStockCount", inStockCount);
            model.addAttribute("lowStockCount", lowStockCount);
            model.addAttribute("outOfStockCount", outOfStockCount);
            model.addAttribute("status", status);
            model.addAttribute("stockFilter", stockFilter);

        } catch (Exception e) {
            logger.error("Error loading admin products: {}", e.getMessage());
            model.addAttribute("error", "Unable to load products");
        }

        return "adminProducts";
    }

    // ========================= ADMIN: EDIT PRODUCT FORM =========================
    @GetMapping("/admin/product/edit/{productId}")
    public String editProductForm(@PathVariable Integer productId,
                                  HttpSession session,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isEmpty()) {
                logger.warn("Product not found for editing: {}", productId);
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/admin/products";
            }

            List<CategoryEntity> categoryList = categoryRepository.findAll();
            List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
            
            // Get product images
            List<ProductImageEntity> productImages = productImageRepository
                .findByProductIdOrderByDisplayOrderAsc(productId);

            model.addAttribute("product", productOpt.get());
            model.addAttribute("categoryList", categoryList);
            model.addAttribute("subCategories", subCategories);
            model.addAttribute("productImages", productImages);

        } catch (Exception e) {
            logger.error("Error loading edit product form: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Error loading product data");
            return "redirect:/admin/products";
        }

        return "adminEditProduct";
    }

    // ========================= ADMIN: UPDATE PRODUCT =========================
    @PostMapping("/admin/product/update")
    public String updateProduct(ProductEntity productEntity,
                                @RequestParam("mainImage") MultipartFile mainImage,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            Optional<ProductEntity> existingProductOpt = productRepository.findById(productEntity.getProductId());
            if (existingProductOpt.isEmpty()) {
                logger.warn("Product not found for update: {}", productEntity.getProductId());
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/admin/products";
            }

            ProductEntity existingProduct = existingProductOpt.get();
            
            // Update fields
            existingProduct.setProductName(productEntity.getProductName());
            existingProduct.setDescription(productEntity.getDescription());
            existingProduct.setBrand(productEntity.getBrand());
            existingProduct.setPrice(productEntity.getPrice());
            existingProduct.setMrp(productEntity.getMrp());
            existingProduct.setStockQuantity(productEntity.getStockQuantity());
            existingProduct.setSku(productEntity.getSku());
            existingProduct.setStatus(productEntity.getStatus());
            existingProduct.setCategoryId(productEntity.getCategoryId());
            existingProduct.setSubCategoryId(productEntity.getSubCategoryId());
            
            // Recalculate discount
            existingProduct.setDiscountPercent(calculateDiscountPercent(
                productEntity.getMrp(), productEntity.getPrice()));

            // Upload new main image if provided
            if (mainImage != null && !mainImage.isEmpty()) {
                try {
                    Map<?, ?> uploadResult = cloudinary.uploader().upload(mainImage.getBytes(),
                        ObjectUtils.asMap(
                            "folder", "entitykart/products/main",
                            "public_id", "product_" + productEntity.getProductId() + "_" + System.currentTimeMillis()
                        ));
                    String imageUrl = (String) uploadResult.get("secure_url");
                    existingProduct.setMainImageURL(imageUrl);
                    logger.info("Product main image updated: {}", imageUrl);
                } catch (Exception e) {
                    logger.error("Image upload failed during update: {}", e.getMessage());
                    redirectAttributes.addFlashAttribute("error", "Image upload failed!");
                }
            }

            productRepository.save(existingProduct);
            logger.info("Product updated successfully: {}", productEntity.getProductId());
            redirectAttributes.addFlashAttribute("success", "Product updated successfully!");

            return "redirect:/admin/product/view/" + productEntity.getProductId();

        } catch (Exception e) {
            logger.error("Error updating product: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error updating product: " + e.getMessage());
            return "redirect:/admin/product/edit/" + productEntity.getProductId();
        }
    }

    // ========================= ADMIN: VIEW PRODUCT DETAILS =========================
    @GetMapping("/admin/product/view/{productId}")
    public String adminViewProduct(@PathVariable Integer productId,
                                   HttpSession session,
                                   Model model,
                                   RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isEmpty()) {
                logger.warn("Product not found for viewing: {}", productId);
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/admin/products";
            }

            ProductEntity product = productOpt.get();
            
            // Get category and subcategory names
            String categoryName = getCategoryName(product.getCategoryId());
            String subCategoryName = getSubCategoryName(product.getSubCategoryId());
            
            // Get product images
            List<ProductImageEntity> productImages = productImageRepository
                .findByProductIdOrderByDisplayOrderAsc(productId);

            model.addAttribute("product", product);
            model.addAttribute("categoryName", categoryName);
            model.addAttribute("subCategoryName", subCategoryName);
            model.addAttribute("productImages", productImages);

        } catch (Exception e) {
            logger.error("Error viewing product: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Error loading product details");
            return "redirect:/admin/products";
        }

        return "adminViewProduct";
    }

    // ========================= ADMIN: DELETE PRODUCT =========================
    @GetMapping("/admin/product/delete/{productId}")
    public String deleteProduct(@PathVariable Integer productId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            if (productRepository.existsById(productId)) {
                // Delete all associated images first
                productImageRepository.deleteByProductId(productId);
                // Then delete product
                productRepository.deleteById(productId);
                logger.info("Product deleted successfully: {}", productId);
                redirectAttributes.addFlashAttribute("success", "Product deleted successfully!");
            } else {
                logger.warn("Attempted to delete non-existent product: {}", productId);
                redirectAttributes.addFlashAttribute("error", "Product not found!");
            }
        } catch (Exception e) {
            logger.error("Error deleting product: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error deleting product: " + e.getMessage());
        }

        return "redirect:/admin/products";
    }

    // ========================= USER: PRODUCT LISTING (PUBLIC) =========================
    @GetMapping("/products")
    public String productListing(@RequestParam(required = false) Integer category,
                                 @RequestParam(required = false) Integer subcategory,
                                 @RequestParam(required = false) String brand,
                                 @RequestParam(required = false) Float minPrice,
                                 @RequestParam(required = false) Float maxPrice,
                                 @RequestParam(required = false) String sort,
                                 @RequestParam(required = false, defaultValue = "1") int page,
                                 @RequestParam(required = false, defaultValue = "12") int size,
                                 @RequestParam(required = false) String q,
                                 HttpSession session,
                                 Model model) {

        try {
            // Calculate page for Spring (0-based)
            int pageNumber = Math.max(page - 1, 0);
            
            Pageable pageable = createPageableWithSort(pageNumber, size, sort);
            
            Page<ProductEntity> productPage = filterProducts(
                category, subcategory, brand, minPrice, maxPrice, q, pageable, model);

            // Get wishlist status for logged in users
            UserEntity currentUser = getCurrentUser(session);
            if (currentUser != null && productPage.hasContent()) {
                setWishlistStatus(currentUser.getUserId(), productPage.getContent(), model);
            }

            // Get filter options
            List<CategoryEntity> categories = categoryRepository.findAll();
            List<String> brands = productRepository.findDistinctBrandsByCategory(category);
            
            // Get price range
            Float minProductPrice = productRepository.findMinPrice();
            Float maxProductPrice = productRepository.findMaxPrice();

            model.addAttribute("products", productPage.getContent());
            model.addAttribute("categories", categories);
            model.addAttribute("brands", brands != null ? brands : new ArrayList<>());
            model.addAttribute("minProductPrice", minProductPrice != null ? minProductPrice : 0);
            model.addAttribute("maxProductPrice", maxProductPrice != null ? maxProductPrice : 100000);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", productPage.getTotalPages());
            model.addAttribute("totalItems", productPage.getTotalElements());
            model.addAttribute("sort", sort);
            model.addAttribute("size", size);

        } catch (Exception e) {
            logger.error("Error in product listing: {}", e.getMessage(), e);
            model.addAttribute("error", "Unable to load products");
            model.addAttribute("products", new ArrayList<>());
        }

        return "productList";
    }

    private Pageable createPageableWithSort(int page, int size, String sort) {
        if ("price_low".equals(sort)) {
            return PageRequest.of(page, size, Sort.by("price").ascending());
        } else if ("price_high".equals(sort)) {
            return PageRequest.of(page, size, Sort.by("price").descending());
        } else if ("newest".equals(sort)) {
            return PageRequest.of(page, size, Sort.by("createdAt").descending());
        } else if ("popular".equals(sort)) {
            return PageRequest.of(page, size, Sort.by("stockQuantity").descending());
        }
        return PageRequest.of(page, size, Sort.by("createdAt").descending());
    }

    private Page<ProductEntity> filterProducts(Integer category, Integer subcategory, String brand,
                                               Float minPrice, Float maxPrice, String q,
                                               Pageable pageable, Model model) {
        
        // Search by keyword
        if (q != null && !q.trim().isEmpty()) {
            model.addAttribute("searchQuery", q);
            return productRepository.searchProducts(q.trim(), pageable);
        }
        // Filter by category
        else if (category != null) {
            model.addAttribute("selectedCategory", category);
            getCategoryNameOptional(category).ifPresent(name -> model.addAttribute("categoryName", name));
            return productRepository.findByCategoryId(category, pageable);
        }
        // Filter by subcategory
        else if (subcategory != null) {
            model.addAttribute("selectedSubcategory", subcategory);
            return productRepository.findBySubCategoryId(String.valueOf(subcategory), pageable);
        }
        // Advanced filters
        else if (brand != null || minPrice != null || maxPrice != null) {
            model.addAttribute("selectedBrand", brand);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            return productRepository.findWithFilters(
                category, brand,
                minPrice != null ? minPrice.doubleValue() : null,
                maxPrice != null ? maxPrice.doubleValue() : null,
                null, pageable);
        }
        // All products
        return productRepository.findAll(pageable);
    }

    private void setWishlistStatus(Integer userId, List<ProductEntity> products, Model model) {
        List<Integer> productIds = products.stream()
            .map(ProductEntity::getProductId)
            .collect(Collectors.toList());
        
        if (!productIds.isEmpty()) {
            List<Integer> wishlistedIds = wishlistRepository.findWishlistedProductIds(userId, productIds);
            model.addAttribute("wishlistedIds", wishlistedIds);
        }
    }

 // ========================= USER: PRODUCT DETAIL VIEW =========================
    @GetMapping("/product/{productId}")
    public String viewProduct(@PathVariable Integer productId,
                              HttpSession session,
                              Model model,
                              RedirectAttributes redirectAttributes) {

        try {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);

            if (productOpt.isEmpty()) {
                logger.warn("Product not found: {}", productId);
                redirectAttributes.addFlashAttribute("error", "Product not found!");
                return "redirect:/products";
            }

            ProductEntity product = productOpt.get();
            
            // Check if product is in stock
            model.addAttribute("outOfStock", product.getStockQuantity() <= 0);
            
            // Get category and subcategory names
            String categoryName = getCategoryName(product.getCategoryId());
            String subCategoryName = getSubCategoryName(product.getSubCategoryId());
            
            // Get all product images
            List<ProductImageEntity> productImages = productImageRepository
                .findByProductIdOrderByDisplayOrderAsc(productId);
            
            // Check wishlist status
            UserEntity currentUser = getCurrentUser(session);
            if (currentUser != null) {
                boolean inWishlist = wishlistRepository.existsByCustomerIdAndProductId(
                    currentUser.getUserId(), productId);
                model.addAttribute("inWishlist", inWishlist);
            }
            
            // Get related products (same category)
            List<ProductEntity> relatedProducts = getRelatedProducts(product);
            
            // Handle recently viewed products
            List<ProductEntity> recentlyViewed = updateRecentlyViewed(session, productId);
            
            model.addAttribute("product", product);
            model.addAttribute("categoryName", categoryName);
            model.addAttribute("subCategoryName", subCategoryName);
            model.addAttribute("productImages", productImages);
            model.addAttribute("imageCount", productImages.size());
            model.addAttribute("relatedProducts", relatedProducts);
            model.addAttribute("recentlyViewed", recentlyViewed);
            
            // Add quantity selector value
            model.addAttribute("defaultQuantity", 1);
            
            // Placeholder data - implement actual logic
            model.addAttribute("avgRating", 4.2);
            model.addAttribute("totalReviews", 128);
            model.addAttribute("productFeatures", new String[]{"High Quality", "Best Price", "Fast Delivery"});

        } catch (Exception e) {
            logger.error("Error viewing product {}: {}", productId, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error loading product details");
            return "redirect:/products";
        }

        return "product-detail";
    }

    private List<ProductEntity> getRelatedProducts(ProductEntity product) {
        if (product.getCategoryId() == null) return new ArrayList<>();
        
        Pageable top8 = PageRequest.of(0, RELATED_PRODUCTS_LIMIT);
        return productRepository
            .findByCategoryId(product.getCategoryId(), top8)
            .getContent()
            .stream()
            .filter(p -> !p.getProductId().equals(product.getProductId()))
            .limit(RELATED_PRODUCTS_LIMIT)
            .collect(Collectors.toList());
    }

    @SuppressWarnings("unchecked")
    private List<ProductEntity> updateRecentlyViewed(HttpSession session, Integer productId) {
        List<Integer> recentlyViewedIds = (List<Integer>) session.getAttribute("recentlyViewed");
        if (recentlyViewedIds == null) {
            recentlyViewedIds = new ArrayList<>();
        }
        
        // Add current product to recently viewed
        recentlyViewedIds.remove(productId);
        recentlyViewedIds.add(0, productId);
        
        if (recentlyViewedIds.size() > MAX_RECENTLY_VIEWED) {
            recentlyViewedIds = recentlyViewedIds.subList(0, MAX_RECENTLY_VIEWED);
        }
        session.setAttribute("recentlyViewed", recentlyViewedIds);
        
        // Get recently viewed products details
        List<ProductEntity> recentlyViewed = new ArrayList<>();
        for (Integer id : recentlyViewedIds) {
            if (!id.equals(productId)) {
                productRepository.findById(id).ifPresent(recentlyViewed::add);
                if (recentlyViewed.size() >= 6) break;
            }
        }
        
        return recentlyViewed;
    }

    // ========================= USER: QUICK VIEW (AJAX) =========================
    @GetMapping("/product/quickView/{productId}")
    @ResponseBody
    public Map<String, Object> quickView(@PathVariable Integer productId) {

        Map<String, Object> response = new HashMap<>();
        
        try {
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            if (productOpt.isPresent()) {
                ProductEntity product = productOpt.get();
                
                // Get main image
                List<ProductImageEntity> images = productImageRepository
                    .findByProductIdOrderByDisplayOrderAsc(productId);
                
                response.put("success", true);
                response.put("product", product);
                response.put("images", images);
                response.put("discountPercent", product.getDiscountPercent());
                response.put("inStock", product.getStockQuantity() > 0);
            } else {
                response.put("success", false);
                response.put("message", "Product not found");
            }
        } catch (Exception e) {
            logger.error("Error in quick view for product {}: {}", productId, e.getMessage());
            response.put("success", false);
            response.put("message", "Error loading product details");
        }
        
        return response;
    }

    // ========================= CHECK DELIVERY (AJAX) =========================
    @GetMapping("/check-delivery")
    @ResponseBody
    public Map<String, Object> checkDelivery(@RequestParam String pincode) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Simple validation - in real app, check against serviceable pincodes database
            if (pincode != null && pincode.matches("\\d{6}")) {
                // Check if pincode is serviceable (simplified logic)
                if (isPincodeServiceable(pincode)) {
                    int days = calculateDeliveryDays(pincode);
                    response.put("available", true);
                    response.put("days", days);
                    response.put("message", "Delivery available in " + days + " days");
                } else {
                    response.put("available", false);
                    response.put("message", "Delivery not available at this pincode");
                }
            } else {
                response.put("available", false);
                response.put("message", "Please enter a valid 6-digit pincode");
            }
        } catch (Exception e) {
            logger.error("Error checking delivery for pincode {}: {}", pincode, e.getMessage());
            response.put("available", false);
            response.put("message", "Error checking delivery availability");
        }
        
        return response;
    }

    private boolean isPincodeServiceable(String pincode) {
        // Simplified logic - in production, check against database
        return pincode.startsWith("1") || pincode.startsWith("2") || 
               pincode.startsWith("4") || pincode.startsWith("5") || 
               pincode.startsWith("6") || pincode.startsWith("7") || 
               pincode.startsWith("8");
    }

    private int calculateDeliveryDays(String pincode) {
        // Simplified - in production, calculate based on location
        return 3 + (int)(Math.random() * 3); // Random 3-5 days
    }
}