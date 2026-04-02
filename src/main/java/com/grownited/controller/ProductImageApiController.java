package com.grownited.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.grownited.entity.ProductImageEntity;
import com.grownited.repository.ProductImageRepository;

@RestController
@RequestMapping("/api")
public class ProductImageApiController {

    @Autowired
    private ProductImageRepository productImageRepository;
    
    @GetMapping("/product/{productId}/images")
    public List<Map<String, Object>> getProductImages(@PathVariable Integer productId) {
        
        List<ProductImageEntity> images = productImageRepository
                .findByProductIdOrderByDisplayOrderAsc(productId);
        
        return images.stream().map(image -> {
            Map<String, Object> map = new HashMap<>();
            map.put("imageId", image.getProductImageId());
            map.put("imageURL", image.getImageURL());
            map.put("primary", image.isPrimary());
            map.put("displayOrder", image.getDisplayOrder());
            map.put("createdAt", image.getCreatedAt().toString());
            return map;
        }).collect(Collectors.toList());
    }
}