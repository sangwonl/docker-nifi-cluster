FROM ubuntu:16.04

MAINTAINER Sangwon Lee <gamzabaw@gmail.com>

RUN apt-get update &&     \
    apt-get install -y    \
        openjdk-8-jdk     \
        curl

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV NIFI_VERSION=1.1.2
ENV NIFI_HOME=/opt/nifi

ENV NIFI_DOWNLOAD_SITE=https://www.apache.org/dist/nifi/$NIFI_VERSION/nifi-$NIFI_VERSION-bin.tar.gz
RUN curl -vLf $NIFI_DOWNLOAD_SITE -o /tmp/nifi-bin.tar.gz
RUN mkdir -p $NIFI_HOME
RUN tar xfvz /tmp/nifi-bin.tar.gz -C $NIFI_HOME --strip-components=1

ADD nifi.properties $NIFI_HOME/conf/nifi.properties
ADD state-management.xml $NIFI_HOME/conf/state-management.xml
ADD hdfs-site.xml $NIFI_HOME/conf/hdfs-site.xml
ADD start-nifi.sh $NIFI_HOME/start-nifi.sh

VOLUME ["/repos/templates",             \
        "/repos/database_repository",   \
        "/repos/flowfile_repository",   \
        "/repos/content_repository",    \
        "/repos/provenance_repository"]

WORKDIR $NIFI_HOME
EXPOSE 8080 8081 8082

CMD ["./start-nifi.sh"]
