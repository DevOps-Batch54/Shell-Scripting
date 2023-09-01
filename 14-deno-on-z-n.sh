#!/bin/bash

a=10

if [ -n "$a" ] ; then
    echo "Value of a is declared"
else
    echo "Value of a is not declared"
fi

if [ -z "$b" ] ; then
    echo "Value of b is declared"
else
    echo "Value of b is not declared"
fi