nohup nginx -g 'daemon off;' &
fastcgi-mono-server4 /printlog=True /applications=/:/var/www/wwwroot/ /socket=tcp:127.0.0.1:9000 /loglevels=All /verbose=True;