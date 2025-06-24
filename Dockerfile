# Stage 1: Build with Ant using Eclipse Temurin JDK
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Install Ant manually
RUN apt-get update && \
    apt-get install -y ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . .
RUN ant TransactionBuild.war

# Stage 2: Runtime (keep your existing Tomcat configuration)
FROM tomcat:9.0-jdk17-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/TransactionBuild.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]