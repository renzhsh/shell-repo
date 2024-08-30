file=$1
dir=/tmp/$file/

if [[ -d $dir ]]; then
	rm dir -rf
fi

cd /tmp

# 全量备份
/opt/xtrabackup.sh $dir

# Undo Redo日志回滚
xtrabackup --prepare --target-dir=$dir

tar -zcvf $file.tar.gz $file

# 文件上传
/opt/minio.sh upload $file.tar.gz