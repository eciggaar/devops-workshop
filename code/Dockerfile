# Use fabric8's s2i Builder image.
# https://hub.docker.com/r/fabric8/s2i-java
FROM fabric8/s2i-java:2.0

# Who is responsible for doing this?
###Un-comment the line after the example:  
###MAINTAINER Mary <mary@mary.io>
#MAINTAINER

# Copy the JAR file to the deployment directory.
ENV JAVA_APP_DIR=/deployments
COPY target/vertx-nov05-1.0-SNAPSHOT.jar /deployments/
