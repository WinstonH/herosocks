#!/bin/sh
sed -i "s/PASSWORD/$PASSWORD/g" /root/config.json
sed -i "s/METHOD/$METHOD/g" /root/config.json

echo "The password is: $PASSWORD"
echo "The method is: $METHOD"

sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf

mkdir -p /var/tmp/nginx/client_body
mkdir /run/nginx
# start nginx
nginx

# ss
ss-server -c /root/config.json
