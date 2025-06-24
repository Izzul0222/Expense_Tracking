
#Build with Ant 
# Stage 1: Build with Ant (pinned version)
FROM ant:1.10.114-jdk23 AS builder
WORKDIR /app
COPY . .
RUN antb TransactionBuild.war

# Stage 2: Runtime
FROM tomcat:9.0.84-jdk23
RUN rm -rf C:\tomcat\apache-tomcat-9.0.84\webapps\*
COPY target/TransactionBuild.war C:\tomcat\apache-tomcat-9.0.84\webapps\ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]