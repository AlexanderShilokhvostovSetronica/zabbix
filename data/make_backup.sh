#!/bin/bash
data=`date "+%G_%m_%d_%N"`
home_dir=/var/lib/mysql

mysqldump --all-databases -pmypassword > ${home_dir}/backup/all_db_backup_${data}.dump
mysqldump zabbix -pmypassword > ${home_dir}/backup/zabbix_db_backup_${data}.dump

gzip -9 ${home_dir}/backup/*.dump
find ${home_dir}/backup -type f -ctime +5 -print -delete