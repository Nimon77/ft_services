FROM alpine

RUN apk update; \
	apk add --no-cache vsftpd supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

EXPOSE 20 21 20000 20001

ENTRYPOINT ["/bin/sh", "/start.sh"]
#ENTRYPOINT [ "/bin/sh" ]
