#!/bin/bash
#Simple if
# ACTION=$1
# if [ "$ACTION" == "start" ]; then
#         echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
#         #exit 0
# fi
# #if-else
# ACTION=$1
# if [ "$ACTION" == "start" ]; then
#         echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
#         exit 0
# else 
#         echo -e "\e[32m Available Option is Start only \e[0m"
#         exit 1
# fi

#else-if
ACTION=$1
if [ "$ACTION" == "start" ]; then
        echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
        exit 0
elif [ "$ACTION" == "restart" ]; then
        echo -e "\e[34m Restarting The RabbitMQ Services \e[0m"
        exit 1
elif [ "$ACTION" == "stop" ]; then
        echo -e "\e[36m Stopping The RabbitMQ Services \e[0m"
        exit 2
elif [ "$ACTION" == "Enable" ]; then
        echo -e "\e[38m Enable The RabbitMQ Services \e[0m"
        exit 3
else 
        echo -e "\e[35m Available Option is Start----Restart----Stop----Enable only \e[0m"
        exit 4
fi
