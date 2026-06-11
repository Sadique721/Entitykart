# Stage 1: Build the application
FROM maven:3.9.9-amazoncorretto-21-alpine AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Download dependencies and build the WAR
RUN mvn clean package -DskipTests

# Stage 2: Lightweight runtime image
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built WAR file
COPY --from=builder /app/target/Entitykart-1.war app.war

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose the application port (Render overrides with $PORT)
EXPOSE 9999

# Health check (ensure the app is responding)
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-9999}/health || exit 1

# Run with memory limits suitable for Render free tier (256‑512 MB)
ENTRYPOINT ["java", "-Xmx384m", "-Xms256m", "-XX:+UseContainerSupport", "-jar", "app.war"]
