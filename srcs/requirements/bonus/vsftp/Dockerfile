ARG version
ARG ftpuser
ARG ftppass
FROM alpine:${version}
ENV LANG C.UTF-8
RUN apk update && apk add vsftpd
RUN mkdir /home/${ftpuser} \
	&& addgroup -S ${ftpuser} \
	&& adduser -D -G ${ftpuser} -h "/home/${ftpuser}" -s /bin/false ${ftpuser} \
	&& echo "${ftpuser}:${ftppass}" | /usr/sbin/chpasswd \
	&& chown -R "${ftpuser}:${ftpuser}" "/home/${ftpuser}" \
	&& chmod 0555 "/home/${ftpuser}"
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]
EXPOSE 21
