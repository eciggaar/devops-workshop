# Use fabric8's s2i Builder image.
# https://hub.docker.com/r/fabric8/s2i-java
FROM fabric8/s2i-java:2.0

# Who is responsible for doing this?
MAINTAINER Mary <mary.grygleski@ibm.com>

# Copy the JAR file to the deployment directory.
ENV JAVA_APP_DIR=/deployments
COPY target/vertx-aug14-1.0-SNAPSHOT.jar /deployments/
