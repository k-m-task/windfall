# Backend Dockerfile
# Build stage
FROM maven:3.9-eclipse-temurin-17 as build

WORKDIR /app

# Copy pom.xml
COPY pom.xml .

# Download dependencies (this layer can be cached)
RUN mvn dependency:go-offline -B

# Copy the rest of the code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Set JVM options optimized for containers
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseContainerSupport"

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
