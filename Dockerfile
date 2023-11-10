# Use a base image with a JRE
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file built by the Spring Boot application
COPY build/libs/notes-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the Spring Boot application listens on
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
