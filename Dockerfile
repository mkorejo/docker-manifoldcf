FROM debian:jessie
MAINTAINER LWB

ENV MANIFOLDCF_VERSION 2.6

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
    wget curl ca-certificates \
    openjdk-8-jre-headless \
    gzip

RUN wget -O /tmp/manifoldcf.tar.gz wget http://apache.mirror.rafal.ca/manifoldcf/apache-manifoldcf-${MANIFOLDCF_VERSION}/apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz && \
    tar -xzvf /tmp/manifoldcf.tar.gz && \
    cp -R apache-manifoldcf-${MANIFOLDCF_VERSION} /usr/share/manifoldcf && \
    cd /usr/share/manifoldcf/connector-lib-proprietary/ && \
    wget http://jcifs.samba.org/src/jcifs-1.3.18.jar

EXPOSE 8345

WORKDIR /usr/share/manifoldcf/example

CMD ["java", "-jar", "start.jar"]