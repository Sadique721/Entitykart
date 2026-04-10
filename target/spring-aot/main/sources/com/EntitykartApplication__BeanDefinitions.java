package com;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link EntitykartApplication}.
 */
@Generated
public class EntitykartApplication__BeanDefinitions {
  /**
   * Get the bean definition for 'entitykartApplication'.
   */
  public static BeanDefinition getEntitykartApplicationBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(EntitykartApplication.class);
    beanDefinition.setInstanceSupplier(EntitykartApplication::new);
    return beanDefinition;
  }
}
