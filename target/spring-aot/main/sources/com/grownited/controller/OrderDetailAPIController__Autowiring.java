package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link OrderDetailAPIController}.
 */
@Generated
public class OrderDetailAPIController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static OrderDetailAPIController apply(RegisteredBean registeredBean,
      OrderDetailAPIController instance) {
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
