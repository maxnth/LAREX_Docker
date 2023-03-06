# Base Image
FROM tomcat:9.0.73-jdk8

ENV LAREX_VERSION="master"
ARG REPOSITORY_URL=https://github.com/OCR4all/LAREX

MAINTAINER Maximilian Nöth<maximilian.noeth@uni-wuerzburg.de>

# Enable Networking on port 8080 (Tomcat)
EXPOSE 8080

# Installing dependencies and deleting cache
RUN apt-get update && apt-get install -y \
    maven git

# Download source code
RUN git clone https://github.com/OCR4all/LAREX
WORKDIR LAREX
RUN mvn clean install -f pom.xml
RUN cp target/Larex.war /usr/local/tomcat/webapps/Larex.war

# Create books and savedir path
RUN mkdir /home/books /home/savedir

# Copy larex.properties
COPY default.properties /larex.properties
ENV LAREX_CONFIG=/larex.properties
