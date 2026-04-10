package com.grownited.config;

import com.cloudinary.Cloudinary;
import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.BeanInstanceSupplier;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.annotation.ConfigurationClassUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.client.RestTemplate;

/**
 * Bean definitions for {@link AppConfig}.
 */
@Generated
public class AppConfig__BeanDefinitions {
  /**
   * Get the bean definition for 'appConfig'.
   */
  public static BeanDefinition getAppConfigBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(AppConfig.class);
    beanDefinition.setTargetType(AppConfig.class);
    ConfigurationClassUtils.initializeConfigurationClass(AppConfig.class);
    beanDefinition.setInstanceSupplier(AppConfig$$SpringCGLIB$$0::new);
    return beanDefinition;
  }

  /**
   * Get the bean instance supplier for 'passwordEncoder'.
   */
  private static BeanInstanceSupplier<PasswordEncoder> getPasswordEncoderInstanceSupplier() {
    return BeanInstanceSupplier.<PasswordEncoder>forFactoryMethod(AppConfig$$SpringCGLIB$$0.class, "passwordEncoder")
            .withGenerator((registeredBean) -> registeredBean.getBeanFactory().getBean("appConfig", AppConfig.class).passwordEncoder());
  }

  /**
   * Get the bean definition for 'passwordEncoder'.
   */
  public static BeanDefinition getPasswordEncoderBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(PasswordEncoder.class);
    beanDefinition.setFactoryBeanName("appConfig");
    beanDefinition.setInstanceSupplier(getPasswordEncoderInstanceSupplier());
    return beanDefinition;
  }

  /**
   * Get the bean instance supplier for 'cloudinary'.
   */
  private static BeanInstanceSupplier<Cloudinary> getCloudinaryInstanceSupplier() {
    return BeanInstanceSupplier.<Cloudinary>forFactoryMethod(AppConfig$$SpringCGLIB$$0.class, "cloudinary")
            .withGenerator((registeredBean) -> registeredBean.getBeanFactory().getBean("appConfig", AppConfig.class).cloudinary());
  }

  /**
   * Get the bean definition for 'cloudinary'.
   */
  public static BeanDefinition getCloudinaryBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(Cloudinary.class);
    beanDefinition.setFactoryBeanName("appConfig");
    beanDefinition.setInstanceSupplier(getCloudinaryInstanceSupplier());
    return beanDefinition;
  }

  /**
   * Get the bean instance supplier for 'restTemplate'.
   */
  private static BeanInstanceSupplier<RestTemplate> getRestTemplateInstanceSupplier() {
    return BeanInstanceSupplier.<RestTemplate>forFactoryMethod(AppConfig$$SpringCGLIB$$0.class, "restTemplate")
            .withGenerator((registeredBean) -> registeredBean.getBeanFactory().getBean("appConfig", AppConfig.class).restTemplate());
  }

  /**
   * Get the bean definition for 'restTemplate'.
   */
  public static BeanDefinition getRestTemplateBeanDefinition() {
    RootBeanDefinition beanDefinition = new RootBeanDefinition(RestTemplate.class);
    beanDefinition.setFactoryBeanName("appConfig");
    beanDefinition.setInstanceSupplier(getRestTemplateInstanceSupplier());
    return beanDefinition;
  }
}
