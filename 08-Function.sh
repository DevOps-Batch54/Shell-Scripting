#!/bin/bash
Sample(){
    echo "I am a sample function with sample"
    echo "I am executing sample function"
    echo -e "\e[35m Sample function completed \e[0m"
    echo "Calling Status function"
    Status
}

Status(){
    echo "Good Morning and todays date is $(date +%D)"
    echo -e "Good Morning and Todays Date is \e[34m $(date +%F) \e[0m"
    echo -e "No Of Open Sessions \e[35m $(who -q) \e[0m"
    echo -e "No Of Open Sessions \e[35m $(who | wc -l) \e[0m"
    echo "Load Average On The System From Last 1 min is \e[38m $(uptime | awk -F , '{print $3}' | awk -F : '{print$2}') \e[0m"
}
#This is how you can call a function
Sample 
#Calling status function
