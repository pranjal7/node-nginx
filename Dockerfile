####Version 2.0#######
FROM node:10-slim  

#Install and configure npm, serve
ENV PORT 3200
ENV NODE_TLS_REJECT_UNAUTHORIZED 1

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force
 
############## nginx setup ##############

RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        git \
        gcc \
        vim \
        vi \
        nano \
        make \
        libpcre3-dev \
        zlib1g-dev \
        libldap2-dev \
        libssl-dev \
        wget \
        jq

# See http://wiki.nginx.org/InstallOptions
RUN mkdir /var/log/nginx \
    && mkdir -p /etc/nginx/sites-enabled \
    && mkdir -p /usr/share/nginx/html \
    && cd ~ \
    && git clone https://github.com/kvspb/nginx-auth-ldap.git \
    && git clone https://github.com/nginx/nginx.git \
    && cd nginx \
    && git checkout tags/release-1.15.5 \
    && ./auto/configure \
        --add-module=/root/nginx-auth-ldap \
        --with-http_ssl_module \
        --with-debug \
        --conf-path=/etc/nginx/nginx.conf \
        --sbin-path=/usr/sbin/nginx \
        --pid-path=/var/run/nginx.pid \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
    && make install \
    && cd .. \
    && rm -rf nginx-auth-ldap \
    && rm -rf nginx

#COPY templates/nginx/nginx.init /etc/init.d/nginx
#RUN chmod +x /etc/init.d/nginx

EXPOSE 80 443

# Addinbuild/static/css /var/www/data

#This app binds to port 3200, so we use the EXPOSE instruction to have it mapped by the docker daemon
EXPOSE 3200

RUN npm i -f



#######Version 1.0######
#FROM nginx
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
