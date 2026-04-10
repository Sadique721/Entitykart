package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link AdminExportController}.
 */
@Generated
public class AdminExportController__BeanDefinitions {
  /**
   * Get the bean definition for 'adminExportController'.
   */
  public static BeanDefinition getAdminExportControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(AdminExportController.class);
    InstanceSupplier<AdminExportController> instanceSupplier = InstanceSupplier.using(AdminExportController::new);
    instanceSupplier = instanceSupplier.andThen(AdminExportController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
