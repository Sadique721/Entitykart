package com.grownited.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.grownited.entity.OrderDetailEntity;
import com.grownited.entity.OrderEntity;
import com.grownited.repository.OrderDetailRepository;
import com.grownited.repository.OrderRepository;

@RestController
@RequestMapping("/api/orders")
public class OrderDetailAPIController {

    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    // Get order details with product info
    @GetMapping("/{orderId}/details")
    public List<Map<String, Object>> getOrderDetails(@PathVariable Integer orderId) {
        
        List<Object[]> results = orderDetailRepository.findOrderDetailsWithProductInfo(orderId);
        
        return results.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            OrderDetailEntity detail = (OrderDetailEntity) row[0];
            map.put("orderItemId", detail.getOrderItemId());
            map.put("productId", detail.getProductId());
            map.put("productName", row[1]);
            map.put("productImage", row[2]);
            map.put("quantity", detail.getQuantity());
            map.put("price", detail.getPrice());
            map.put("subtotal", detail.getSubtotal());
            map.put("createdAt", detail.getCreatedAt().toString());
            return map;
        }).toList();
    }
    
    // Get order summary
    @GetMapping("/{orderId}/summary")
    public Map<String, Object> getOrderSummary(@PathVariable Integer orderId) {
        
        Map<String, Object> summary = new HashMap<>();
        
        Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            OrderEntity order = orderOpt.get();
            summary.put("orderId", order.getOrderId());
            summary.put("orderStatus", order.getOrderStatus());
            summary.put("paymentStatus", order.getPaymentStatus());
            summary.put("totalAmount", order.getTotalAmount());
            summary.put("orderDate", order.getOrderDate().toString());
            
            List<OrderDetailEntity> details = orderDetailRepository.findByOrderId(orderId);
            int totalItems = details.stream().mapToInt(OrderDetailEntity::getQuantity).sum();
            summary.put("totalItems", totalItems);
        }
        
        return summary;
    }
    
    // Get best selling products
    @GetMapping("/best-selling")
    public List<Map<String, Object>> getBestSellingProducts() {
        
        List<Object[]> results = orderDetailRepository.getBestSellingProducts();
        
        return results.stream().limit(10).map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("productId", row[0]);
            map.put("totalSold", row[1]);
            return map;
        }).toList();
    }
}