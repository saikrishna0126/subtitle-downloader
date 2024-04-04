# Use an openjdk base image
FROM tomcat:9.0.87-jdk11-temurin-focal

MAINTAINER sai

RUN apt-get update && apt-get -y upgrade

WORKDIR /usr/local/tomcat
COPY target/*.jar /usr/local/tomcat/webapps
#COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
#COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

EXPOSE 8080
