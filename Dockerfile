FROM alpine:latest

COPY src/universal /server
COPY src/overrides/server /server
WORKDIR /server

RUN apk update && apk add --no-cache curl
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted openjdk17-jre-headless
RUN curl -L -o installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.8.1/fabric-installer-0.8.1.jar
RUN java -jar installer.jar server -downloadMinecraft -mcversion 1.17.1
RUN rm installer.jar
RUN apk del curl
VOLUME [ "/server" ]

ENTRYPOINT [ "java", "-jar", "-Xms4G", "-Xmx8G" "fabric-server-launch.jar" ]