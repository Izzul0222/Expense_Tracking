
#Build with Ant 
# Stage 1: Build with Ant (pinned version)
FROM ant:latest  AS builder
WORKDIR /app
COPY . .
RUN ant TransactionBuild.war

# Stage 2: Runtime
FROM tomcat:9.0-jdk17-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/TransactionBuild.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
