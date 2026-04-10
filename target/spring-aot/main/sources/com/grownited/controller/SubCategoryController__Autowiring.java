package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link SubCategoryController}.
 */
@Generated
public class SubCategoryController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static SubCategoryController apply(RegisteredBean registeredBean,
      SubCategoryController instance) {
    AutowiredFieldValueResolver.forRequiredField("subCategoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("categoryRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("productRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
