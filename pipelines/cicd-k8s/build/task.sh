#!/bin/sh

set -xeu

#export VERSION=$(cat version/version)
#cp version/version docker-build/version

cd app-cicd
ls -la
./gradlew clean assemble
cd -

ls -al app/build/libs

mv app/build/libs/app-1.0.jar docker-build

cat << ---EOF > docker-build/Dockerfile
FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY app-1.0.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
---EOF
