package com.grownited.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

import io.github.cdimascio.dotenv.Dotenv;

@Configuration
public class DotEnvConfig {

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
        
        // Load .env file from root directory
        Dotenv dotenv = Dotenv.configure()
                .ignoreIfMissing()  // Don't fail if .env doesn't exist
                .load();
        
        Properties properties = new Properties();
        
        // Database
        properties.setProperty("DB_HOST", dotenv.get("DB_HOST"));
        properties.setProperty("DB_PORT", dotenv.get("DB_PORT"));
        properties.setProperty("DB_NAME", dotenv.get("DB_NAME"));
        properties.setProperty("DB_USERNAME", dotenv.get("DB_USERNAME"));
        properties.setProperty("DB_PASSWORD", dotenv.get("DB_PASSWORD"));
        
        // Server
        properties.setProperty("SERVER_PORT", dotenv.get("SERVER_PORT"));
        
        // Email
        properties.setProperty("MAIL_USERNAME", dotenv.get("MAIL_USERNAME"));
        properties.setProperty("MAIL_PASSWORD", dotenv.get("MAIL_PASSWORD"));
        
        // Cloudinary
        properties.setProperty("CLOUDINARY_CLOUD_NAME", dotenv.get("CLOUDINARY_CLOUD_NAME"));
        properties.setProperty("CLOUDINARY_API_KEY", dotenv.get("CLOUDINARY_API_KEY"));
        properties.setProperty("CLOUDINARY_API_SECRET", dotenv.get("CLOUDINARY_API_SECRET"));
        
        // Authorize.Net
        properties.setProperty("AUTHORIZE_NET_API_LOGIN_ID", dotenv.get("AUTHORIZE_NET_API_LOGIN_ID"));
        properties.setProperty("AUTHORIZE_NET_TRANSACTION_KEY", dotenv.get("AUTHORIZE_NET_TRANSACTION_KEY"));
        properties.setProperty("AUTHORIZE_NET_ENVIRONMENT", dotenv.get("AUTHORIZE_NET_ENVIRONMENT"));
        
        PropertySourcesPlaceholderConfigurer configurer = new PropertySourcesPlaceholderConfigurer();
        configurer.setProperties(properties);
        configurer.setIgnoreUnresolvablePlaceholders(false);
        
        return configurer;
    }
}
