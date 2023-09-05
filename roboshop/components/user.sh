#!bin/bash
COMPONENT=user
source components/common.sh

echo -n "Configure the $COMPONENT setup "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> LOGFILE
stat $?
echo -n "Installing the NODEJS:"
yum install nodejs -y &>> LOGFILE
stat $?

