# build on penultimate version
ARG VERSION=3.17-stable
FROM alpine:${VERSION}
LABEL author="mcutura" created="2023/09/30"

RUN apk update && apk upgrade && apk add nginx openssl

RUN mkdir -p /ssl && \
	openssl genpkey -algorithm RSA -out /ssl/private.key && \
	openssl req -new -x509 -sha256 -days 365 -key /ssl/private.key \
	-out /ssl/certificate.pem -subj "/C=DE/L=Berlin/O=42/CN=mcutura"

#RUN rm /etc/nginx/conf.d/default.conf

COPY conf/. /etc/nginx
COPY --chmod=755 launch.sh /launch.sh

#VOLUME [ "/var/log/nginx/log" ]

EXPOSE 443
STOPSIGNAL SIGTERM

CMD [ "./launch" ]
