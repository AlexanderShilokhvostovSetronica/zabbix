#!/bin/bash

docker rm -f zabbix
docker run -d --name zabbix --restart=always -p 10051:10051 -p 10052:10052 -p 8080:80 -p 2812:2812 -v /opt/mysql_zabbix:/var/lib/mysql ashilokhvostov/old_ver_berngp_zabbix
