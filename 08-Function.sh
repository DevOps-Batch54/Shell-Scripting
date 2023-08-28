#!/bin/bash
Sample(){
    echo "I am a sample function with sample"
    echo "I am executing sample function"
    echo -e "\e[35m Sample function completed \e[0m"
}

Status(){
    echo "Good Morning and todays date is $(date +%D)"
    echo -e "Good Morning and Todays Date is \e[34m $(date +%F) \e[0m"
    echo "No Of Open Sessions $No_Of_Sessions" \e[0m"
}
#This is how you can call a function
Sample 
#Calling status function
Status