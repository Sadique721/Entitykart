package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EntitykartApplication {

	public static void main(String[] args) {
		System.out.println("=== ENTITYKART STARTING UP ===");
		System.out.println("DB_HOST environment variable: " + System.getenv("DB_HOST"));
		System.out.println("DB_PORT environment variable: " + System.getenv("DB_PORT"));
		System.out.println("DB_NAME environment variable: " + System.getenv("DB_NAME"));
		System.out.println("DB_USERNAME environment variable: " + System.getenv("DB_USERNAME"));
		System.out.println("PORT environment variable: " + System.getenv("PORT"));
		System.out.println("==============================");

		SpringApplication.run(EntitykartApplication.class, args);
		System.out.println("✅✅✅ APPLICATION STARTED SUCCESSFULLY ✅✅✅");
	}
}
