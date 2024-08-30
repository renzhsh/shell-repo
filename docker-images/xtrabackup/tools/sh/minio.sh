if [[ !($MINIO_URL && $MINIO_ACCESSKEY && $MINIO_SECRETKEY && $MINIO_BUCKET) ]]; then
	echo '请先设置变量：MINIO_URL, MINIO_ACCESSKEY, MINIO_SECRETKEY, MINIO_BUCKET'
	exit 1;
fi

mc alias set myminio $MINIO_URL $MINIO_ACCESSKEY $MINIO_SECRETKEY;

if [[ $? != 0 ]]; then
	exit 1;
fi

if [[ $1 == 'upload' ]]; then
	mc od if=$2 of=myminio/$MINIO_BUCKET/mysql/$2  size=10MiB
fi

if [[ $1 == 'download' ]]; then
	wget $MINIO_URL/$MINIO_BUCKET/mysql/$2
fi