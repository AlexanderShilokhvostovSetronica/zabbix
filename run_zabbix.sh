#!/bin/bash

docker run -p 10051:10051 -p 10052:10052 -p 80:80 -p 2812:2812 -d -v /opt/mysql_zabbix:/var/lib/mysql ashilokhvostov/zabbix:latest
