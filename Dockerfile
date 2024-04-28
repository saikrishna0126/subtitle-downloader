# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/subtitle-downloader.jar /app/subtitle-downloader.jar

# Specify the command to run your application
CMD ["java", "-jar", "/app/subtitle-downloader.jar"]
