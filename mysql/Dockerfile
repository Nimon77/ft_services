FROM alpine:latest

RUN apk update; \
	apk add --no-cache mysql mysql-client supervisor expect

# RUN SECURE_MYSQL=$(expect -c " \
# 		set timeout 10\
# 		spawn mysql_secure_installation\
# 		expect \"Enter current password for root (enter for none):\"\
# 		send \"nsimon\r\"\
# 		expect \"Change the root password?\"\
# 		send \"n\r\"\
# 		expect \"Remove anonymous users?\"\
# 		send \"y\r\"\
# 		expect \"Disallow root login remotely?\"\
# 		send \"y\r\"\
# 		expect \"Remove test database and access to it?\"\
# 		send \"y\r\"\
# 		expect \"Reload privilege tables now?\"\
# 		send \"y\r\"\
# 		expect eof\
# 	");\
# 	echo "$SECURE_MYSQL"

RUN apk del expect

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3306

#ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["sh"]
