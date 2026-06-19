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

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the built WAR file with proper user ownership
COPY --from=builder --chown=appuser:appgroup /app/target/Entitykart-1.war app.war

# Ensure appuser owns /app directory for Tomcat JSP compilation and runtime logs
RUN chown -R appuser:appgroup /app

USER appuser

# Expose the application port (Render overrides with $PORT)
ENV PORT=10000
EXPOSE 10000

# Health check (ensure the app is responding)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-10000}/health || exit 1

# Run with memory limits optimized for Render free tier (512 MB container RAM limit)
# Hard caps heap to 200m and restricts metaspace/code-cache/stacks to guarantee no OOM-kills
# Specifies non-blocking entropy source to prevent hangs during TLS/SSL database handshakes
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-XX:+UseContainerSupport", "-XX:+UseSerialGC", "-Xmx200m", "-Xms128m", "-XX:MaxMetaspaceSize=64m", "-XX:ReservedCodeCacheSize=32m", "-Xss512k", "-jar", "app.war"]
