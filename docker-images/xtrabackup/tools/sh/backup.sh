#! /bin/bash
. ~/.profile;

# 备份说明
## 目录存储以月份分割，例如 /backup/2022-11,/backup/2022-12, /backup/2023-01
## 每个周一做全量备份，其他几天做增量备份
## 每个月的第一天也是全量备份

## yesterday date -d 'last day'

baseDir=/backup/$(date +%Y-%m)
today_week=$(date +%u)

last_all_dir=$baseDir/$(date -d 'last day' +%Y%m%d)-all
last_incr_dir=$baseDir/$(date -d 'last day' +%Y%m%d)-incr
today_all_dir=$baseDir/$(date +%Y%m%d)-all
today_incr_dir=$baseDir/$(date +%Y%m%d)-incr

if [ ! -d $baseDir ]; then
	mkdir $baseDir
fi
# 今天如果是周一，则全量备份，结束
if [ $today_week -eq 1 ]; then
	echo '周一全量备份:'$today_all_dir
	/opt/xtrabackup.sh $today_all_dir
	exit 0;
fi
# 查找昨天的备份目录
# 如果存在，则增量备份

if [ -d $last_all_dir ]; then
	echo '存在目录：'$last_all_dir'增量备份:'$today_incr_dir
	/opt/xtrabackup.sh $today_incr_dir $last_all_dir
elif [ -d $last_incr_dir ]; then
	echo '存在目录：'$last_incr_dir'增量备份:'$today_incr_dir
	/opt/xtrabackup.sh $today_incr_dir $last_incr_dir
else
	# 如果不存在，则全量备份
	echo '不存在昨天的目录, 全量备份:'$today_all_dir
	/opt/xtrabackup.sh $today_all_dir
fi