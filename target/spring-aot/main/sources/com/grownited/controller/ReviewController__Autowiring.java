package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link ReviewController}.
 */
@Generated
public class ReviewController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static ReviewController apply(RegisteredBean registeredBean, ReviewController instance) {
    AutowiredFieldValueResolver.forRequiredField("reviewRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
