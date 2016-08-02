FROM ubuntu:latest

MAINTAINER lucas@vieira.io

RUN apt-get -y update && apt-get -y install bind9

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ["files/entrypoint.sh", "/entrypoint.sh"]

ENTRYPOINT ["bash", "-c", "-l", "/entrypoint.sh"]
