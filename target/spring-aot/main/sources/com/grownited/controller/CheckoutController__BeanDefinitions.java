package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link CheckoutController}.
 */
@Generated
public class CheckoutController__BeanDefinitions {
  /**
   * Get the bean definition for 'checkoutController'.
   */
  public static BeanDefinition getCheckoutControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(CheckoutController.class);
    InstanceSupplier<CheckoutController> instanceSupplier = InstanceSupplier.using(CheckoutController::new);
    instanceSupplier = instanceSupplier.andThen(CheckoutController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
