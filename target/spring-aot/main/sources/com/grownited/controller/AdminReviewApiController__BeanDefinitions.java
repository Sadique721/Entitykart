package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link AdminReviewApiController}.
 */
@Generated
public class AdminReviewApiController__BeanDefinitions {
  /**
   * Get the bean definition for 'adminReviewApiController'.
   */
  public static BeanDefinition getAdminReviewApiControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(AdminReviewApiController.class);
    InstanceSupplier<AdminReviewApiController> instanceSupplier = InstanceSupplier.using(AdminReviewApiController::new);
    instanceSupplier = instanceSupplier.andThen(AdminReviewApiController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
