#!/bin/bash
#echo "I am Catalogue"
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is expected to be run by a root user or with a sudo previlage \e[0m"
    exit 1;
fi

stat () {
if [ $1 -eq 0 ] ; then 
    echo -e "\e[33m Success \e[0m"
        else
    echo -e "\e[31m Failure \e[0m"
    exit 2;
fi
}
echo -e "*******\e[32m Catalogue installation started \e[0m*******"
echo -n "Configure the $COMPONENT repo "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> LOGFILE
stat $?
echo -n "Installing the NODEJS:"
yum install nodejs -y &>> LOGFILE
stat $?
id $APPUSER
if [ $? -ne 0 ] ; then
echo -n "Creating the service account"
useradd $APPUSER
stat $?



# curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
# yum install nodejs -y