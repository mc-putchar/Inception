ARG version
FROM alpine:${version}
ENV LANG C.UTF-8
RUN apk update \
	&& apk add nginx \
	&& touch /var/run/nginx.pid
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
EXPOSE 4243
