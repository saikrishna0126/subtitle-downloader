FROM tomcat:8.0-alpine

LABEL maintainer="saikrishna"

ADD target/subtitledownloader-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]







# Use an openjdk base image
#FROM tomcat:9.0.87-jdk11-openjdk

#MAINTAINER sai

#RUN apt-get update && apt-get -y upgrade
#COPY target/subtitledownloader-1.0-SNASHOT.jar /usr/local/tomcat/webapps
#COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
#COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

#EXPOSE 8080
