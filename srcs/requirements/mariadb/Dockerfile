ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

RUN apk update \
	&& apk add mariadb mariadb-client \
	&& mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld \
	&& mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

COPY entrypoint.sh /usr/local/bin/
USER mysql
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3306
CMD [ "mariadbd", "--no-defaults", "--datadir=/var/lib/mysql", \
	"--bind-address=*", "--init-file=/tmp/init.sql" ]
