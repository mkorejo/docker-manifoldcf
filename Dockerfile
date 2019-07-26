FROM openjdk:8u212-jre-slim

ENV MANIFOLDCF_VERSION=2.11
ENV POSTGRES_HOSTNAME=localhost POSTGRES_PORT=5432 POSTGRES_SSL=true POSTGRES_USER=manifoldcf POSTGRES_DB=manifoldcf

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN wget http://archive.apache.org/dist/manifoldcf/apache-manifoldcf-${MANIFOLDCF_VERSION}/apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz && \
  tar -xzvf apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz && \
  cp -R apache-manifoldcf-${MANIFOLDCF_VERSION} /usr/share/manifoldcf && \
  chmod +x /wait-for-it.sh && \
  rm apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz

EXPOSE 8345
VOLUME /var/manifoldcf
WORKDIR /usr/share/manifoldcf/multiprocess-file-example

COPY connectors.xml /usr/share/manifoldcf
COPY jetty-options.env.unix properties.xml ./
COPY entrypoint.sh /manifoldcf_entrypoint.sh

RUN chgrp -R 0 /wait-for-it.sh /var/manifoldcf /usr/share/manifoldcf /manifoldcf_entrypoint.sh && \
  chmod -R g=u /wait-for-it.sh /var/manifoldcf /usr/share/manifoldcf /manifoldcf_entrypoint.sh && \
  chmod +x initialize.sh start-agents.sh start-webapps.sh
USER 1001

# ENTRYPOINT overrides default of `/bin/sh -c`
ENTRYPOINT ["/manifoldcf_entrypoint.sh"]
CMD ["start"]
