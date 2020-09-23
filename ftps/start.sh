#!/bin/bash

mkdir -p /var/ftp

adduser -D -h /var/ftp $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
