FROM alpine:latest

RUN addgroup mysql; \
	mkdir -p /var/mysqld; \
	adduser -D -G mysql -h /var/mysqld mysql; \
	chown mysql:mysql /var/mysqld

RUN apk update; \
	apk add --no-cache mysql mysql-client supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY setup_database.sh /
COPY create_tables.sql /
COPY wordpress.sql /
COPY my.cnf /etc/mysql/my.cnf

RUN touch /var/log/mysqld.log; chown mysql:mysql /var/log/mysqld.log;

RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf; \
	sed -i '/skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf; \
	chmod +x /setup_database.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
