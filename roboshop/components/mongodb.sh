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
# echo -n "starting $COMPONENT"
# systemctl enable mongod &>> LOGFILE
# systemctl start mongod &>> LOGFILE
# stat $?
echo -n "Enabling the DB Visibility:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?
echo -n "Starting $COMPONENT"
systemctl daemon-reload mongod &>> LOGFILE
systemctl enable mongod &>> LOGFILE
systemctl restart mongod &>> LOGFILE
stat $?

echo -n "Download the Schema of $COMPONENT"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?
echo -n "Extracting the $COMPONENT scheme:"
cd /tmp
unzip -o mongodb.zip &>> LOGFILE
stat $?

echo -n "Injecting the schema:"
cd $COMPONENT-main
mongo < catalogue.js &>> LOGFILE
mongo < users.js &>> LOGFILE
stat $?
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js