#!/bin/bash

adduser -D $SSH_USERNAME
echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
