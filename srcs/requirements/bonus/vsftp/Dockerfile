ARG version
FROM alpine:${version}
ENV LANG C.UTF-8
ARG ftpuser
ARG ftppass
RUN apk update && apk add vsftpd
RUN mkdir /home/${ftpuser} \
	&& addgroup -S ${ftpuser} \
	&& adduser -D -G ${ftpuser} -h "/home/${ftpuser}" -s /bin/false ${ftpuser} \
	&& echo "${ftpuser}:${ftppass}" | /usr/sbin/chpasswd \
	&& chown -R "${ftpuser}:${ftpuser}" "/home/${ftpuser}" \
	&& chmod 0555 "/home/${ftpuser}"
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]
EXPOSE 4221 42000-42010
