FROM mono:latest

# step 1 更新软件源
COPY ./src/sources.list /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update

# step 2 安装软件
RUN apt-get install nginx -y
RUN apt-get install -qy mono-fastcgi-server4


# step 3 配置文件
COPY ./src/fastcgi_params /etc/nginx/fastcgi_params
COPY ./src/nginx.conf /etc/nginx/nginx.conf
COPY ./src/startup.sh /app/startup.sh
RUN chmod u+x /app/startup.sh

# step 4 设置主目录
RUN mkdir /var/www/wwwroot

CMD /app/startup.sh