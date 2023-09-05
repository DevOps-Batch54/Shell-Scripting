#!/bin/bash
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
