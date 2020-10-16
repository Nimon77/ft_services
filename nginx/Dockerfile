FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache openssh nginx openssl php7-fpm php7-common supervisor gettext; \
	rm /etc/nginx/conf.d/default.conf

WORKDIR /etc/nginx
RUN mkdir ssl; \
	ssh-keygen -A

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY website.template /etc/nginx/conf.d/website.template
COPY sshd_config /etc/ssh/sshd_config
COPY start.sh /start.sh
COPY index.php /var/www/index.php

EXPOSE 80 443 22

ENTRYPOINT ["/bin/sh", "/start.sh"]
