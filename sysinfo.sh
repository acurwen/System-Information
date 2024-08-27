#!/bin/bash

# Gathering important system information for user

menu() {

# Presenting the user the menu
echo " "
echo "Hello. Please review the following menu:"
echo " "
echo "1. Private & Public IP Addresses"
echo " "
echo "2. Who is the Current User?"
echo " "
echo "3. CPU Information"
echo " "
echo "4. Memory Information"
echo " "
echo "5. Top 5 Memory Processes"
echo " "
echo "6. Top 5 CPU Processes"
echo " "
echo "7. Network Connectivity"
echo " "


# Presenting information based on user input
while true
do
        read -p "Please enter the corresponding number for the information you need or type 'x' to quit: " number

        # Private & Public IP Addresses
        if [ "$number" == 1 ] 
        then
                privateip=$(hostname -I)
                publicip=$(curl -s ifconfig.me)
                echo " "
                echo "Your private IP is "$privateip"and your public IP is "$publicip"." 
                echo " "
                return
                

        # Current User
        elif [ "$number" == 2 ]
        then
                user=$(whoami)
                echo " "
                echo "You are user '"$user"'."
                echo " "
                return

        # CPU Information
        elif [ "$number" == 3 ]
        then
                idle_CPU=$(top -bn1 | grep "%Cpu(s):" | awk -F ',' '{print $4}')
                echo " "
                echo "The current idle CPU is: "$idle_CPU.""
                echo " "
                return

        # Memory Information      
        elif [ "$number" == 4 ]
        then
                total_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $4}')
                free_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $6}')
                used_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $8}')
                buff_cache_mem=$(top -bn1 | grep "MiB Mem : " | awk '{print $10}')

                avail_mem=$(echo "$buff_cache_mem + $free_mem" | bc)
                
                echo " "
                echo "There are "$used_mem" Mebibytes of used memory out of a total of "$total_mem" Mebibytes."
                echo "There is an estimated amount of "$avail_mem" Mebibytes free."
                echo " "
                return

        # Top 5 Memory Processes        
        elif [ "$number" == 5 ]
        then
                echo " "
                echo "Here are the top 5 Memory Processes:"
                echo "$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)"
                echo " "
                return

        # Top 5 CPU Processes       
        elif [ "$number" == 6 ]
        then
                echo " "
                echo "Here are the top 5 CPU Processes:"  
                echo "$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)"
                echo " "
                return

        # Network Connectivity Information
        elif [ "$number" == 7 ]
        then
                echo " "
                read -p "Please enter a URL or IP address to connect to: " url
                time=$(curl -o /dev/null -s -w "%{time_connect}\n" "$url")
                echo "It took $time seconds to connect to "$url"."
                echo " "
                return

        # Exit Menu        
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
