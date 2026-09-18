#!/usr/bin/env bash

# The line above is called a "shebang".
# It tells the operating system to run this script using Bash.
# "/usr/bin/env bash" searches for Bash in the user's PATH.


# -------------------------------------------------------------------
# BASH SAFETY OPTIONS
# -------------------------------------------------------------------

# -E enables inheritance of ERR traps in functions and subshells.
# -e stops the script when an important command fails.
# -u treats the use of an unset variable as an error.
# pipefail causes a pipeline to fail if any command in the pipeline fails.
set -Eeuo pipefail


# -------------------------------------------------------------------
# FOR-LOOP: LIST OF VALUES
# -------------------------------------------------------------------

printf '%s\n' '*************** For-Loops *******************'

# This for-loop processes one word at a time.
#
# The loop runs four times:
#   1. name=Parimal
#   2. name=Rohit
#   3. name=Hemant
#   4. name=Shashank
#
# "do" can be placed on the next line.
for name in Parimal Rohit Hemant Shashank
do
    # "$name" is quoted to prevent word splitting and pathname expansion.
    #
    # printf is generally preferred over echo because its behavior is
    # more consistent across different systems.
    printf 'Hello, %s\n' "$name"
done


# -------------------------------------------------------------------
# FOR-LOOP: COMPACT SYNTAX
# -------------------------------------------------------------------

# The semicolon separates the list from the "do" keyword when both
# appear on the same line.
for name in Karunya Ishant Sankalp Priyanshu; do
    printf 'Hello, %s\n' "$name"
done


# -------------------------------------------------------------------
# FOR-LOOP: BASH ARRAY
# -------------------------------------------------------------------

# An array stores multiple values under one variable name.
#
# Each value is a separate array element:
#   brands[0] = Apple
#   brands[1] = Samsung
#   brands[2] = OnePlus
#   brands[3] = Vivo
#   brands[4] = Lava
#
# Quoting each value is a good habit, especially if a value may contain
# spaces in the future.
brands=("Apple" "Samsung" "OnePlus" "Vivo" "Lava")

# "${brands[@]}" means:
#   Expand every element of the brands array separately.
#
# The braces are essential. They tell Bash that [@] belongs to the
# array expansion.
#
# The double quotes preserve each array element as one complete value.
# For example, "Parimal Kumar" would remain one item.
for brand in "${brands[@]}"; do
    printf 'Brand: %s\n' "$brand"
done


# -------------------------------------------------------------------
# CHANGING TO THE DOWNLOADS DIRECTORY
# -------------------------------------------------------------------

# Store the directory path in a variable.
# "$HOME" represents the current user's home directory.
downloads_directory="$HOME/Downloads"

# Change to the Downloads directory.
#
# "--" marks the end of command options. It prevents a path beginning
# with a hyphen from being interpreted as an option.
#
# If cd fails, display an error message and exit.
if ! cd -- "$downloads_directory"; then
    printf 'Error: unable to change directory to "%s".\n' \
        "$downloads_directory" >&2
    exit 1
fi

# "$PWD" contains the current working directory.
printf '\nProcessing entries in the current directory: %s\n' "$PWD"


# -------------------------------------------------------------------
# FOR-LOOP: PROCESSING FILES
# -------------------------------------------------------------------

# Do not use the following approach:
#
#     files=$(ls | sort)
#     for file in $files; do
#
# This is unsafe because it can break filenames containing:
#   - Spaces
#   - Tabs
#   - Wildcard characters
#   - Newline characters
#
# It is also bad practice to parse the output of "ls".

# nullglob causes a pattern such as "*" to expand to nothing when
# there are no matching entries.
shopt -s nullglob

# The "*" pattern expands to the visible entries in the current directory.
# Bash stores the results safely in an array.
#
# Bash normally expands pathname patterns in sorted order according to
# the current locale.
files=(*)

if ((${#files[@]} == 0)); then
    # ${#files[@]} gives the number of elements in the array.
    printf 'No visible entries found in "%s".\n' "$PWD"
else
    for file in "${files[@]}"; do
        printf 'Processing: %s\n' "$file"
    done
fi


# -------------------------------------------------------------------
# C-STYLE FOR-LOOP
# -------------------------------------------------------------------

printf '\n%s\n' '*************** C-Style For-Loop *******************'

# A C-style for-loop has three parts:
#
#   1. Initialization:  i=1
#   2. Condition:       i < 10
#   3. Increment:       i++
#
# This loop prints the numbers 1 through 9.
for ((i = 1; i < 10; i++)); do
    printf 'Number: %d\n' "$i"
done


# -------------------------------------------------------------------
# WHILE-LOOP: NUMERIC CONDITION
# -------------------------------------------------------------------

printf '\n%s\n' '*************** While-Loops *******************'

# Initialize the counter.
count=1

# The while-loop continues as long as the arithmetic condition is true.
#
# (( count <= 10 )) performs a numeric comparison.
# This loop prints the numbers 1 through 10.
while ((count <= 10)); do
    printf 'Counter: %d\n' "$count"

    # Increase count by one.
    ((count += 1))
done


# -------------------------------------------------------------------
# WHILE-LOOP: USING break
# -------------------------------------------------------------------

# Reset the counter.
counter=1

# "while true" creates a loop whose condition is always true.
# The loop must therefore contain a break statement.
while true; do

    # Stop the loop when counter reaches 10.
    if ((counter == 10)); then
        break
    fi

    printf 'Counter: %d\n' "$counter"
    ((counter += 1))
done


# -------------------------------------------------------------------
# UNTIL-LOOP
# -------------------------------------------------------------------

printf '\n%s\n' '*************** Until-Loops *******************'

# Reset the counter.
counter=1

# An until-loop continues while its condition is false.
# It stops when the condition becomes true.
#
# This loop prints the numbers 1 through 9:
#   counter=1  -> condition false, print
#   counter=2  -> condition false, print
#   ...
#   counter=9  -> condition false, print
#   counter=10 -> condition true, stop
until ((counter >= 10)); do
    printf 'Counter: %d\n' "$counter"
    ((counter += 1))
done


# -------------------------------------------------------------------
# COMPLETION MESSAGE
# -------------------------------------------------------------------

printf '\nLoop demonstrations completed successfully.\n'
