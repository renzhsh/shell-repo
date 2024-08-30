FROM debian:10

ADD ./xtrabackup.tar.gz /opt

RUN ln -s /opt/percona-xtrabackup-8.0.30-23-Linux-x86_64.glibc2.17/bin/xtrabackup /usr/bin/xtrabackup

RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY sources.list  /etc/apt/sources.list

RUN apt update && apt upgrade -y

ENTRYPOINT cron && sleep 10d