#!/bin/bash
#Simple if
ACTION=$1
if [ "$ACTION" == "start" ]; then
        echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
        #exit 0
fi
#if-else
ACTION=$1
if [ "$ACTION" == "start" ]; then
        echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
        exit 0
else 
        echo -e "\e[32m Available Option is Start only \e[0m"
        exit 1
fi
