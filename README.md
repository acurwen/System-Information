# System Information Script in Bash

## Purpose: 

I created a user-friendly script that can be run from the terminal for a user to easily get important system information, such as public & private IP addresses, who the current user is, information on CPU and Memory, as well as the Top % Processes for both Memory and CPU, and information on network connectivity based on an URL or IP address.

## Initial Structure of Script:

I started this script by creating the structure. So first, I created echo messages for each menu option and assigned each a number. That corresponding number is what the user needs to input to access that menu option. 

**Menu:**

![image](https://github.com/user-attachments/assets/f9a1743a-35fd-4470-9d13-35001ca01e55)


Next, I created a while loop and within it used the `read -p` command to prompt the user for the numnber of their desired menu item → variable called "number". Then, I wrote 8 if/elif conditions to account for each menu option plus the option to exit the script. Additionally, I added an else clause at the end of the if statement to throw an error message if the user typed in anything other than 1-7 or 'x' to exit.

I didn't yet know how to achieve retrieving the information needed for each menu, so I started with the structure to keep me organized. 

**While loop + if/elif statements:**

![image](https://github.com/user-attachments/assets/a5077922-9b56-4ecc-955e-63c7705d2cdf)



Lastly, as seen in the above screenshot I included `return` at the end of all my if/elif sections. Similar to my adventure story script, I included the entire script in a function called "menu()". At the very end of my script, I created another while loop that calls the menu function and then nested another while loop within it where I ask the user if they want to choose from the menu again with `read -p`.

Afterwards, I use two if statements to check if the input is valid (either 'y' or 'n') and then echo an exiting message if the user types 'n'. If the user types in an invalid input, I included an else clause that would echo an error message and the nested while loop prompts the user to answer again. The `return` commands mentioned before will ensure that the script will run this while loop after a user is shown the ouput of their desired menu option. 

**While Loop to have user pick from the menu again:**

![image](https://github.com/user-attachments/assets/a022da6f-1826-4d84-9420-c25d3ef88ae3)

## 1. IP Addresses:

For the private IP, I found the command `hostname -I` and saved that to a variable to print. The -I flag is used to output all IP addresses related to the "host". 

For the public IP, I used the `curl` command to retrieve it from a site called 'ifconfig.me' that holds your IP address information and curl commands to use on the CLI. In this case: `curl ifconfig.me`. This command worked to return my public IP in the terminal, however, when I would test it in my script (after saving it to a variable and printing that variable), I'd get a table of information alongside my public IP.

![image](https://github.com/user-attachments/assets/a834808d-b932-4ebf-9cdf-d0604aa96af9)

Then, I found the -s flag which "mutes" `curl`, meaning any output of progress reports or errors would not be printed in the output - which is what I understood the progress table that was printing before to be. Rewriting the command with the -s flag only output the public IP and I tested again with saving it to a variable and it worked when I printed that variable. Then I used an echo statement to print out both the private and public IP in one statement for the user.

*I ended up putting private IP first in the sentence, because the default output of the private IP includes a space at the end of it. So in my echo message, I could easily format the output by not putting a space before the text that comes right after "$private_ip".

![image](https://github.com/user-attachments/assets/18a8a107-5eea-493c-a7cb-c895c9bce21b)


## 2. Current User:

To show the current user, I remembered that I could simply use the `whoami` command. I saved the `whoami` command to a new variable named "user" and wrote an echo statement to print out the user name:

```
user=$(whoami)
echo "You are user: "$user"."
```

## 3. CPU Information:

For CPU information, I decided to output the idle CPU amount to the user. I used the `top` command to get a list of my system's activity, then used `grep` to isolate the line starting with "%Cpu(s):" → `top -bn1 | grep "%Cpu(s):"`

I used the -b flag with `top` to run top in "batch mode" or a mode where I could record the output, and the -n flag with 1 so that top would only iterate once in order for me to capture a snapshot of the idle CPU. 

Then I used `awk` to print 'id' value of the idle CPU: `top -bn1 | grep "%Cpu(s):" | awk '{print $8}'`

However, when I tested this command out on the terminal, sometimes it would correctly output the idle CPU and other times it would output "id". I figured that depending on the changing values in the row, sometimes the "eigth" value in the row would either be the actual id amount or the word 'id'.

Script:

![image](https://github.com/user-attachments/assets/8d5537f6-d69c-4732-b0cf-cf0e6c2fd37d)

Output:

![image](https://github.com/user-attachments/assets/eeb4dc1d-9b3d-4077-81e9-f6fd046fc188)

Through testing, I saw that when idle CPU was 100, there was no space between the idle amount and the value before it. So the `awk` command would return 'id' as the eight value. However, I also noticed this happened when the idle amount was a 2-digit number as well.

Since I am only printing out the idle CPU amount for this section and not doing any math that requires me to isolate the idle CPU amount as an integer, I changed the `awk` statement to have a delineator of a comma instead of a space: `awk -F ',' '{print $4}'`

This worked to isolate the idle CPU, however, when printing both the idle CPU and the entire CPU row from `top` to crosscheck, the values for idle CPU didn't always match. I took this to mean that since I'm outputting a snapshot of top (since it usually shows ongoing activity) that the idle CPU value might change between the script running each line of code (one line to show the full row and the next line to only print the idle CPU). Or similarly, it could be that since I'm saving these "values" to variables, the variables are representing the snapshot of the information at the time the script is called. And because I use -b and -n as flags to capture a snapshot of the processes instead of a "real-time" output.


![image](https://github.com/user-attachments/assets/96f69385-dccf-4106-b582-944abd35ea3d)


## 4. Memory Information:

For memory, I used the `top` command to get a list of system activity, then used `grep` to isolate the line starting with "MiB Mem :" → `top -bn1 | grep "MiB Mem : "`

Then I used `awk` to print four values within the memory row: total mem, used mem, free mem and the buff/cache amount of mem. 

Using `echo`, I provided the amount of used memory out of total memory to the user as well as an estimated amount of the available free memory. 

To calculate an estimate of the available memory, I learned that free mem + buff/cache mem is an estimation of the total free memory because the buff/cache memory is able to be released quickly if its needed to be used by something else. 

So I added the free mem and buff/cache mem amounts together from the `top` output, saved that total to a variable and used that in another echo statement. I also funnelled that addition echo section into a command called `bc` because 'bc' allows calculations with floating point numbers and all the mem amounts from `top` are floating point numbers ( from bash calculator, I learned that bash defaults to arithmetic with integers only.)

![image](https://github.com/user-attachments/assets/3b93e58d-38e7-42db-9d47-7a1b84387f84)

## Top 5 Memory Processes:

To output the top 5 memory processes in chart form, I used the `ps` command to get an output of processes. 

With `ps`, I used the -e flag to list all processes and the -o flag to specify which column headers I wanted to include in the output chart: process id, command and the memory percentage: `pid,comm,%mem`

Then I used `--sort=-%mem` to sort the memory percentage column by greatest to lowest. (The '--' is used to separate the `sort` command from the previous part of the command where I specify which columns I want to output.)

Full line:  `ps -eo pid,comm,%mem --sort=-%mem`

To get the first 5 lines to print, I funneled ( | ) the above command with  `head -n 6`.

`ps -eo pid,comm,%mem --sort=-%mem | head -n 6`

In my script, I echo out this line after an echo message that says, "Here are the top 5 processes for Memory:"

![image](https://github.com/user-attachments/assets/11b3023e-16e6-4bc2-9860-812c1ace32de)

## Top 5 CPU Processes:

To output the top 5 CPU processes in a chart, I repeated the command used for my top 5 memory processes section and just replaced '%mem' with '%cpu'.

`ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6`

## Network Connectivity:

To show information on a network connection, I found the following command that specifically returned back the time it took to connect to a webpage in seconds: `curl -o /dev/null -s -w "%{time_connect}\n" (urlhere)`

- The -o flag is used to save the output of `curl` to a file (/dev/null) instead of printing it in the script's output.

- Like in the command I used to get the public IP address, the -s flag mutes any output of progress reports or errors from `curl`.

- The 'w' flag prints out the value of the "time_connect" variable specifically. Without either the -o or -w flags, the curl command printed out what looked like background site information of the site provided. 

I saved this whole command to a variable called 'time': ` time=$(curl -o /dev/null -s -w "%{time_connect}\n" url)`

Before adding in read, I tested this command with 'https://www.google.com/' as the url and got consistent results in seconds back. 
Then I used the `read -p` command to read the URL or IP address from the user, saved it to a variable called url and then used it in the above function. 

Tested out google.com again, a page from Canvas and my IP address for my VSCode EC2 to verify this part of the menu worked. 

![image](https://github.com/user-attachments/assets/2420688a-537f-4783-987f-ca124892b526)


## Conclusion

To finish off, I ran through the script on both my VSCode Instance and Student Instance to test usability and make stylistic chnages to the echo messages. This was a good project to reinforce practice on while loops and if statements and test out newer commands like curl further. 


