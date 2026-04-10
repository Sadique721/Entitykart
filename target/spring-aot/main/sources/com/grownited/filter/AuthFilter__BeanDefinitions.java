package com.grownited.filter;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link AuthFilter}.
 */
@Generated
public class AuthFilter__BeanDefinitions {
  /**
   * Get the bean definition for 'authFilter'.
   */
  public static BeanDefinition getAuthFilterBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(AuthFilter.class);
    beanDefinition.setInstanceSupplier(AuthFilter::new);
    return beanDefinition;
  }
}
