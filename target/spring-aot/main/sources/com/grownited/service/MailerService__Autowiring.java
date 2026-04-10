package com.grownited.service;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link MailerService}.
 */
@Generated
public class MailerService__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static MailerService apply(RegisteredBean registeredBean, MailerService instance) {
    AutowiredFieldValueResolver.forRequiredField("mailSender").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("fromEmail").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
