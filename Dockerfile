FROM openjdk:latest

ARG JAR_FILE=api/build/libs/*.war
WORKDIR /api
COPY ${JAR_FILE} api.war

ENTRYPOINT ["java", "-jar", "api.war"]