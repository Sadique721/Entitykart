package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link UserController}.
 */
@Generated
public class UserController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static UserController apply(RegisteredBean registeredBean, UserController instance) {
    AutowiredFieldValueResolver.forRequiredField("mailerService").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("userRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("addressRepository").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("passwordEncoder").resolveAndSet(registeredBean, instance);
    AutowiredFieldValueResolver.forRequiredField("cloudinary").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
