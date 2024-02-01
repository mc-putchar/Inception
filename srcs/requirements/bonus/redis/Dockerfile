ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

RUN addgroup -S redis \
	&& adduser -S -G redis redis \
	&& mkdir -p /var/lib/redis /var/log/redis \
	&& chown -R redis:redis /var/lib/redis /var/log/redis \
	&& apk update \
	&& apk add redis

USER redis
ENTRYPOINT [ "redis-server", "/etc/redis.conf" ]
EXPOSE 6379
