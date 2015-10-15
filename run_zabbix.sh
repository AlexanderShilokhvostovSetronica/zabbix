#!/bin/bash

docker rm -v zabbix
docker run --name=zabbix -p 10051:10051 -p 10052:10052 -p 81:80 -p 2812:2812 -d -v /srv/md1/zabbix/data:/var/lib/mysql -v /srv/md1/zabbix/alert_script:/usr/lib/zabbix/alertscripts ashilokhvostov/zabbix:latest
