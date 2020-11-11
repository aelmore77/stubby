FROM ubuntu:focal
LABEL maintainer="Adam Elmore <aelmore@gmail.com>"

ENV DEBIAN_FRONTEND="noninteractive" \
  PUID="1000" \
  PGID="1000"

RUN set -e -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    stubby \
    gosu \
    authbind && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

COPY ./entrypoint.sh /

EXPOSE 53/udp

ENTRYPOINT ["/entrypoint.sh"]