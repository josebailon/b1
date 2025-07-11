# Use an official Tomcat runtime as a parent image
FROM tomcat

# Copy the WAR file to the webapps directory of Tomcat
COPY target/webapp-tom.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
