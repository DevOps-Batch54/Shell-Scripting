#!/bin/bash
#echo "I am Mongodb"
COMPONENT=mongodb
source components/common.sh
echo -e "*******\e[32m $COMPONENT installation is started \e[0m*******"
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
echo -n "Extracting the $COMPONENT schema:"
cd /tmp
unzip -o mongodb.zip &>> LOGFILE
stat $?

echo -n "Injecting the schema:"
cd $COMPONENT-main
mongo < catalogue.js &>> LOGFILE
mongo < users.js &>> LOGFILE
stat $?
echo -e "*******\e[32m $COMPONENT installation is completed \e[0m*******"
