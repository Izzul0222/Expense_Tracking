# Stage 1: Build with Ant using JDK 17
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Install Ant and copy your entire project
RUN apt-get update && \
    apt-get install -y ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy all files including build.xml
COPY . .

# Verify files are copied correctly (debugging)
RUN ls -la

# Run the Ant build (adjust target name if needed)
RUN ant dist

# Stage 2: Runtime with Tomcat
FROM tomcat:9.0-jdk17-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/dist/TransactionBuild.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]