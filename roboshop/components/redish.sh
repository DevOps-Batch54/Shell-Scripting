#!bon/bash
COMPONENT=redis
source components/common.sh
echo -n "Download the $COMPONENT repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
yum install redis-6.2.11 -y &>> LOGFILE
stat $?