FROM phusion/baseimage:0.9.19

MAINTAINER lucas@vieira.io

RUN apt-get install bind9

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["cp", "/data/name.conf.local", "/etc/bind/" ]

CMD ["/usr/sbin/named", "-f", "-u", "bind" ]
