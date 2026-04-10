package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link OrderController}.
 */
@Generated
public class OrderController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static OrderController apply(RegisteredBean registeredBean, OrderController instance) {
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("addressRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("paymentRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("mailerService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("stockService").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
