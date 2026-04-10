package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link WishlistController}.
 */
@Generated
public class WishlistController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static WishlistController apply(RegisteredBean registeredBean,
      WishlistController instance) {
    AutowiredFieldValueResolver.forRequiredField("wishlistRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
