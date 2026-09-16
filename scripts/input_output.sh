#!/usr/bin/env bash

# The line above is called a "shebang".
# It tells the operating system to run this script using Bash.
# "/usr/bin/env bash" searches for Bash in the user's PATH.


# -------------------------------------------------------------------
# SYSTEM INFORMATION
# -------------------------------------------------------------------

# Run the "hostname" command and store its output in a variable.
#
# Command substitution uses the syntax:
#     $(command)
#
# The command inside "$(...)" is executed, and its output is stored
# in the variable named "hostname_value".
hostname_value="$(hostname)"

# Store the current username in the variable "current_user".
#
# ${USER:-unknown} means:
# - Use the value of USER if it exists and is not empty.
# - Otherwise, use the value "unknown".
#
# The USER variable is commonly provided by the operating system.
current_user="${USER:-unknown}"


# Display the hostname.
#
# printf is used to print formatted text.
# %s is a placeholder for a string.
# "$hostname_value" supplies the value that replaces %s.
#
# \n creates a new line.
printf 'My hostname is %s\n' "$hostname_value"

# Display the current username.
printf 'Current user is %s\n' "$current_user"


# -------------------------------------------------------------------
# GREETING
# -------------------------------------------------------------------

# Print a greeting message.
#
# \n\n adds two new lines after the message, creating a blank line.
printf 'Hello, my name is Parimal!\n\n'


# -------------------------------------------------------------------
# ASKING FOR THE USER'S NAME
# -------------------------------------------------------------------

# Ask the user to enter their name.
#
# read waits for input from the keyboard.
# -p displays the text shown inside the quotes as a prompt.
# name is the variable where the user's input is stored.
#
# Because -r was removed, backslashes entered by the user may be
# interpreted by the read command.
read -p "What is your name? " name

# Display a welcome message using the name entered by the user.
#
# The variable is written as "$name".
# Double quotes preserve spaces and prevent the input from being
# split into multiple words.
printf 'Welcome, %s!\n\n' "$name"


# -------------------------------------------------------------------
# COLLECTING FORM INFORMATION
# -------------------------------------------------------------------

# Tell the user that the form is beginning.
printf "Let's fill out a form.\n\n"

# Ask for the user's first name.
# The answer is stored in the variable "first_name".
read -p "First Name: " first_name

# Ask for the user's last name.
# The answer is stored in the variable "last_name".
read -p "Last Name: " last_name

# Ask for the user's age.
# The answer is stored in the variable "age".
#
# At this stage, Bash stores the input as text.
# Bash variables do not automatically have a numeric data type.
read -p "Age: " age

# Ask for the user's gender.
# The answer is stored in the variable "gender".
read -p "Gender (M|F): " gender

# Ask for the user's mobile number.
# The answer is stored in the variable "mobile_number".
#
# Mobile numbers are normally treated as text rather than numbers,
# because they may contain a leading zero, spaces, or a plus sign.
read -p "Mobile Number: " mobile_number

# Ask for the user's email address.
# The answer is stored in the variable "email".
read -p "Email Address: " email


# -------------------------------------------------------------------
# DISPLAYING THE FORM INFORMATION
# -------------------------------------------------------------------

# Print a blank line followed by a heading.
#
# A single-quoted string is used here. The \n is still interpreted
# by printf as a newline character.
printf '\nYour details are as follows:\n'

# Display the user's first and last names.
#
# There are two %s placeholders, so two values are provided:
# "$first_name" and "$last_name".
printf 'Full Name: %s %s\n' "$first_name" "$last_name"

# Display the user's age.
printf 'Age: %s\n' "$age"

# Display the user's gender.
printf 'Gender: %s\n' "$gender"

# Display the user's mobile number.
printf 'Contact: %s\n' "$mobile_number"

# Display the user's email address.
printf 'Email: %s\n' "$email"
