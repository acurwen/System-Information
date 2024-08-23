#!/bin/bash

#Gathering important system information for user

echo "Hello. Please review the following menu:"
echo " "
echo "Public & Private IP Addresses - 1"
echo " "
echo "Who the Current User is - 2"
echo " "
echo "CPU Information - 3"
echo " "
echo "Memory Information - 4"
echo " "
echo "Top 5 Memory Processes - 5"
echo " "
echo "Top 5 CPU Processes - 6"
echo " "
echo "Network Connectivity - 7"
echo " "
echo "Please enter the corresponding number for the information you need. Please type 'x' to quit:"
echo " "

while true
do
        read number

        if [ "$number" == 1 ] 
        then
                echo "Your private IP is _, and your public IP is _."

        elif [ "$number" == 2 ]
        then
                echo "You are user _."

        elif [ "$number" == 3 ]
        then
                 echo "The system has _ CPU."

        elif [ "$number" == 4 ]
        then
                echo "There is _ Mebibyte unused memory of total _ Mebibyte."
                
        elif [ "$number" == 5 ]
        then
                echo "Here is a table of the top 5 Memory Processes:"

        elif [ "$number" == 6 ]
        then
                echo "Here is a table of the top 5 CPU Processes:"

        elif [ "$number" == 7 ]
        then
                echo "Please provide a URL or IP address to connect to:"
                read url

        elif [ "$number" == x ]
        then
                exit 1

        fi

done 
