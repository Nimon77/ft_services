FROM alpine:latest

RUN apk update; \
	apk add --no-cache mysql mysql-client supervisor expect

RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql; \
	mkdir /run/mysqld

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY setup_database.sh /
COPY create_tables.sql /

RUN sh setup_database.sh

RUN apk del expect; rm setup_database.sh create_tables.sql

EXPOSE 3306

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
