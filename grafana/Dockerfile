FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache grafana; \
	apk add --no-cache influxdb; \
	apk add --no-cache telegraf

COPY telegraf.conf /root/.telegraf/telegraf.conf
COPY start.sh /start.sh
# TODO : grafana config file

EXPOSE 3000

ENTRYPOINT [ "sh", "/start.sh" ]