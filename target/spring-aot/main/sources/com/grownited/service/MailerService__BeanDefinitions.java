package com.grownited.service;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.InstanceSupplier;
import org.springframework.beans.factory.support.RootBeanDefinition;

/**
 * Bean definitions for {@link MailerService}.
 */
@Generated
public class MailerService__BeanDefinitions {
  /**
   * Get the bean definition for 'mailerService'.
   */
  public static BeanDefinition getMailerServiceBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(MailerService.class);
    InstanceSupplier<MailerService> instanceSupplier = InstanceSupplier.using(MailerService::new);
    instanceSupplier = instanceSupplier.andThen(MailerService__Autowiring::apply);
    beanDefinition.setInstanceSupplier(instanceSupplier);
    return beanDefinition;
  }
}
