FROM registry.access.redhat.com/ubi8/openjdk-11:latest AS build
RUN mkdir -p /home/jboss/src
COPY . /home/jboss/src
WORKDIR /home/jboss/src
RUN ./gradlew --no-daemon test bootJar

FROM registry.access.redhat.com/ubi8/openjdk-11-runtime:latest
EXPOSE 8080
COPY --from=build /home/jboss/src/build/libs/gradle-example-0.0.1-SNAPSHOT.jar /home/jboss/app.jar
ENTRYPOINT ["java","-jar","/home/jboss/app.jar"]
