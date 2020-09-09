FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=/build/libs/demo-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jadocker r"]

./gradlew bootBuildImage --imageName=zakazio/zakazio