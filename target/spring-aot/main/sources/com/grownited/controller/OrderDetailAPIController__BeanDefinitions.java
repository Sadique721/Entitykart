package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link OrderDetailAPIController}.
 */
@Generated
public class OrderDetailAPIController__BeanDefinitions {
  /**
   * Get the bean definition for 'orderDetailAPIController'.
   */
  public static BeanDefinition getOrderDetailAPIControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(OrderDetailAPIController.class);
    InstanceSupplier<OrderDetailAPIController> instanceSupplier = InstanceSupplier.using(OrderDetailAPIController::new);
    instanceSupplier = instanceSupplier.andThen(OrderDetailAPIController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
