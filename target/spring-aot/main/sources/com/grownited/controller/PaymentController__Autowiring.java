package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link PaymentController}.
 */
@Generated
public class PaymentController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static PaymentController apply(RegisteredBean registeredBean, PaymentController instance) {
    AutowiredFieldValueResolver.forRequiredField("paymentRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderDetailRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("cartRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("paymentService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("stockService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("mailerService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("addressRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
