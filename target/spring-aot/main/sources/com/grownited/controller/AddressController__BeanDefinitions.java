package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link AddressController}.
 */
@Generated
public class AddressController__BeanDefinitions {
  /**
   * Get the bean definition for 'addressController'.
   */
  public static BeanDefinition getAddressControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(AddressController.class);
    InstanceSupplier<AddressController> instanceSupplier = InstanceSupplier.using(AddressController::new);
    instanceSupplier = instanceSupplier.andThen(AddressController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
