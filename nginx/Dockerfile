FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
	apk update; \
	apk add --no-cache nginx openssl php7-fpm php7-common telegraf supervisor; \
	rm /etc/nginx/conf.d/default.conf

WORKDIR /etc/nginx
RUN mkdir ssl; \
	cd ssl; \
	openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
	-keyout privateKey.key -out certificate.crt -nodes \
	-subj '/C=FR/L=Paris/O=42 Network/OU=nsimon/CN=127.0.0.1/emailAddress=nsimon@student.42.fr'

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/index.html

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
