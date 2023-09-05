#!bin/bash
COMPONENT=user
source components/common.sh

echo -n "Configure the $COMPONENT setup "
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
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/user/archive/main.zip"
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



