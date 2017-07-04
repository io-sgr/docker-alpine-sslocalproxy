FROM alpine:edge
MAINTAINER SgrAlpha <admin@mail.sgr.io> 

EXPOSE 1080 8118

RUN set -ex && \
	echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk --update add --no-cache \
		curl \
		privoxy \
		libsodium \
		mbedtls \
		libcrypto1.0 \
		udns \
		pcre \
		libev \
		shadowsocks-libev && \
	sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:8118/' /etc/privoxy/config && \
	echo 'forward-socks5  /       127.0.0.1:1080  .' >> /etc/privoxy/config && \
	mkdir -p /etc/shadowsocks-libev

HEALTHCHECK --interval=10s --timeout=5s --retries=10 CMD curl -x http://127.0.0.1:8118 https://www.google.com/gen_204 || exit 1

CMD privoxy /etc/privoxy/config && ss-local -b 0.0.0.0 -u --fast-open -c /etc/shadowsocks-libev/config.json
