FROM quay.io/orgsync/java:1.8

MAINTAINER Joshua Griffith <joshua@orgsync.com>

RUN apt-get update && apt-get install -y unzip wget curl git docker.io jq

ENV KAFKA_VERSION="0.9.0.0" SCALA_VERSION="2.11"
ADD download-kafka.sh /tmp/download-kafka.sh
RUN /tmp/download-kafka.sh
RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
