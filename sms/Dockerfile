FROM openjdk:latest

ARG JAR_FILE=build/libs/*.war
WORKDIR /sms
COPY ${JAR_FILE} sms.war

ENTRYPOINT ["java", "-jar", "sms.war"]