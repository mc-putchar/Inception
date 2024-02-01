ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

# RUN addgroup -S www-data \
RUN adduser -S -G www-data www-data \
	&& mkdir -p /var/www/html /var/log/php81 \
	&& chown -R www-data:www-data /var/www/html /var/log/php81 \
	&& apk update \
	&& apk add curl ca-certificates ghostscript imagemagick php81 fcgi \
	&& apk add php81-fpm php81-mysqli php81-phar php81-mbstring php81-cgi \
	php81-common php81-session php81-iconv php81-json php81-gd php81-curl \
	php81-xml php81-imap php81-pdo php81-pdo_mysql php81-soap php81-posix \
	php81-gettext php81-ldap php81-ctype php81-dom php81-simplexml php81-zip \
	php81-tokenizer

WORKDIR /usr/local/bin
RUN curl -o wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp
COPY entrypoint.sh /usr/local/bin/

WORKDIR /var/www/html
USER www-data
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 9000
CMD [ "php-fpm81", "-F" ]
