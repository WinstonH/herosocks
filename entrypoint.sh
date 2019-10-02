#!/bin/sh
sed -i "s/herosocks/$PASSWORD/g" /root/config.json
sed -i "s/chacha20-ietf-poly1305/$METHOD/g" /root/config.json

echo "The password is: $PASSWORD"
echo "The method is: $METHOD"

sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf

mkdir -p /var/tmp/nginx/client_body
mkdir /run/nginx
# start nginx
nginx

# ss
ss-server -c /root/config.json
