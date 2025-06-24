
#Build with Ant 
# Stage 1: Build with Ant (pinned version)
FROM ant:1.10.14-jdk17 AS builder
WORKDIR /app
COPY . .
RUN ant TransactionBuild.war

# Stage 2: Runtime
FROM tomcat:9.0.84-jdk17
RUN rm -rf C:/tomcat/apache-tomcat-9.0.84/webapps/*
COPY --from=builder /app/TransactionBuild.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
