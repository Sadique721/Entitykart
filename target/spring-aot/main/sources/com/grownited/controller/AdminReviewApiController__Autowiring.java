package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link AdminReviewApiController}.
 */
@Generated
public class AdminReviewApiController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static AdminReviewApiController apply(RegisteredBean registeredBean,
      AdminReviewApiController instance) {
    AutowiredFieldValueResolver.forRequiredField("reviewRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
