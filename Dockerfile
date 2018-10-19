FROM ubuntu:18.04

LABEL MAINTAINER="Łukasz Żułnowski <lzulnowski@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN set -ex \
    && apt-get update -yqq \
    && apt-get upgrade -yqq\
    && apt-get install -yqq \
           gnupg \
           dirmngr \
           iptables \
    && echo "deb http://repo.pritunl.com/stable/apt bionic main" >> /etc/apt/sources.list.d/pritunl.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A \
    && apt-get update \
    && apt-get install -yqq \
        pritunl \ 
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

ADD entrypoint.sh ./entrypoint.sh

EXPOSE 80
EXPOSE 443
EXPOSE 1194
EXPOSE 1194/udp
EXPOSE 1194/tcp

ENTRYPOINT ["./entrypoint.sh"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

