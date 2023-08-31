#!/bin/bash
echo "This is to demonstrate the usage of single line and multi line comments"
<<comment
a=10
echo $a
echo "In this infinite world, we are just star dust"
comment
echo "This is to demonstrate multi line comments"