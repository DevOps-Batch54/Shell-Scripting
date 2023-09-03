#!/bin/bash
#echo "I am Frontend"
COMPONENT=frontend
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
yum install nginx -y &>> "/tmp/${COMPONENT}.log"
stat $?
echo -n "Downloading the ${COMPONENT} component"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?
echo -n "Performing Cleanup :"
cd /usr/share/nginx/html
rm -rf * &>> "/tmp/${COMPONENT}.log"
stat $?

echo -n "Extractting the ${COMPONENT} component"
unzip /tmp/${COMPONENT}.zip
mv ${COMPONENT}-main/* . &>> "/tmp/${COMPONENT}.log"
mv static/* . &>> "/tmp/${COMPONENT}.log"
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

#It's always a great idea to preform validation before you get an exception.
#if the script is exectuted as a root user or a sudo user, then it as to proceed.
#if not, I was to exit the script with some nice message.

# The frontend is the service in RobotShop to serve the web content over Nginx.

# Install Nginx.

# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.
