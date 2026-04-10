package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link ProductImageApiController}.
 */
@Generated
public class ProductImageApiController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static ProductImageApiController apply(RegisteredBean registeredBean,
      ProductImageApiController instance) {
    AutowiredFieldValueResolver.forRequiredField("productImageRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
