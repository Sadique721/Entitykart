package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link ReturnRefundController}.
 */
@Generated
public class ReturnRefundController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static ReturnRefundController apply(RegisteredBean registeredBean,
      ReturnRefundController instance) {
    AutowiredFieldValueResolver.forRequiredField("returnRefundRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
