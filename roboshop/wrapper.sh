#!/bin/bash

echo $0   #o/p: wrapper.sh
bash components/$1.sh 
bash components/$2.sh
bash components/$3.sh 

#bash wrapper.sh catalogue mongodb frontend
#o/p: 
#wrapper.sh
#I am catalogue
#I am mongodb
#I am frontend