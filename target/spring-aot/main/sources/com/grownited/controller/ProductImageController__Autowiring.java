package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link ProductImageController}.
 */
@Generated
public class ProductImageController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static ProductImageController apply(RegisteredBean registeredBean,
      ProductImageController instance) {
    AutowiredFieldValueResolver.forRequiredField("productImageRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("cloudinary").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
