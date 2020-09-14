#!/bin/sh

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf &

sleep 5

echo "CREATE USER 'nsimon'@'localhost' IDENTIFIED BY 'nsimon';" | mysql -u root;
echo "GRANT ALL PRIVILEGES ON *.* TO 'nsimon'@'localhost' WITH GRANT OPTION;" | mysql -u root;
echo "FLUSH PRIVILEGES;" | mysql -u root;
echo "CREATE DATABASE wordpress;" | mysql -u root
mysql -u root < create_tables.sql
echo "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'pmapass'; GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost';" | mysql -u root
