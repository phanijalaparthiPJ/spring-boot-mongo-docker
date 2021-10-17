FROM openjdk:16-jdk-alpine
#we are running the application in 8080 port
EXPOSE 8080
MAINTAINER phani <phanij1218@gmail.com>
#to create we need to update packages and add /bin/sh
RUN apk update && apk add /bin/sh
WORKDIR gitclone
RUN apk add git
#Cloning repository
RUN git clone https://github.com/phanijalaparthiPJ/spring-boot-mongo-docker.git
#Installing package for ping command
RUN apk add iputils
#installing maven
RUN apk add maven
WORKDIR /gitclone/spring-boot-mongo-docker/
RUN mvn clean package
#Creating one directory for running the application in it
RUN mkdir -p /opt/app
#creating a environment variable for the above dir
ENV SPRINGAPP_HOME /opt/app
#As we clone, the application jar file will be stored in targed dir. the jar file we are coping into $SPRINGAPP_HOME directory.
RUN cp /gitclone/spring-boot-mongo-docker/target/spring-boot-mongo-1.0.jar $SPRINGAPP_HOME/spring-boot-mongo.jar
WORKDIR $SPRINGAPP_HOME
ENTRYPOINT ["java","-jar","./spring-boot-mongo.jar"]
