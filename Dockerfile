FROM alpine:latest

#GIT
ENV SS_GIT_PATH="https://github.com/shadowsocks/shadowsocks-libev" \
    OBFS_GIT_PATH="https://github.com/shadowsocks/simple-obfs" 

#Download applications
RUN apk --update add --no-cache nginx ca-certificates libcrypto1.1 libev libsodium mbedtls pcre c-ares \
&& apk add --no-cache --virtual TMP git autoconf automake make build-base zlib-dev gettext-dev asciidoc xmlto libpcre32 libev-dev \
libsodium-dev libtool linux-headers mbedtls-dev openssl-dev pcre-dev c-ares-dev g++ gcc \

#Compile Shadowsocks + simple-obfs
&& cd /tmp \
&& git clone ${SS_GIT_PATH} \
&& cd ${SS_GIT_PATH##*/} \
&& git submodule update --init --recursive \
&& ./autogen.sh \
&& ./configure --prefix=/usr && make \
&& make install \
&& cd /tmp \
&& git clone ${OBFS_GIT_PATH} \
&& cd ${OBFS_GIT_PATH##*/} \
&& git submodule update --init --recursive \
&& ./autogen.sh \
&& ./configure --prefix=/usr && make \
&& make install \
&& apk del TMP \
&& rm -rf /tmp/* \
&& rm -rf /var/cache/apk/* \
&& rm -rf /var/lib/nginx/html/* \
&& cd /var/lib/nginx/html \
&& wget --no-check-certificate -qO 'demo.tar.gz' "https://github.com/xianren78/v2ray-heroku/raw/master/demo.tar.gz" \
&& tar xvf demo.tar.gz \
&& rm -rf demo.tar.gz

COPY entrypoint.sh /usr/local/bin/
COPY default.conf /etc/nginx/conf.d/
COPY config.json /root/

CMD ["entrypoint.sh"]
