#!bon/bash
COMPONENT=redis
source components/common.sh
echo -n "Download the $COMPONENT repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
yum install redis-6.2.13 -y &>> LOGFILE
stat $?
sed -i -e 's/bind 127.0.0.1 -/bind 0.0.0.0 -/' /etc/redis.conf


# systemctl enable redis
# systemctl start redis
# systemctl status redis -l