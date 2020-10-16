#!/bin/bash

adduser -D $SSH_USERNAME
echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

envsubst '${WORDPRESS_IP} ${PHPMYADMIN_SVC_SERVICE_HOST}' < /etc/nginx/conf.d/website.template > /etc/nginx/conf.d/website.conf

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
