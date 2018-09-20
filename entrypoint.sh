#!/bin/sh
sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf
mkdir -p /var/tmp/nginx/client_body
mkdir /run/nginx
# start nginx
nginx

# ss
ss-server -c /root/config.json
