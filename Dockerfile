# FROM hub.c.163.com/nce2/nodejs:0.12.2  # Create app directory
# CMD pm2 start app.js --no-daemon // 设置启动方式
# #  或者 使用   pm2-docker
# CMD pm2-docker start app.js
# https://www.jianshu.com/p/ab76ba86eafc
# http://blog.w2fzu.com/2016/11/21/2016-11-21-Node-and-Mysql-deploy-on-Docker/

FROM node:0.12
COPY sources.list /etc/apt/sources.list
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

WORKDIR /app

RUN npm install gulp -g 
RUN npm install bower -g

# COPY ./package.json /app/
COPY . /app/

RUN npm install
RUN bower install --allow-root
RUN gulp build


EXPOSE 8800

RUN npm install pm2 -g
CMD node bin/prod-web.sh