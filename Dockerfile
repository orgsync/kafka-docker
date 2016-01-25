FROM quay.io/orgsync/java:1.8

MAINTAINER Joshua Griffith <joshua@orgsync.com>

ENV KAFKA_VERSION="0.9.0.0" SCALA_VERSION="2.11"
ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

ADD download-kafka.sh /tmp/download-kafka.sh
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh

RUN apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y curl docker-engine git jq unzip wget \
    && /tmp/download-kafka.sh \
    && tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

CMD ["start-kafka.sh"]
