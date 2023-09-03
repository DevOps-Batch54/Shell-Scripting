#!/bin/bash
#echo "I am Frontend"
ID=$(id -u)
if [ $ID -ne 0 ] ; then
echo -e "\e[34m This script is expected to be run by a root user or with a sudo previlage \e[0m"
exit 1;
fi
echo "Installing Nginx"
yum install mginx -y

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
