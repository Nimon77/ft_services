FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache grafana supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./provisioning /usr/share/grafana/conf/provisioning

EXPOSE 3000

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
