# Use an appropriate base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the Maven project
RUN mvn clean package -DskipTests

# Set the final base image
FROM amazoncorretto:17-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the compiled WAR file from the build stage into the final image
COPY --from=build /app/target/spring-petclinic-1.22.war /app/spring-petclinic.war

# Define the command to run your application
CMD ["java", "-jar", "/app/spring-petclinic.war"]