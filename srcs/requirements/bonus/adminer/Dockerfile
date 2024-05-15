ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

RUN	addgroup -S adminer \
	&& adduser -S -G adminer adminer \
	&& mkdir -p /var/www/webapps/adminer /var/log/php81 \
	&& chown -R adminer:adminer /var/www/webapps/adminer /var/log/php81 \
	&& apk update \
	&& apk add curl php81-fpm php81-mysqli php81 fcgi php81-cgi php81-common \
	php81-session php81-iconv php81-json php81-gd php81-curl php81-xml \
	php81-imap php81-pdo php81-pdo_mysql php81-soap php81-posix php81-gettext \
	php81-ldap php81-ctype php81-dom php81-simplexml

WORKDIR /var/www/webapps/adminer
RUN curl -L -o index.php \
https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php \
	&& curl -L -o adminer.css \
https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css

USER adminer
ENTRYPOINT [ "php-fpm81", "-F" ]
EXPOSE 9000
