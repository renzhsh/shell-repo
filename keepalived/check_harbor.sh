#/bin/bash

# 本机IP
IP=$(hostname -I | awk '{print $1}')
# 定义URL
url="https://"$IP"/api/v2.0/health"
#url="http://127.0.0.1:8080/index.html"

# 日志文件路径
LOG_FILE="/etc/keepalived/health/message.log"

# 使用curl发送请求并获取HTTP状态码
status_code=$(curl -o /dev/null -sk -w "%{http_code}\n" "$url")

# 判断状态码是否为200
if [[ "$status_code" -eq 200 ]]; then
    #echo $(date "+%Y-%m-%d %H:%M:%S") "check $url: HTTP状态码为200，请求成功。">> $LOG_FILE
    exit 0
else
    #echo $(date "+%Y-%m-%d %H:%M:%S") "check $url: HTTP状态码为$status_code，请求失败。">> $LOG_FILE
    exit 1
fi
