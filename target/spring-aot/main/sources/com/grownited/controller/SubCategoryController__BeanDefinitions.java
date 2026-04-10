package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link SubCategoryController}.
 */
@Generated
public class SubCategoryController__BeanDefinitions {
  /**
   * Get the bean definition for 'subCategoryController'.
   */
  public static BeanDefinition getSubCategoryControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(SubCategoryController.class);
    InstanceSupplier<SubCategoryController> instanceSupplier = InstanceSupplier.using(SubCategoryController::new);
    instanceSupplier = instanceSupplier.andThen(SubCategoryController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
