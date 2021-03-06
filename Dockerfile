# FROM hub.c.163.com/nce2/nodejs:0.12.2  # Create app directory
# CMD pm2 start app.js --no-daemon // 设置启动方式
# #  或者 使用   pm2-docker
# CMD pm2-docker start app.js
# https://www.jianshu.com/p/ab76ba86eafc
# http://blog.w2fzu.com/2016/11/21/2016-11-21-Node-and-Mysql-deploy-on-Docker/

FROM node:8
COPY sources.list /etc/apt/sources.list
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

WORKDIR /app

RUN cnpm install gulp -g 
RUN cnpm install bower -g

# COPY ./package.json /app/
COPY . /app/

RUN cnpm install
RUN bower install --allow-root
RUN gulp build


EXPOSE 8800

ENV NODE_ENV=production
RUN npm install pm2 -g
# CMD bin/prod-web.sh
CMD ["pm2",  "start", "app.js","--no-daemon"]

# 启动命令
# CMD ["pm2-docker", "process.json"]
#  https://yunnysunny.gitbooks.io/nodebook/content/09_node_production.html