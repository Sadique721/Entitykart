package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link ReturnRefundController}.
 */
@Generated
public class ReturnRefundController__BeanDefinitions {
  /**
   * Get the bean definition for 'returnRefundController'.
   */
  public static BeanDefinition getReturnRefundControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(ReturnRefundController.class);
    InstanceSupplier<ReturnRefundController> instanceSupplier = InstanceSupplier.using(ReturnRefundController::new);
    instanceSupplier = instanceSupplier.andThen(ReturnRefundController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
