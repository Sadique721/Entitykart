package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link CategoryController}.
 */
@Generated
public class CategoryController__BeanDefinitions {
  /**
   * Get the bean definition for 'categoryController'.
   */
  public static BeanDefinition getCategoryControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(CategoryController.class);
    InstanceSupplier<CategoryController> instanceSupplier = InstanceSupplier.using(CategoryController::new);
    instanceSupplier = instanceSupplier.andThen(CategoryController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
