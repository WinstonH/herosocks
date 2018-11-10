#!/bin/sh
if [ -n "$PASSWORD" ];then
    sed -i "s/herosocks/$PASSWORD/g" /root/config.json
    echo "You've set a password"
    echo "The password is: $PASSWORD"
else
    echo "You didn't set a password"
    echo "Use default password: herosocks"
fi
sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf
mkdir -p /var/tmp/nginx/client_body
mkdir /run/nginx
# start nginx
nginx

# ss
ss-server -c /root/config.json
