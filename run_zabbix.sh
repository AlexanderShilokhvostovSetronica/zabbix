#!/bin/bash

docker run -p 10051:10051 -p 10052:10052 -p 81:80 -p 2812:2812 -d -v /srv/data/docker/zabbix/docker_data:/var/lib/mysql -v /srv/data/git/zabbix/alert_script:/usr/lib/zabbix/alertscripts ashilokhvostov/zabbix:latest
