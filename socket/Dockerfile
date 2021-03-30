FROM openjdk:latest

ARG JAR_FILE=build/libs/*.war
WORKDIR /socket
COPY ${JAR_FILE} socket.war

ENTRYPOINT ["java", "-jar", "socket.war"]