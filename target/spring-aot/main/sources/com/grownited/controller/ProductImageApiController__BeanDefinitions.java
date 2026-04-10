package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link ProductImageApiController}.
 */
@Generated
public class ProductImageApiController__BeanDefinitions {
  /**
   * Get the bean definition for 'productImageApiController'.
   */
  public static BeanDefinition getProductImageApiControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(ProductImageApiController.class);
    InstanceSupplier<ProductImageApiController> instanceSupplier = InstanceSupplier.using(ProductImageApiController::new);
    instanceSupplier = instanceSupplier.andThen(ProductImageApiController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
