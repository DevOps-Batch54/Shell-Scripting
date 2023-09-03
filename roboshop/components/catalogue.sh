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
id $APPUSER &>> LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating the service account"
useradd $APPUSER &>> LOGFILE
stat $?
fi
echo -n "Downloading the $COMPONENT component:"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?
echo -n "Copying the $COMPONENT to $APPUSER home directory :"
cd /home/$APPUSER
rm -rf $COMPONENT &>> LOGFILE
unzip -o /tmp/$COMPONENT.zip &>> LOGFILE
stat $?
echo -n "Modifying the ownership :"
mv $COMPONENT-main $COMPONENT &>> LOGFILE
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT                        
cd /home/$APPUSER/$COMPONENT
npm install -y &>> LOGFILE
stat $?
echo -n "Update the mongodb IP address:"
sed -i -e 's/MONGO_DNSNAME/172.31.93.104/' /home/$APPUSER/$COMPONENT-main/systemd.service
stat $?
echo -n "update the systemd file as $COMPONENT file"
#chown -R /home/$APPUSER/$COMPONENT $APPUSER:$APPUSER 
mv /home/$APPUSER/$COMPONENT-main/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?
echo -n "Start the $COMPONENT"
systemctl daemon-reload $COMPONENT
systemctl start $COMPONENT &>> LOGFILE
systemctl enable $COMPONENT &>> LOGFILE
systemctl status $COMPONENT -l
stat $?