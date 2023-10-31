FROM alpine:3.18.3

RUN	apk update && apk upgrade && apk add --no-cache \
        nginx \
        openssl

RUN mkdir /etc/nginx/ssl

COPY tools ./tools
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x tools/setup.sh

EXPOSE 443

ENTRYPOINT ["./tools/setup.sh"]