package com.grownited.service;

import com.grownited.entity.ProductEntity;
import com.grownited.repository.ProductRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StockService {

    private static final Logger log = LoggerFactory.getLogger(StockService.class);

    @Autowired
    private ProductRepository productRepository;

    /**
     * Deduct stock for a product (optimistic locking not needed for basic check).
     * Throws RuntimeException if insufficient stock.
     */
    @Transactional
    public void deductStock(Integer productId, Integer quantity) {
        ProductEntity product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found: " + productId));

        if (product.getStockQuantity() < quantity) {
            throw new RuntimeException("Insufficient stock for product " + productId);
        }

        product.setStockQuantity(product.getStockQuantity() - quantity);
        productRepository.save(product);
        log.info("Deducted {} units from product {}. New stock: {}", quantity, productId, product.getStockQuantity());
    }

    /**
     * Restore stock (e.g., when order is cancelled or return is approved).
     */
    @Transactional
    public void restoreStock(Integer productId, Integer quantity) {
        ProductEntity product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found: " + productId));

        product.setStockQuantity(product.getStockQuantity() + quantity);
        productRepository.save(product);
        log.info("Restored {} units to product {}. New stock: {}", quantity, productId, product.getStockQuantity());
    }
    
 // In StockService
    public boolean isStockAvailable(Integer productId, Integer quantity) {
        return productRepository.findById(productId)
                .map(p -> p.getStockQuantity() >= quantity)
                .orElse(false);
    }
}