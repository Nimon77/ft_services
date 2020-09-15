FROM alpine

RUN	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache nginx php7 php7-fpm php7-opcache php7-common php7-mysqli php7-json telegraf supervisor; \
	rm /etc/nginx/conf.d/default.conf

RUN	wget https://wordpress.org/latest.tar.gz; \
	tar -xzvf latest.tar.gz -C /var/www; \
	rm latest.tar.gz

COPY wp-config.php /var/www/wordpress/wp-config.php
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 5050

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
