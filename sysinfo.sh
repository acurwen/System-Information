#!/bin/bash

# Gathering important system information for user

menu() {

# Presenting the user the menu
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
                echo "You are user _."
                return

        elif [ "$number" == 3 ]
        then
                 echo "The system has _ CPU."
                return
                
        elif [ "$number" == 4 ]
        then
                echo "There is _ Mebibyte unused memory of total _ Mebibyte."
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
