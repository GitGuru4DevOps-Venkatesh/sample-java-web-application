FROM tomcat:9.0-jdk17-openjdk

COPY target/sample-java-webapp.war /usr/local/tomcat/webapps/

EXPOSE 8000

CMD ["catalina.sh", "run"]
