package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link ProductController}.
 */
@Generated
public class ProductController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static ProductController apply(RegisteredBean registeredBean, ProductController instance) {
    AutowiredFieldValueResolver.forRequiredField("reviewRatingRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("categoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("subCategoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("wishlistRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productImageRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("cloudinary").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
