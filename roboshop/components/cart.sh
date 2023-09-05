#!/bin/bash
COMPONENT=cart
source components/common.sh

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
curl -s -L -o /tmp/cart.zip "https://github.com/stans-robot-project/cart/archive/main.zip"
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

echo -n "Update the Redis & Catalogue IP address:"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/$APPUSER/$COMPONENT
sed -i -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/$APPUSER/$COMPONENT
stat $?
echo -n "update the systemd file as $COMPONENT file"
#chown -R /home/$APPUSER/$COMPONENT $APPUSER:$APPUSER 
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?
echo -n "Start the $COMPONENT"
systemctl daemon-reload &>> LOGFILE
systemctl enable $COMPONENT &>> LOGFILE
systemctl restart $COMPONENT &>> LOGFILE
systemctl status cart -l
stat $?