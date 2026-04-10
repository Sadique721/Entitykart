package com.grownited.service;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link PaymentService}.
 */
@Generated
public class PaymentService__BeanDefinitions {
  /**
   * Get the bean definition for 'paymentService'.
   */
  public static BeanDefinition getPaymentServiceBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(PaymentService.class);
    InstanceSupplier<PaymentService> instanceSupplier = InstanceSupplier.using(PaymentService::new);
    instanceSupplier = instanceSupplier.andThen(PaymentService__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
