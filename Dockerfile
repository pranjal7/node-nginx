####Version 2.0#######
FROM jshmrtn/s2i-nodejs-nginx

RUN npm ci -f

RUN mkdir -p /usr/share/nginx/html
#ADD ./package.json /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
#RUN npm install
#ADD . /usr/share/nginx/html
#COPY ./nginx.conf /etc/nginx/nginx.conf
#FROM nginx


#######Version 1.0######

#RUN apt-get update \
#  && apt-get install --assume-yes --no-install-recommends\
#    apt-transport-https \
#    build-essential \
#    bzip2 \
#    curl \
#    git \
#    rlwrap \
#    vim \
#  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
#  && apt-get install --assume-yes --no-install-recommends nodejs \
#  && apt-get clean

#CMD nginx -g 'daemon off;'
