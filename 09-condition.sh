#!/bin/bash 

NUMBER=$1

if [ $NUMBER -gt 10 ]
then 
    echo "Given number $NUMBER is grater then 10" 
else 
    echo "Given number $NUMBER is less then 10"
fi 
