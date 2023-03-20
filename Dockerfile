FROM fedora:latest AS openjdk

RUN dnf update -y && dnf install \
    java-17-openjdk-headless -y

FROM openjdk AS forge

RUN curl --output /tmp/forge-1.19.4-45.0.13-installer.jar \
    https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.4-45.0.13/forge-1.19.4-45.0.13-installer.jar

RUN java -jar /tmp/forge-1.19.4-45.0.13-installer.jar --installServer /usr/local/bin

FROM openjdk

COPY --from=forge /usr/local/bin /usr/local/bin

WORKDIR /usr/local/bin

RUN echo "eula=true" > eula.txt

RUN rm user_jvm_args.txt \
    && echo "-Xms2048M" >> user_jvm_args.txt \
    && echo "-Xmx8192M" >> user_jvm_args.txt

COPY . .

ENTRYPOINT [ "/usr/local/bin/run.sh", "--nogui", "--universe", "/var/universe/" ]