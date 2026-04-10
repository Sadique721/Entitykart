package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link SessionController}.
 */
@Generated
public class SessionController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static SessionController apply(RegisteredBean registeredBean, SessionController instance) {
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("categoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("subCategoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("passwordEncoder").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("orderRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("returnRefundRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
