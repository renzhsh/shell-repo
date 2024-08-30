cd /tmp

/opt/minio.sh download $1.tar.gz
tar -zxvf $1.tar.gz

if [[ -d /var/lib/mysql ]]; then
	rm -rf /var/lib/mysql
fi

xtrabackup --copy-back --target-dir=/tmp/$1