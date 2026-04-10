package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link AdminExportController}.
 */
@Generated
public class AdminExportController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static AdminExportController apply(RegisteredBean registeredBean,
      AdminExportController instance) {
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("paymentRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("returnRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("reviewRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("wishlistRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("mailerService").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
