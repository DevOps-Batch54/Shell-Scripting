#!bin/bash

COMPONENT=redis
source components/common.sh

echo -n "Download the $COMPONENT repo"
curl -L -o https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
yum install redis-6.2.13 -y &>> LOGFILE
stat $?

echo -n "Enabling the DB Visibility:"
sed -i -e 's/bind 127.0.0.1 -/bind 0.0.0.0 -/' /etc/redis.conf
stat $?

# vim /etc/redis.conf
# vim /etc/redis/redis.conf

# systemctl enable redis
# systemctl start redis
# systemctl status redis -l