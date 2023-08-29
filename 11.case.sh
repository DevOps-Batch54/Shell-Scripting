#!/bin/bash
# Syntax for CASE
# case $var in
#         opt1) command1 ;;
#         opt2) command2 ;;
# esac

ACTION=$1
case $ACTION in
    start)
        echo "Starting The RabbitMQ Services"
        ;;
    stop)
        echo "Stoping The RabbitMQ Services"
        ;;
    restart)
        echo "Restarting The RabbitMQ Services"
        ;;
    *)
        echo "Possible Values are start or stop or restart"
        ;;
esac