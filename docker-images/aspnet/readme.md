# aspnet

## 构建程序镜像
```Dockerfile
FROM registry.mascj.com/aspnet:final
# 将应用程序复制到主目录
COPY ./wwwroot /var/www/wwwroot
```