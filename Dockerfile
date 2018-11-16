FROM node:0.12
COPY sources.list /etc/apt/sources.list
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

WORKDIR /app

RUN npm install gulp -g 
RUN npm install bower -g

# COPY ./package.json /app/
COPY . /app/

RUN cnpm install
RUN bower install
RUN gulp build


EXPOSE 8800

CMD node bin/prod-web.sh