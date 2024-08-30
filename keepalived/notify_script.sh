#!/bin/bash

# 脚本名称：notify_script.sh

# 打印传入的参数
echo "Received arguments: $@"
# 日志文件路径
LOG_FILE="/etc/keepalived/health/message.log"
# 本机IP
IP=$(hostname -I | awk '{print $1}')

alert_dingtalk(){
    WEBHOOK_URL="https://oapi.dingtalk.com/robot/send?access_token=61c8557f7331ea5e600584d673a200cc2fa9d2655a520dfbca84b34f00ff06c2"
    MESSAGE_TYPE="text"

    # 要发送的消息内容
    MESSAGE=$1

    # 构造消息体，格式为JSON
    MESSAGE_BODY="{
        \"msgtype\": \"$MESSAGE_TYPE\",
        \"$MESSAGE_TYPE\": {
            \"content\": \"$MESSAGE\"
        }
    }"

    # 发送消息
    curl -X POST "$WEBHOOK_URL" \
        -H 'Content-Type: application/json' \
        -d "$MESSAGE_BODY"
}

# 根据状态参数执行不同的操作
case "$1" in
    master)
        echo $(date "+%Y-%m-%d %H:%M:%S") 'Transitioned to MASTER state' >> $LOG_FILE
        # 在这里添加成为主节点时需要执行的命令
        alert_dingtalk "镜像仓库("$IP") 成为Master节点"
        ;;
    backup)
        echo $(date "+%Y-%m-%d %H:%M:%S") 'Transitioned to BACKUP state' >> $LOG_FILE
        # 在这里添加成为备份节点时需要执行的命令
        alert_dingtalk "镜像仓库("$IP") 成为BACKUP节点"
        ;;
    fault)
        echo $(date "+%Y-%m-%d %H:%M:%S") 'Transitioned to FAULT state' >> $LOG_FILE
        # 在这里添加出现故障时需要执行的命令
        alert_dingtalk "镜像仓库("$IP") 进入FAULT状态"
        ;;
    *)
        echo $(date "+%Y-%m-%d %H:%M:%S") 'Unknown state: $1' >> $LOG_FILE
        exit 1
        ;;
esac

# 返回状态码 0
exit 0