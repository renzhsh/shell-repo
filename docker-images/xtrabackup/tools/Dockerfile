FROM registry.mascj.com/mascj/xtrabackup:8.0.30

RUN apt-get install cron -y

ADD sh/backup-cron /etc/cron.d/backup-cron
ADD sh/backup.sh /opt/backup.sh
ADD sh/startup.sh /opt/startup.sh
ADD sh/xtrabackup.sh /opt/xtrabackup.sh

RUN crontab -u root /etc/cron.d/backup-cron

# minio client
ADD ./minio.tar.gz /opt
RUN mv /opt/minio-binaries/mc /usr/bin/mc
RUN apt-get install wget curl -y
ADD sh/minio.sh /opt/minio.sh
ADD sh/snapshot.sh /opt/snapshot.sh
ADD sh/init.sh /opt/init.sh

CMD /opt/startup.sh