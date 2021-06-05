# Base Image
FROM tomcat:9.0-jdk8

ENV LAREX_VERSION="0.5.0"
ARG ARTIFACTORY_URL=http://artifactory-ls6.informatik.uni-wuerzburg.de/artifactory/libs-snapshot/de/uniwue

MAINTAINER Maximilian Nöth


# Enable Networking on port 8080 (Tomcat)
EXPOSE 8080

# Installing dependencies and deleting cache
RUN apt-get update && apt-get install -y \
    wget

# Download maven project
RUN cd /usr/local/tomcat/webapps/ && \
    wget $ARTIFACTORY_URL/Larex/$LAREX_VERSION/Larex-$LAREX_VERSION.war -O Larex.war

# Create books path
RUN mkdir /home/books

# Copy larex.config
ENV LAREX_CONFIG=/larex.config
