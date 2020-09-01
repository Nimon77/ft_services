#!/bin/sh

influxd &
telegraf &
grafana-server -homepath /usr/share/grafana/
