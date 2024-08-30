# xtrabackup

## 1. 数据库的定时备份

拉取镜像

```
docker pull registry.mascj.com/mascj/xtrabackup-tools:1.0
```

环境变量

+ **MYSQL_HOST**: mysql地址
+ **MYSQL_PORT**: mysql端口号
+ **BACKUP_USER**: mysql用户名
+ **BACKUP_PWD**: mysql密码
+ **AUTO_BACKUP**: 设置为`true`

存储挂载

+ **/etc/mysql/my.cnf**: Mysql的配置文件。
+ **/var/lib/mysql**：mysql的存储目录。
+ **/backup**: 备份文件的存储位置。

服务启动后，会在每天的凌晨`02:01:00`执行数据库备份，备份文件存放在`/backup`目录。

备份策略：

+ 目录存储以月份分割，例如 /backup/2022-11,/backup/2022-12, /backup/2023-01
+ 每个周一做全量备份，其他几天做增量备份
+ 每个月的第一天也是全量备份

xtrbackup的具体使用，请参考[xtrabackup 备份及恢复](https://www.cnblogs.com/renzhsh/p/16994448.html),[Xtrabackup 官方文档](https://docs.percona.com/percona-xtrabackup/8.0/backup_scenarios/incremental_backup.html)。

## 2. 数据库的版本快照

拉取镜像

```
docker pull registry.mascj.com/mascj/xtrabackup-tools:1.0
```

环境变量

+ **MYSQL_HOST**: mysql地址
+ **MYSQL_PORT**: mysql端口号
+ **BACKUP_USER**: mysql用户名
+ **BACKUP_PWD**: mysql密码
+ **MINIO_URL**: minio的api接口地址，例如`https://oss-api.mascj.com`
+ **MINIO_ACCESSKEY**: ACCESSKEY
+ **MINIO_SECRETKEY**: SECRETKEY
+ **MINIO_BUCKET**: 存储桶，例如`public`

存储挂载

+ **/etc/mysql/my.cnf**: Mysql的配置文件。
+ **/var/lib/mysql**：mysql的存储目录。

在需要定制版本快照时，在命令行窗口执行：

```sh
/opt/snapshot.sh $fileName
```

在minio的public桶下查看是否存在镜像文件，例如`/public/mysql/pre-mysql-20230110092410`，文件存在，则操作成功。

## 3. 利用数据快照初始化数据库

容器镜像
```
registry.mascj.com/mascj/xtrabackup-tools:1.0
```

环境变量

+ **MINIO_URL**: minio的api接口地址，例如`https://oss-api.mascj.com`
+ **MINIO_ACCESSKEY**: ACCESSKEY
+ **MINIO_SECRETKEY**: SECRETKEY
+ **MINIO_BUCKET**: 存储桶，例如`public`

存储挂载

+ **/etc/mysql/my.cnf**: Mysql的配置文件。
+ **/var/lib/mysql**：mysql的存储目录。

在命令行窗口执行：

```sh
/opt/init.sh $fileName
```

mysql数据已恢复到`/var/lib/mysql`目录。基于此目录启动`mysql`容器就好了。