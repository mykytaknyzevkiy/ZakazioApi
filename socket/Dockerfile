FROM gradle:latest AS builder

USER root
WORKDIR /usr/socket/src/java-code
COPY .. /usr/socket/src/java-code/

RUN gradle bootWar --stacktrace

FROM openjdk:latest

WORKDIR /usr/socket/src/java-app
COPY --from=builder /usr/socket/src/java-code/build/libs/*.war ./app.war
ENTRYPOINT ["java", "-jar", "app.war"]