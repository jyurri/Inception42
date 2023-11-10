FROM alpine:3.18.3

RUN apk update && apk add mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools ./tools


RUN chmod +x ./tools/setup.sh

CMD ["./tools/setup.sh"]