#!/bin/bash
# Syntax for CASE
# case $var in
#         opt1) command1 ;;
#         opt2) command2 ;;
# esac

ACTION=$1
case $ACTION in
    start)
        echo -e "\e[32m Starting The RabbitMQ Services \e[0m"
        exit 0
        ;;
    stop)
        echo -e "\e[31m Stoping The RabbitMQ Services \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[33m Restarting The RabbitMQ Services \e[0m"
        exit 2
        ;;
    *)
        echo -e "\e[35m Possible Values are start or stop or restart \e[0m"
        exit 3
        ;;
esac