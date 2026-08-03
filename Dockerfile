# Stage 1: Build the Maven project
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat 10 (Compatible nativamente con Jakarta EE)
FROM tomcat:10.1-jdk11-temurin
WORKDIR /usr/local/tomcat

# Copy the built war file as ROOT.war to serve it at the root context path (/)
COPY --from=build /app/target/*.war webapps/ROOT.war

# Replace port="8080" with port="${http.port}" in server.xml
RUN sed -i 's/port="8080"/port="${http.port}"/g' conf/server.xml

# Create setenv.sh to pass the dynamic $PORT env variable (Funciona perfecto en Render)
RUN echo 'export CATALINA_OPTS="$CATALINA_OPTS -Dhttp.port=${PORT:-8080}"' > bin/setenv.sh && chmod +x bin/setenv.sh

# Expose port 8080 (fallback/default)
EXPOSE 8080

# Run Tomcat using the default entrypoint command
CMD ["catalina.sh", "run"]