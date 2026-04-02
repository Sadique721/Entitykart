package com.grownited.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.CartEntity;
import com.grownited.entity.ProductEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.CartRepository;
import com.grownited.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    private CartRepository cartRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    // Add to cart
    @GetMapping("/cart/add")
    public String addToCart(@RequestParam Integer productId,
                           @RequestParam(required = false, defaultValue = "1") Integer quantity,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Product not found!");
            return "redirect:/listProduct";
        }
        
        ProductEntity product = productOpt.get();
        
        // Check stock
        if (product.getStockQuantity() < quantity) {
            redirectAttributes.addFlashAttribute("error", "Insufficient stock! Available: " + product.getStockQuantity());
            return "redirect:/viewProduct?productId=" + productId;
        }
        
        // Check if already in cart
        Optional<CartEntity> existingCart = cartRepository.findByCustomerIdAndProductId(currentUser.getUserId(), productId);
        
        if (existingCart.isPresent()) {
            CartEntity cartItem = existingCart.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cartRepository.save(cartItem);
            redirectAttributes.addFlashAttribute("success", "Cart updated successfully!");
        } else {
            CartEntity cartItem = new CartEntity();
            cartItem.setCustomerId(currentUser.getUserId());
            cartItem.setProductId(productId);
            cartItem.setQuantity(quantity);
            cartItem.setPrice(product.getPrice().doubleValue());
            cartRepository.save(cartItem);
            redirectAttributes.addFlashAttribute("success", "Product added to cart!");
        }
        
        return "redirect:/cart";
    }
    
    // View cart
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        List<Object[]> cartItems = cartRepository.findCartWithProductDetails(currentUser.getUserId());
        Double cartTotal = cartRepository.getCartTotal(currentUser.getUserId());
        Long itemCount = cartRepository.countByCustomerId(currentUser.getUserId());
        
        Double subtotal = cartTotal != null ? cartTotal : 0.0;
        Double shipping = 40.0;
        Double tax = subtotal * 0.18;
        Double total = subtotal + shipping + tax;
        
        List<Map<String, Object>> items = new ArrayList<>();
        for (Object[] row : cartItems) {
            Map<String, Object> item = new HashMap<>();
            item.put("cart", row[0]);
            item.put("productName", row[1]);
            item.put("productImage", row[2]);
            item.put("stockQuantity", row[3]);
            items.add(item);
        }
        
        model.addAttribute("cartItems", items);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shipping", shipping);
        model.addAttribute("tax", tax);
        model.addAttribute("total", total);
        model.addAttribute("itemCount", itemCount);
        
        return "cart";
    }
    
    // Update cart quantity
    @PostMapping("/cart/update")
    @ResponseBody
    public Map<String, Object> updateCartQuantity(@RequestParam Integer cartId,
                                                  @RequestParam Integer quantity,
                                                  HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Please login first!");
            return response;
        }
        
        Optional<CartEntity> cartOpt = cartRepository.findById(cartId);
        if (cartOpt.isEmpty() || !cartOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            response.put("success", false);
            response.put("message", "Cart item not found!");
            return response;
        }
        
        CartEntity cart = cartOpt.get();
        
        // Check stock
        Optional<ProductEntity> productOpt = productRepository.findById(cart.getProductId());
        if (productOpt.isPresent() && productOpt.get().getStockQuantity() < quantity) {
            response.put("success", false);
            response.put("message", "Insufficient stock! Available: " + productOpt.get().getStockQuantity());
            return response;
        }
        
        if (quantity <= 0) {
            cartRepository.delete(cart);
            response.put("deleted", true);
        } else {
            cart.setQuantity(quantity);
            cartRepository.save(cart);
            response.put("deleted", false);
            response.put("newSubtotal", cart.getPrice() * quantity);
        }
        
        Double cartTotal = cartRepository.getCartTotal(currentUser.getUserId());
        Long itemCount = cartRepository.countByCustomerId(currentUser.getUserId());
        
        Double subtotal = cartTotal != null ? cartTotal : 0.0;
        Double shipping = 40.0;
        Double tax = subtotal * 0.18;
        Double total = subtotal + shipping + tax;
        
        response.put("success", true);
        response.put("cartTotal", subtotal);
        response.put("shipping", shipping);
        response.put("tax", tax);
        response.put("total", total);
        response.put("itemCount", itemCount);
        
        return response;
    }
    
    // Remove from cart
    @GetMapping("/cart/remove")
    public String removeFromCart(@RequestParam Integer cartId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<CartEntity> cartOpt = cartRepository.findById(cartId);
        if (cartOpt.isPresent() && cartOpt.get().getCustomerId().equals(currentUser.getUserId())) {
            cartRepository.delete(cartOpt.get());
            redirectAttributes.addFlashAttribute("success", "Item removed from cart!");
        }
        
        return "redirect:/cart";
    }
    
    // Clear cart
    @GetMapping("/cart/clear")
    public String clearCart(HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        cartRepository.deleteByCustomerId(currentUser.getUserId());
        redirectAttributes.addFlashAttribute("success", "Cart cleared successfully!");
        
        return "redirect:/cart";
    }
   
}