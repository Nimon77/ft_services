FROM alpine:latest

RUN apk update; \
	apk add --no-cache nginx supervisor php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap \
					   php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-fpm php7-session php7-mbstring; \
	rm /etc/nginx/conf.d/*.conf

RUN DATA="$(wget https://www.phpmyadmin.net/home_page/version.txt -q -O-)"; \
	URL="$(echo $DATA | cut -d ' ' -f 3)"; \
	VERSION="$(echo $DATA | cut -d ' ' -f 1)"; \
	wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz; \
	tar xvf phpMyAdmin-${VERSION}-all-languages.tar.gz; \
	mv phpMyAdmin-*/ /usr/share/phpmyadmin; \
	mkdir -p /var/lib/phpmyadmin/tmp; \
	chown -R www-data:www-data /var/lib/phpmyadmin; \
	mkdir /etc/phpmyadmin/; \
	cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php; \
	rm phpMyAdmin-${VERSION}-all-languages.tar.gz;

RUN	echo "\$cfg['Servers'][\$i]['host'] = 'mysql-svc';" >> /usr/share/phpmyadmin/config.inc.php; \
	echo "\$cfg['Servers'][\$i]['port'] = '3306';" >> /usr/share/phpmyadmin/config.inc.php; \
	echo "\$cfg['Servers'][\$i]['auth_type'] = 'cookie';" >> /usr/share/phpmyadmin/config.inc.php

COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5000

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
#ENTRYPOINT [ "sh" ]
