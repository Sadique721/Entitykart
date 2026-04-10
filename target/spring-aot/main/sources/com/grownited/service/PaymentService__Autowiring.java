package com.grownited.service;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link PaymentService}.
 */
@Generated
public class PaymentService__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static PaymentService apply(RegisteredBean registeredBean, PaymentService instance) {
    AutowiredFieldValueResolver.forRequiredField("paymentRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
