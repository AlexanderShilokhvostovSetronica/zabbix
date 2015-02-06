FROM berngp/docker-zabbix

MAINTAINER A.Shilokhvostov <github@shilli.ru>

RUN yum update -y tzdata ;\

sed 's%/mysql-configured%/var/lib/mysql/mysql-configured%' -i /start.sh ;\
echo "Include vhosts.d/*.conf" >> /etc/httpd/conf/httpd.conf ;\
echo "NameVirtualHost *:80" >> /etc/httpd/conf/httpd.conf ;\
rm /etc/httpd/conf.d/zabbix.conf

ADD vhosts.d /etc/httpd/vhosts.d/

