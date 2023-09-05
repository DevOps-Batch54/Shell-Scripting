#!/bin/bash
#echo "I am Frontend"
COMPONENT=frontend

source components/common.sh


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

