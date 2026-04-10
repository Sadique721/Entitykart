package com.grownited.controller;

import org.springframework.aot.generate.Generated;
import org.springframework.beans.factory.aot.AutowiredFieldValueResolver;
import org.springframework.beans.factory.support.RegisteredBean;

/**
 * Autowiring for {@link AddressController}.
 */
@Generated
public class AddressController__Autowiring {
  /**
   * Apply the autowiring.
   */
  public static AddressController apply(RegisteredBean registeredBean, AddressController instance) {
    AutowiredFieldValueResolver.forRequiredField("addressRepository").resolveAndSet(registeredBean, instance);
    return instance;
  }
}
