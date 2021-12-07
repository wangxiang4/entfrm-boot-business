#V1.0   Dockerfile文件编写
# 基础镜像
FROM openjdk:8-jdk-alpine
# 维护者信息
MAINTAINER 445184148@qq.com
#数据卷
VOLUME /entfrm-boot
#解决时间
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
&&  echo $TZ > /etc/timezone\
#替换源
&&  echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories \
&&  echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community" >> /etc/apk/repositories \
&&  echo "https://mirror.tuna.tsinghua.edu.cn/alpine/edge/testing" >> /etc/apk/repositories\
#安装nginx
&&  apk add  nginx --no-cache\
#安装redis
&&  apk add  redis --no-cache\
#创建nginx运行基础目录
&&  mkdir -p /run/nginx /var/www/html/entfrm-ui\
#覆盖nginx配置
&&  echo "\
user  root;\
worker_processes  1;\
pid        /var/run/nginx.pid;\
events {\
    worker_connections  1024;\
}\
http {\
    include       /etc/nginx/mime.types;\
    default_type  application/octet-stream;\
    sendfile        on;\
    keepalive_timeout  120;\
    client_max_body_size 20m;\
    gzip  on;\
    server {\
        listen       80;\
        server_name  localhost;\
        location / {\
                root  /var/www/html/entfrm-ui/;\
                try_files \$uri \$uri/ /index.html;\
                index  index.html index.htm;\
        }\
        location /pro/{\
            proxy_pass http://localhost:8888/;\
            proxy_set_header Host \$http_host;\
            proxy_set_header X-Real-IP \$remote_addr;\
            proxy_set_header REMOTE-HOST \$remote_addr;\
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;\
        }\
    }\
}" > /etc/nginx/nginx.conf \
#创建启动脚本
&& touch /etc/init.d/start.sh \
&& chmod +x /etc/init.d/start.sh \
&& echo "#!/bin/sh  " >> /etc/init.d/start.sh\
&& echo "/usr/sbin/nginx  -c /etc/nginx/nginx.conf" >> /etc/init.d/start.sh\
&& echo "/usr/bin/redis-server  &  " >> /etc/init.d/start.sh\
&& echo "java -jar /entfrm-web.jar " >> /etc/init.d/start.sh
#添加前端文件
ADD entfrm-ui/dist/ /var/www/html/entfrm-ui/
#添加应用
ADD entfrm-web/target/entfrm-web.jar entfrm-web.jar
#开放端口
EXPOSE  80  8888
#启动
ENTRYPOINT /bin/sh -c   /etc/init.d/start.sh

#相关脚本
#docker stop entfrm
#docker rm entfrm
#docker rmi $(docker images | grep "entfrm" | awk '{print $3}') 
#docker build -t entfrm:v1.0
#docker run -d -p 8088:80 --name entfrm entfrm:v1.0
#docker run -d -p 8088:80 -p 8888:8888 --link mysql:mysql --link redis:redis --name entfrm entfrm:v1.0
