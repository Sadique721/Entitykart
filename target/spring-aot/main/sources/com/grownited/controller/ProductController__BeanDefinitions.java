package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link ProductController}.
 */
@Generated
public class ProductController__BeanDefinitions {
  /**
   * Get the bean definition for 'productController'.
   */
  public static BeanDefinition getProductControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(ProductController.class);
    InstanceSupplier<ProductController> instanceSupplier = InstanceSupplier.using(ProductController::new);
    instanceSupplier = instanceSupplier.andThen(ProductController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
