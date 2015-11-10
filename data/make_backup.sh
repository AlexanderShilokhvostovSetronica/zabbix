#!/bin/bash

set -x

data=`date "+%G_%m_%d_%N"`
home_dir=/var/lib/mysql
log=${home_dir}/backup/backup.logs

function get_size {
    ls -lh $1 | awk '{print $5}'
}

echo -e "\nStart the backup script $0, in ${data}" >> ${log}

echo "Dumping the zabbix DB" >> ${log}
mysqldump zabbix -pmypassword > ${home_dir}/backup/zabbix_db_backup_${data}.dump
if [ $? -eq 0 ]; then
    echo -n "The file zabbix_db_backup_${data}.dump is done this size `get_size ${home_dir}/backup/zabbix_db_backup_${data}.dump`" >> ${log}
    gzip -9 ${home_dir}/backup/zabbix_db_backup_${data}.dump
    if [ $? -eq 0 ]; then
        echo " -> archived `get_size ${home_dir}/backup/zabbix_db_backup_${data}.dump.gz`" >> ${log}
    else
        echo -e "\n\tError in archive in zabbix db" >> ${log}
        exit 1
    fi
else
    echo -e "\n\tError backup in zabbix db" >> ${log}
    exit 1
fi

echo "Dumping all DBs" >> ${log}
mysqldump --all-databases -pmypassword > ${home_dir}/backup/all_db_backup_${data}.dump
if [ $? -eq 0 ]; then
    echo -n "The file all_db_backup_${data}.dump is done this size `get_size ${home_dir}/backup/all_db_backup_${data}.dump`" >> ${log}
    gzip -9 ${home_dir}/backup/all_db_backup_${data}.dump
    if [ $? -eq 0 ]; then
        echo " -> archived `get_size ${home_dir}/backup/all_db_backup_${data}.dump.gz`" >> ${log}
    else
        echo -e "\n\tError in archive in all dbs" >> ${log}
        exit 1
    fi
else
    echo -e "\n\tError backup in all dbs" >> ${log}
    exit 1
fi


count=`find ${home_dir}/backup -type f -ctime +3 -print | wc -l`

if [ -s ${home_dir}/backup/all_db_backup_${data}.dump.gz -a $count -gt 0 ]; then
    echo "Deleting old file(s) " >> ${log}
    find ${home_dir}/backup -type f -ctime +3 -print -delete >> ${log}
else
    echo "Nothing to delete" >> ${log}
fi
