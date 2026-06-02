# Stage 1: Build the Maven project
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat
FROM tomcat:10.1-jdk11-temurin
WORKDIR /usr/local/tomcat

# Copy the built war file as ROOT.war to serve it at the root context path (/)
COPY --from=build /app/target/*.war webapps/ROOT.war

# Expose port 8080 (handled dynamically at runtime by Railway PORT environment variable)
EXPOSE 8080

# Replace the default port 8080 with Railway's dynamic PORT variable in server.xml, then start Tomcat
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" conf/server.xml && catalina.sh run"]
