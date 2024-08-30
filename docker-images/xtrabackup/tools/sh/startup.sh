#! /bin/bash

# crontab 无法读取环境变量，只能在系统启动时把需要的变量写入profile文件
env |grep MYSQL_HOST |awk '{print "export "$1}' >> ~/.profile
env |grep MYSQL_PORT |awk '{print "export "$1}' >> ~/.profile
env |grep BACKUP_USER |awk '{print "export "$1}' >> ~/.profile
env |grep BACKUP_PWD |awk '{print "export "$1}' >> ~/.profile

TRUE="true";
if [[ $AUTO_BACKUP = $TRUE ]]; then
	echo 'AUTO_BACKUP=true, 启动cron服务'
	cron;
fi

echo 'hello, xtrabackup! ' && sleep 30d