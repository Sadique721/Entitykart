package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link WishlistController}.
 */
@Generated
public class WishlistController__BeanDefinitions {
  /**
   * Get the bean definition for 'wishlistController'.
   */
  public static BeanDefinition getWishlistControllerBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(WishlistController.class);
    InstanceSupplier<WishlistController> instanceSupplier = InstanceSupplier.using(WishlistController::new);
    instanceSupplier = instanceSupplier.andThen(WishlistController__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
