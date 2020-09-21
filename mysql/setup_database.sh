#!/bin/sh

if [[ ! -d "/data/mysql" || ! -d "/data/wordpress" || ! -d "/data/phpmyadmin" ]]
then
	echo "creation database"

	mysql_install_db --user=mysql --datadir=/data
	mkdir /run/mysqld

	/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf &

	sleep 3

	echo "CREATE USER 'nsimon'@'%' IDENTIFIED BY 'nsimon';" | mysql -u root;
	echo "GRANT ALL PRIVILEGES ON *.* TO 'nsimon'@'%' WITH GRANT OPTION;" | mysql -u root;
	echo "DELETE FROM mysql.user WHERE User='';" | mysql -u root
	echo "FLUSH PRIVILEGES;" | mysql -u root;
	echo "CREATE DATABASE wordpress;" | mysql -u root
	mysql -u root < create_tables.sql
	#echo "CREATE USER 'pma'@'%' IDENTIFIED BY 'pmapass'; GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'%';" | mysql -u root
fi
