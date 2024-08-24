# System-Information

## Purpose: 

For this project, I am tasked with creating a user-friendly script that can be run from the terminal for a user to easily get important system information, such as public & private IP addresses, who the current user is, information on CPU and Memory, as well as the Top % Processes for both Memory and CPU, and information on network connectivity based on an URL or IP address.

## Initial Structure of Script:

I started this script by creating the structure. So first, I created echo messages for each menu option and assigned each a number. That corresponding number is what the user needs to input to access that menu option. 

**Menu:**

![image](https://github.com/user-attachments/assets/f9a1743a-35fd-4470-9d13-35001ca01e55)


Next, I created a while loop and within it used the `read -p` command to prompt the user for the numnber of their desired menu item → variable called "number". Then, I wrote 8 if/elif conditions to account for each menu option plus the option to exit the script. Additionally, I added an else clause at the end of the if statement to throw an error message if the user typed in anything other than 1-7 or 'x' to exit.

I didn't yet know how to achieve retrieving the information needed for each menu, so I started with the structure to keep me organized. 

**While loop + if/elif statements:**

![image](https://github.com/user-attachments/assets/a5077922-9b56-4ecc-955e-63c7705d2cdf)



Lastly, as seen in the above screenshot I included `return` at the end of all my if/elif sections. Similar to my adventure story script, I included the entire script in a function called "menu()". At the very end of my script, I created another while loop that calls the menu function and then nested another while loop within it where I ask the user if they want to choose from the menu again with `read -p`.

Afterwards, I use two if statements to check if the input is valid (either 'y' or 'n') and then echo an exiting message if the user types 'n'. If the user types in an invalid input, I included an else clause that would echo an error message and the nested while loop prompts the user to answer again. The `return` commands mentioned before will ensure that the script will run this while loop after showing the desired menu options to the user. 

**While Loop to have user pick from the menu again:**

![image](https://github.com/user-attachments/assets/a022da6f-1826-4d84-9420-c25d3ef88ae3)
