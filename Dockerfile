FROM centos:7.4.1708
LABEL maintainer="iefcuxy@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN yum makecache \
 && yum install -y squid ruby

ADD ./files /files
COPY entrypoint.sh /sbin/entrypoint.sh
RUN mv /files/squid/* /etc/squid/ \
    && chmod +x /etc/squid/url_rewriter.rb \
    && chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
