#!/bin/bash

# Gathering important system information for user

menu() {

# Presenting the user the menu
echo " "
echo "Hello. Please review the following menu:"
echo " "
echo "Public & Private IP Addresses - 1"
echo " "
echo "Who is the Current User? - 2"
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


# Presenting information based on user input
while true
do
        read -p "Please enter the corresponding number for the information you need or type 'x' to quit: " number

        if [ "$number" == 1 ] 
        then
                echo "Your private IP is _, and your public IP is _."
                return

        elif [ "$number" == 2 ]
        then
                user=$(whoami)
                echo " "
                echo "You are user: "$user"."
                echo " "
                return

        elif [ "$number" == 3 ]
        then
                
               # menu=$(top -bn1 | grep "%Cpu(s):")
                idle_CPU=$(top -bn1 | grep "%Cpu(s):" | awk -F ',' '{print $4}')
                echo  " "
                #echo "$menu"
                echo "The current idle CPU is: "$idle_CPU.""
                echo " "
                return
                
        elif [ "$number" == 4 ]
        then
                total_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $4}')
                free_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $6}')
                used_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $8}')
                buff_cache_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $10}')
                avail_mem=$(echo "$buff_cache_mem + $free_mem" | bc)
                
                echo " "
                echo "There is "$used_mem" Mebibyte used memory of total "$total_mem" Mebibyte."
                echo "There is an estimated amount of "$avail_mem" Mebibyte free."
                echo " "
                return
                
        elif [ "$number" == 5 ]
        then
                echo "Here is a table of the top 5 Memory Processes:"
                return
                
        elif [ "$number" == 6 ]
        then
                echo "Here is a table of the top 5 CPU Processes:"
                return
                
        elif [ "$number" == 7 ]
        then
                echo "Please provide a URL or IP address to connect to:"
                read url
                return
                
        elif [ "$number" == x ]
        then
                exit 1
                return

        else 
                echo " "
                echo "Input not valid." 
                echo " "     
                
        fi

done 

}

# Enabling user to pick from the menu again or choose to exit. 
while true
do

menu

    while true
    do  
        read -p "Would you like to choose another menu option? (y/n): " response
            
        if [[ "$response" == "y" || "$response" == "n" ]]
        then
            if [ "$response" == "n" ]
            then
                echo "Exiting menu."
                echo " "
                sleep 1
                exit 0
            fi
            break
        else
            echo "Input not valid. Please enter either 'y' to choose another menu option or 'n' to exit."
            echo " "
        fi
    done
done
