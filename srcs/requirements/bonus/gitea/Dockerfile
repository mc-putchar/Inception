ARG version
FROM alpine:${version}
ENV LANG C.UTF-8

RUN apk update \
	&& apk add gitea
RUN chown -R gitea /var/lib/gitea /etc/gitea

USER gitea
EXPOSE 22 3000
ENTRYPOINT [ "/usr/bin/gitea" ]
