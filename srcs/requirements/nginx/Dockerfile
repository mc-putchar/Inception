ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

RUN apk update \
	&& apk add nginx \
	&& touch /var/run/nginx.pid \
#	&& chown nginx:nginx /var/run/nginx.pid \
#	&& chown -R nginx:nginx /var/log/nginx /etc/nginx /var/www

# USER nginx
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
EXPOSE 4243
