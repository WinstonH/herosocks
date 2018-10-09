FROM alpine

#GIT
ENV SS_GIT_PATH="https://github.com/shadowsocks/shadowsocks-libev" \
    OBFS_GIT_PATH="https://github.com/shadowsocks/simple-obfs" 

#Download applications
RUN apk --update add --no-cache nginx \
                                ca-certificates \
                                libcrypto1.0 \
                                libev \
                                libsodium \
                                mbedtls \
                                pcre \
                                c-ares \
    && apk add --no-cache --virtual TMP git \
                                        autoconf \
                                        automake \
                                        make \
                                        build-base \
                                        zlib-dev \
                                        gettext-dev \
                                        asciidoc \
                                        xmlto \
                                        libpcre32 \
                                        libev-dev \
                                        libsodium-dev \
                                        libtool \
                                        linux-headers \
                                        mbedtls-dev \
                                        openssl-dev \
                                        pcre-dev \
                                        c-ares-dev \
                                        g++ \
                                        gcc \

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
   && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/
COPY default.conf /etc/nginx/conf.d/
COPY config.json /root/

CMD ["entrypoint.sh"]
