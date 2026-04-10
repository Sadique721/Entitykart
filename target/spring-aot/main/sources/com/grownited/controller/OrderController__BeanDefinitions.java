package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link OrderController}.
 */
@Generated
public class OrderController__BeanDefinitions {
  /**
   * Get the bean definition for 'orderController'.
   */
  public static BeanDefinition getOrderControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(OrderController.class);
    InstanceSupplier<OrderController> instanceSupplier = InstanceSupplier.using(OrderController::new);
    instanceSupplier = instanceSupplier.andThen(OrderController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
