package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link CartController}.
 */
@Generated
public class CartController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static CartController apply(RegisteredBean registeredBean, CartController instance) {
    AutowiredFieldValueResolver.forRequiredField("cartRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
