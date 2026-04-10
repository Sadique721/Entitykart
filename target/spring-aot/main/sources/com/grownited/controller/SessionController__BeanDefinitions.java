package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link SessionController}.
 */
@Generated
public class SessionController__BeanDefinitions {
  /**
   * Get the bean definition for 'sessionController'.
   */
  public static BeanDefinition getSessionControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(SessionController.class);
    InstanceSupplier<SessionController> instanceSupplier = InstanceSupplier.using(SessionController::new);
    instanceSupplier = instanceSupplier.andThen(SessionController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
