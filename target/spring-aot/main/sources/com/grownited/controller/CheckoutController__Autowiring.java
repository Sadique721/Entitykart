package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link CheckoutController}.
 */
@Generated
public class CheckoutController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static CheckoutController apply(RegisteredBean registeredBean,
      CheckoutController instance) {
    AutowiredFieldValueResolver.forRequiredField("cartRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("addressRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("paymentRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("paymentService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("stockService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("mailerService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
