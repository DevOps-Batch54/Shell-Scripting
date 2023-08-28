#!/bin/bash
# Each and every color you see on terminal will have a color code and we need to use that code based on our need.
# Color	Foreground Code	Background Code
# Black	30	40
# Red	31	41
# Green	32	42
# Yellow	33	43
# Blue	34	44
# Magenta	35	45
# Cyan	36	46
# Light Gray	37	47
# Gray	90	100
# Light Red	91	101
# Light Green	92	102
# Light Yellow	93	103
# Light Blue	94	104
# Light Magenta	95	105
# Light Cyan	96	106
# White	97	107
#Syntax:
# echo "\e[COL-CODEm Your Message To Be Printed \e[0m"
# Eg: echo -e "\e[32mRed text\e[0m"

echo -e "\e[32m Iam printing Green Color \e[0m"
echo -e "\e[31m Iam printing Red Color \e[0m"
echo -e "\e[33m Iam printing Yellow Color \e[0m"
echo -e "\e[34m Iam printing Blue Color \e[0m"
echo -e "\e[35m Iam printing Magenta Color \e[0m"