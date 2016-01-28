#!/bin/bash

mysqldump -p mypassword zabbix < $1 #for ./backup/zabbix_db_backup_${data}.dump file
#mysqldump -p mypassword < $1 #for ./backup/all_db_backup_${data}.dump file
