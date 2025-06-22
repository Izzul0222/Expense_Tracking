
FROM tomcat:9.0.84-jdk23
COPY target/TransactionBuild.war C:\tomcat\apache-tomcat-9.0.84\webapps\ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]