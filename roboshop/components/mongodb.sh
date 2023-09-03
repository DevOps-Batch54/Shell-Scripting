#!/bin/bash
#echo "I am Mongodb"
COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"
ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is expected to be run by a root user or with a sudo previlage \e[0m"
    exit 1;
fi

stat() {
if [ $1 -eq 0 ] ; then 
    echo -e "\e[33m Success \e[0m"
        else
    echo -e "\e[31m Failure \e[0m"
    exit 2;
fi
}
echo -n "Configuring the $mongodb repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?
echo -n "Installing $COMPONENT"
yum install -y mongodb-org &>> LOGFILE
stat $?
echo -n "starting $COMPONENT"
systemctl enable mongod &>> LOGFILE
systemctl start mongod &>> LOGFILE
stat $?
echo -n "Enabling the DB Visibility:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?
echo -n "Restarting $COMPONENT"
systemctl daemon-reload mongod
systemctl enable mongod &>> LOGFILE
systemctl restart mongod &>> LOGFILE
stat $?



# # yum install -y mongodb-org
# # systemctl enable mongod
# # systemctl start mongod

# ```

# 1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

# Config file:   `# vim /etc/mongod.conf`