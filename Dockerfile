FROM gradle:latest AS builder

USER root
WORKDIR /usr/src/java-code
COPY . /usr/src/java-code/

RUN gradle bootWar

FROM openjdk:11-jdk-slim

WORKDIR /usr/src/java-app
COPY --from=builder /usr/src/java-code/build/libs/*.war ./app.war
ENTRYPOINT ["java", "-jar", "app.war"]