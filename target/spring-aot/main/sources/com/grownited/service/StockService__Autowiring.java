package com.grownited.service;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link StockService}.
 */
@Generated
public class StockService__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static StockService apply(RegisteredBean registeredBean, StockService instance) {
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
