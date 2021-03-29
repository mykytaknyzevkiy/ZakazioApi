FROM ubuntu

COPY . /usr/src/java-code/
RUN ls -la /

FROM gradle:latest AS builder

USER root
WORKDIR /usr/src/java-code

RUN gradle bootWar --stacktrace

FROM openjdk:latest

WORKDIR /usr/src/java-app
COPY --from=builder /usr/src/java-code/build/libs/*.war ./app.war
ENTRYPOINT ["java", "-jar", "app.war"]