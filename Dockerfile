FROM openjdk:17-jdk-slim
COPY target/my-app-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/app/my-app.jar
WORKDIR /usr/app
CMD ["java", "-jar", "my-app.jar"]
