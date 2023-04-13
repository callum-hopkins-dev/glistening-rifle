FROM fedora:latest AS openjdk

WORKDIR /usr/local/bin

RUN dnf update -y && dnf install \
    java-17-openjdk-headless -y

RUN curl --output fabric-server.jar https://meta.fabricmc.net/v2/versions/loader/1.19.2/0.14.19/0.11.2/server/jar

RUN echo "eula=true" > eula.txt

COPY . .

ENTRYPOINT [ "/usr/bin/java", "-Xms2048M", "-Xmx8192M", "-jar", "/usr/local/bin/fabric-server.jar", "--nogui", "--universe", "/var/universe/" ]