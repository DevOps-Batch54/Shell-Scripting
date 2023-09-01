#!/bin/bash
sample(){
    echo "I am messaged called from the function"4

}
stat(){
echo -e " \t total no.of sessions $(who | wc -l)"
echo " todays Date is $(date +%F)"
echo -e "\t stat function completed"
echo " Calling sample function"
# exit 2
return
sample
}
stat
echo -e "\t\t stat and sample functions are completed"