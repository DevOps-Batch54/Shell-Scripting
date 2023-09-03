#!/bin/bash
#echo "I am Frontend"
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"
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
echo -n "Installing Nginx :"
yum install nginx -y &>> LOGFILE
stat $?
echo -n "Downloading the ${COMPONENT} component"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?
echo -n "Performing Cleanup :"
cd /usr/share/nginx/html
rm -rf * &>> LOGFILE
stat $?

echo -n "Extractting the ${COMPONENT} component"
unzip /tmp/${COMPONENT}.zip &>> LOGFILE
mv ${COMPONENT}-main/* . &>> LOGFILE
mv static/* . &>> LOGFILE
rm -rf ${COMPONENT}-main README.md 
mv localhost.conf /etc/nginx/default.d/roboshop.conf 
stat $?

echo -n "update the backend component reverseproxy details"
for component in catalogue ; do 
sed -i -e "/$component/s/localhost/$component.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
done
stat $?

echo -n "Start the $COMPONENT service:"
systemctl daemon-reload 
systemctl enable nginx
systemctl start nginx
stat $?

