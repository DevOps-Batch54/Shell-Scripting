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

DOWNLOAD_AND_EXTRACT(){
        echo -n "Downloading the $COMPONENT component:"
        curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
        stat $?
        echo -n "Copying the $COMPONENT to $APPUSER home directory :"
        cd /home/$APPUSER
        rm -rf $COMPONENT &>> LOGFILE
        unzip -o /tmp/$COMPONENT.zip &>> LOGFILE
        stat $?

        echo -n "Modifying the ownership :"
        mv $COMPONENT-main $COMPONENT &>> LOGFILE
        chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT                        
        stat $?
        
}

CREATE_USER(){
        id $APPUSER &>> LOGFILE
        if [ $? -ne 0 ] ; then
        echo -n "Creating the service account"
        useradd $APPUSER &>> LOGFILE
        stat $?
        fi
}

NPM_INSTALL(){

        echo -n "Generating npm $COMPONENT artifactory :"
        cd /home/$APPUSER/$COMPONENT
        npm install -y &>> LOGFILE
        stat $?

}

CONFIGURE_SERVICE(){

        echo -n "Update the mongodb IP address:"
        sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
        stat $?
        echo -n "update the systemd file as $COMPONENT file"
        #chown -R /home/$APPUSER/$COMPONENT $APPUSER:$APPUSER 
        mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
        stat $?
        echo -n "Start the $COMPONENT"
        systemctl daemon-reload &>> LOGFILE
        systemctl enable $COMPONENT &>> LOGFILE
        systemctl restart $COMPONENT &>> LOGFILE
        stat $?

}


NODEJS(){
        echo -n "Configure the $COMPONENT repo "
        curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> LOGFILE
        stat $?
        echo -n "Installing the NODEJS:"
        yum install nodejs -y &>> LOGFILE
        stat $?
        CREATE_USER            #calling create user function to create the roboshop user account
        DOWNLOAD_AND_EXTRACT    # calling DOWNLOAD_AND_EXTRACT function to download the content
        NPM_INSTALL             # calling NPM_INSTALL function to creates artifactory
}