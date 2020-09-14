FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache influxdb telegraf supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY telegraf.conf /root/.telegraf/telegraf.conf

EXPOSE 3000

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
