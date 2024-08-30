echo $(date +'%D %T')' 备份开始'
if [[ $1 && $2 ]]; then
	echo $(date +'%D %T')' 增量备份, target-dir='$1'incremental-basedir='$2
	xtrabackup --backup --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$BACKUP_USER --password=$BACKUP_PWD --target-dir=$1  --incremental-basedir=$2
elif [ $1 ]; then
	echo $(date +'%D %T')' 全量备份, target-dir='$1
	xtrabackup --backup --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$BACKUP_USER --password=$BACKUP_PWD --target-dir=$1
fi
echo $(date +'%D %T')' 备份结束'