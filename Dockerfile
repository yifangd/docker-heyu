FROM alpine
MAINTAINER Kevin Eye <kevineye@gmail.com>

RUN apk -U add curl build-base \
 && mkdir /build \
 && cd /build \
 && curl -LsSO http://github.com/msoap/shell2http/releases/download/1.4/shell2http-1.4.amd64.linux.zip \
 && echo 'd0c00a5a0e6ecf664ad865f2e949cf1d8ca2b4b7 *shell2http-1.4.amd64.linux.zip' | sha1sum -c - \
 && unzip shell2http-1.4.amd64.linux.zip shell2http \
 && mv shell2http /usr/local/bin \
 && curl -LsSO https://github.com/HeyuX10Automation/heyu/archive/refs/tags/v2.10.3.tar.gz \
 && echo 'c8e720e8a97ff5f25d209d67b16af52766eb88be *v2.10.3.tar.gz' | sha1sum -c - \
 && tar xzf v2.10.3.tar.gz \
 && cd heyu-2.10.3 \
 && ./Configure --sysconfdir=/etc darwin \
 && make \
 && mkdir -p /var/tmp/heyu /etc/heyu \
 && echo "TTY /dev/ttyS0" > /etc/heyu/x10.conf \
 && make install \
 && cd / \
 && apk --purge del curl build-base \
 && rm -rf /build /etc/ssl /var/cache/apk/* /lib/apk/db/*

RUN cp -r /etc/heyu /etc/heyu.default \
 && mkdir -p /usr/local/var/tmp/heyu \
 && mkdir -p /usr/local/var/lock \
 && chmod 777 /usr/local/var/tmp/heyu \
 && chmod 777 /usr/local/var/lock

VOLUME /etc/heyu
EXPOSE 80

COPY heyu-run.sh /usr/local/bin/heyu-run
CMD heyu-run
