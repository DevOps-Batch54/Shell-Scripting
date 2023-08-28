#!/bin/bash
TODAYS_DATE="03JUNE2023"
TODAY_DATE=$(date +%F)
No_Of_Sessions=$(who | wc-l)
echo "Good Morning and todays date is $TODAYS_DATE"
echo -e "Good Morning and Todays Date is \e[34m $TODAY_DATE \e[0m"
echo -e "No Of Open Sessions $No_Of_Sessions
