package com.grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.ProductImageEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ProductImageRepository;
import com.grownited.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProductImageController {

    // ==================== DEPENDENCY INJECTION ====================
    
    @Autowired
    private ProductImageRepository productImageRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private Cloudinary cloudinary;
    
    
    // ==================== LIST IMAGES FOR A PRODUCT ====================
    // URL: /product/images?productId=1
    
    @GetMapping("/product/images")
    public String listProductImages(@RequestParam Integer productId, 
                                    Model model, 
                                    HttpSession session) {
        
        // 1. Check if user is logged in
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 2. Check if product exists
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            model.addAttribute("error", "Product not found!");
            return "error";
        }
        
        ProductEntity product = productOpt.get();
        
        // 3. Get all images for this product
        List<ProductImageEntity> images = productImageRepository
                .findByProductIdOrderByDisplayOrderAsc(productId);
        
        // 4. Find primary image
        Optional<ProductImageEntity> primaryImage = productImageRepository
                .findByProductIdAndIsPrimaryTrue(productId);
        
        // 5. Add data to model
        model.addAttribute("product", product);
        model.addAttribute("images", images);
        model.addAttribute("primaryImage", primaryImage.orElse(null));
        model.addAttribute("imageCount", images.size());
        
        return "product/productImages"; // JSP page
    }
    
    
    // ==================== SHOW UPLOAD FORM ====================
    // URL: /product/images/add?productId=1
    
    @GetMapping("/product/images/add")
    public String showUploadForm(@RequestParam Integer productId, 
                                 Model model, 
                                 HttpSession session) {
        
        // 1. Check login
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 2. Verify product exists
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            model.addAttribute("error", "Product not found!");
            return "error";
        }
        
        // 3. Get current image count to suggest next display order
        Long imageCount = productImageRepository.countByProductId(productId);
        Integer nextOrder = imageCount.intValue() + 1;
        
        model.addAttribute("product", productOpt.get());
        model.addAttribute("nextOrder", nextOrder);
        
        return "productImage/addProductImage"; // JSP form
    }
    
    
    // ==================== UPLOAD NEW IMAGE ====================
    // URL: /product/images/upload (POST)
    
    @PostMapping("/product/images/upload")
    public String uploadProductImage(@RequestParam Integer productId,
                                     @RequestParam("imageFile") MultipartFile imageFile,
                                     @RequestParam(required = false) Boolean isPrimary,
                                     @RequestParam(required = false) Integer displayOrder,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        
        // 1. Check login
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 2. Validate file
        if (imageFile == null || imageFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select an image file!");
            return "redirect:/product/images/add?productId=" + productId;
        }
        
        // 3. Validate file type
        String contentType = imageFile.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            redirectAttributes.addFlashAttribute("error", "Only image files are allowed!");
            return "redirect:/product/images/add?productId=" + productId;
        }
        
        // 4. Validate file size (5MB max)
        if (imageFile.getSize() > 5 * 1024 * 1024) {
            redirectAttributes.addFlashAttribute("error", "File size exceeds 5MB!");
            return "redirect:/product/images/add?productId=" + productId;
        }
        
        try {
            // 5. Upload to Cloudinary
            Map<?, ?> uploadResult = cloudinary.uploader()
                    .upload(imageFile.getBytes(), 
                            Map.of("folder", "entitykart/products/" + productId));
            
            String imageUrl = uploadResult.get("secure_url").toString();
            
            // 6. If this is set as primary, unset any existing primary
            if (isPrimary != null && isPrimary) {
                productImageRepository.resetPrimaryForProduct(productId);
            }
            
            // 7. Determine display order
            if (displayOrder == null || displayOrder <= 0) {
                Integer maxOrder = productImageRepository.getMaxDisplayOrder(productId);
                displayOrder = maxOrder + 1;
            }
            
            // 8. Create and save image entity
            ProductImageEntity imageEntity = new ProductImageEntity();
            imageEntity.setProductId(productId);
            imageEntity.setImageURL(imageUrl);
            imageEntity.setIsPrimary(isPrimary != null ? isPrimary : false);
            imageEntity.setDisplayOrder(displayOrder);
            
            productImageRepository.save(imageEntity);
            
            // 9. If this is primary image, update product's mainImageURL
            if (isPrimary != null && isPrimary) {
                Optional<ProductEntity> productOpt = productRepository.findById(productId);
                if (productOpt.isPresent()) {
                    ProductEntity product = productOpt.get();
                    product.setMainImageURL(imageUrl);
                    productRepository.save(product);
                }
            }
            
            redirectAttributes.addFlashAttribute("success", "Image uploaded successfully!");
            
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Image upload failed: " + e.getMessage());
        }
        
        return "redirect:/product/images?productId=" + productId;
    }
    
    
    // ==================== SET IMAGE AS PRIMARY ====================
    // URL: /product/images/set-primary?imageId=5
    
    @GetMapping("/product/images/set-primary")
    public String setPrimaryImage(@RequestParam Integer imageId,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        
        // 1. Check login
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 2. Find the image
        Optional<ProductImageEntity> imageOpt = productImageRepository.findById(imageId);
        if (imageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Image not found!");
            return "redirect:/product/images";
        }
        
        ProductImageEntity newPrimary = imageOpt.get();
        Integer productId = newPrimary.getProductId();
        
        // 3. Reset all images for this product to non-primary
        productImageRepository.resetPrimaryForProduct(productId);
        
        // 4. Set this image as primary
        newPrimary.setIsPrimary(true);
        productImageRepository.save(newPrimary);
        
        // 5. Update product's mainImageURL
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setMainImageURL(newPrimary.getImageURL());
            productRepository.save(product);
        }
        
        redirectAttributes.addFlashAttribute("success", "Primary image updated successfully!");
        
        return "redirect:/product/images?productId=" + productId;
    }
    
    
    // ==================== DELETE IMAGE ====================
    // URL: /product/images/delete?imageId=5
    
    @GetMapping("/product/images/delete")
    public String deleteImage(@RequestParam Integer imageId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        // 1. Check login
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 2. Find the image
        Optional<ProductImageEntity> imageOpt = productImageRepository.findById(imageId);
        if (imageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Image not found!");
            return "redirect:/product/images";
        }
        
        ProductImageEntity image = imageOpt.get();
        Integer productId = image.getProductId();
        boolean wasPrimary = image.isPrimary();
        
        // 3. Delete from database
        productImageRepository.delete(image);
        
        // 4. If this was primary image, need to set another as primary
        if (wasPrimary) {
            // Find another image for this product
            List<ProductImageEntity> remainingImages = productImageRepository
                    .findByProductIdOrderByDisplayOrderAsc(productId);
            
            Optional<ProductEntity> productOpt = productRepository.findById(productId);
            
            if (!remainingImages.isEmpty() && productOpt.isPresent()) {
                // Set first remaining image as primary
                ProductImageEntity newPrimary = remainingImages.get(0);
                newPrimary.setIsPrimary(true);
                productImageRepository.save(newPrimary);
                
                // Update product's main image
                ProductEntity product = productOpt.get();
                product.setMainImageURL(newPrimary.getImageURL());
                productRepository.save(product);
                
                redirectAttributes.addFlashAttribute("info", 
                        "Primary image was deleted. Another image was set as primary.");
            } else if (productOpt.isPresent()) {
                // No images left, clear product's main image
                ProductEntity product = productOpt.get();
                product.setMainImageURL(null);
                productRepository.save(product);
                
                redirectAttributes.addFlashAttribute("info", 
                        "All images deleted. Product has no main image now.");
            }
        }
        
        // Optional: Delete from Cloudinary (if you store public_id)
        // You would need to extract public_id from URL
        
        redirectAttributes.addFlashAttribute("success", "Image deleted successfully!");
        
        return "redirect:/product/images?productId=" + productId;
    }
    
    
    // ==================== UPDATE IMAGE ORDER ====================
    // URL: /product/images/reorder (POST) - AJAX endpoint
    
    @PostMapping("/product/images/reorder")
    @ResponseBody
    public String reorderImages(@RequestParam Integer productId,
                                @RequestParam String order) {
        // order format: "1,3,2,4" (imageIds in new order)
        
        try {
            String[] imageIds = order.split(",");
            
            for (int i = 0; i < imageIds.length; i++) {
                Integer imageId = Integer.parseInt(imageIds[i].trim());
                Optional<ProductImageEntity> imageOpt = productImageRepository.findById(imageId);
                
                if (imageOpt.isPresent() && imageOpt.get().getProductId().equals(productId)) {
                    ProductImageEntity image = imageOpt.get();
                    image.setDisplayOrder(i + 1); // New order (1-based)
                    productImageRepository.save(image);
                }
            }
            
            return "SUCCESS";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }
    
    
    // ==================== BULK UPLOAD ====================
    // URL: /product/images/bulk-upload (POST)
    
    @PostMapping("/product/images/bulk-upload")
    public String bulkUploadImages(@RequestParam Integer productId,
                                   @RequestParam("imageFiles") MultipartFile[] imageFiles,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        // 1. Check login
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        int successCount = 0;
        int failCount = 0;
        
        // 2. Get current max order
        Integer currentMaxOrder = productImageRepository.getMaxDisplayOrder(productId);
        int nextOrder = (currentMaxOrder == null) ? 1 : currentMaxOrder + 1;
        
        // 3. Process each file
        for (MultipartFile file : imageFiles) {
            if (file.isEmpty()) continue;
            
            try {
                // Validate file type
                if (!file.getContentType().startsWith("image/")) {
                    failCount++;
                    continue;
                }
                
                // Validate size
                if (file.getSize() > 5 * 1024 * 1024) {
                    failCount++;
                    continue;
                }
                
                // Upload to Cloudinary
                Map<?, ?> uploadResult = cloudinary.uploader()
                        .upload(file.getBytes(), 
                                Map.of("folder", "entitykart/products/" + productId));
                
                String imageUrl = uploadResult.get("secure_url").toString();
                
                // Create image entity
                ProductImageEntity imageEntity = new ProductImageEntity();
                imageEntity.setProductId(productId);
                imageEntity.setImageURL(imageUrl);
                imageEntity.setIsPrimary(false); // Bulk uploads are not primary by default
                imageEntity.setDisplayOrder(nextOrder++);
                
                productImageRepository.save(imageEntity);
                successCount++;
                
            } catch (Exception e) {
                e.printStackTrace();
                failCount++;
            }
        }
        
        redirectAttributes.addFlashAttribute("success", 
                String.format("Uploaded %d images successfully. %d failed.", successCount, failCount));
        
        return "redirect:/product/images?productId=" + productId;
    }
}