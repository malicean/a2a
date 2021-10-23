FROM alpine:latest

# Setup
WORKDIR /server
COPY src/universal .
COPY src/overrides/server .
RUN apk update

# Installation
RUN apk add --no-cache curl && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted openjdk17-jre-headless
RUN curl -L -o installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.8.1/fabric-installer-0.8.1.jar
RUN java -jar installer.jar server -downloadMinecraft -mcversion 1.17.1

# Cleanup
RUN rm installer.jar && apk del curl

VOLUME "/server"
ENTRYPOINT [ "java", "-jar", "-Xms4G", "-Xmx8G" "fabric-server-launch.jar" ]