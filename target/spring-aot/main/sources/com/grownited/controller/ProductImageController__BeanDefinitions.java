package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link ProductImageController}.
 */
@Generated
public class ProductImageController__BeanDefinitions {
  /**
   * Get the bean definition for 'productImageController'.
   */
  public static BeanDefinition getProductImageControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(ProductImageController.class);
    InstanceSupplier<ProductImageController> instanceSupplier = InstanceSupplier.using(ProductImageController::new);
    instanceSupplier = instanceSupplier.andThen(ProductImageController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
