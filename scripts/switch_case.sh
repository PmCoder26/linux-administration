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
# CASE STATEMENT: NUMBER SELECTION
# -------------------------------------------------------------------

printf '%s\n' '*************** Number Selection *******************'

# Ask the user to enter a number.
#
# -r prevents backslashes from being interpreted as escape characters.
# -p displays the prompt.
read -r -p "Enter a number from 1 to 3: " number_choice

# A case statement compares one value against several patterns.
#
# General structure:
#
# case "$value" in
#     pattern1)
#         commands
#         ;;
#     pattern2)
#         commands
#         ;;
#     *)
#         default_commands
#         ;;
# esac
#
# The ;; marks the end of each case branch.
# The * pattern matches anything that did not match earlier patterns.

case "$number_choice" in
    1)
        printf 'You selected 1.\n'
        ;;

    2)
        printf 'You selected 2.\n'
        ;;

    3)
        printf 'You selected 3.\n'
        ;;

    *)
        # This branch handles invalid input such as:
        #   0
        #   4
        #   abc
        #   empty input
        printf 'Invalid selection.\n'
        ;;
esac


# -------------------------------------------------------------------
# CASE STATEMENT: CONTINUE OR STOP
# -------------------------------------------------------------------

printf '\n%s\n' '*************** Continue Prompt *******************'

# Continue asking until the user enters a valid answer.
while true; do
    read -r -p "Do you want to continue the script? (y/n): " continue_choice

    # Convert the user's input to lowercase.
    #
    # Examples:
    #   Y     becomes y
    #   Yes   becomes yes
    #   YES   becomes yes
    #
    # The ${variable,,} syntax is Bash-specific.
    continue_choice="${continue_choice,,}"

    case "$continue_choice" in
        y|yes)
            printf 'We are continuing the script.\n'

            # break exits the current while-loop.
            break
            ;;

        n|no)
            printf 'We stopped here.\n'

            # exit 0 ends the script successfully.
            exit 0
            ;;

        *)
            printf 'Invalid option. Please enter y or n.\n'
            ;;
    esac
done


# -------------------------------------------------------------------
# CASE STATEMENT: FILE EXTENSION
# -------------------------------------------------------------------

printf '\n%s\n' '*************** File Type Detection *******************'

read -r -p "Enter a file name: " filename

# Convert the filename to lowercase.
#
# This allows the script to treat these names the same way:
#   photo.jpg
#   photo.JPG
#   photo.JpG
lowercase_filename="${filename,,}"

# File-extension patterns use shell wildcards.
#
# Examples:
#   *.txt       Any filename ending in .txt
#   *.jpg|*.png A filename ending in .jpg or .png
#   *           Anything else
case "$lowercase_filename" in
    *.txt)
        printf 'This is a text file.\n'
        ;;

    *.sh|*.bash)
        printf 'This is a shell script file.\n'
        ;;

    *.jpg|*.jpeg|*.png)
        printf 'This is an image file.\n'
        ;;

    *.pdf)
        printf 'This is a PDF file.\n'
        ;;

    "")
        # This branch handles empty input.
        printf 'You did not enter a file name.\n'
        ;;

    *)
        printf 'Unknown file type.\n'
        ;;
esac


# -------------------------------------------------------------------
# CASE STATEMENT: TEXT CLASSIFICATION
# -------------------------------------------------------------------

printf '\n%s\n' '*************** Text Classification *******************'

# Continue checking text until the user chooses to stop.
while true; do

    read -r -p "Let's check what you enter: " text

    # The case statement tests the complete value of "$text".
    case "$text" in

        # [0-9] matches exactly one digit:
        #   0, 1, 2, 3, 4, 5, 6, 7, 8, or 9
        #
        # It does not match numbers such as 10 or 25.
        [0-9])
            printf 'You entered a single digit from 0 to 9.\n'
            ;;

        # [1-9][0-9] matches two-digit numbers from 10 to 99.
        #
        # The first digit cannot be zero, so values such as 05
        # are not matched by this pattern.
        [1-9][0-9])
            printf 'You entered a two-digit number.\n'
            ;;

        # [a-z] matches exactly one lowercase English letter.
        [a-z])
            printf 'You entered a single lowercase character.\n'
            ;;

        # [A-Z] matches exactly one uppercase English letter.
        [A-Z])
            printf 'You entered a single uppercase character.\n'
            ;;

        # [a-z]* means:
        #   1. The first character must be lowercase.
        #   2. Zero or more characters may follow.
        #
        # This pattern matches:
        #   hello
        #   hello world
        #   apple123
        #   a
        #
        # Because [a-z] appears above this pattern, a single lowercase
        # letter is classified by the earlier branch.
        [a-z]*)
            printf 'You entered text beginning with a lowercase letter.\n'
            ;;

        # [A-Z]* means:
        #   1. The first character must be uppercase.
        #   2. Zero or more characters may follow.
        #
        # This pattern matches:
        #   Hello
        #   Hello world
        #   Apple123
        #   A
        [A-Z]*)
            printf 'You entered text beginning with an uppercase letter.\n'
            ;;

        # The * pattern matches anything not matched above.
        #
        # This includes:
        #   empty input
        #   punctuation
        #   symbols
        #   text beginning with a number
        #   text beginning with a space
        *)
            printf 'Unknown text.\n'
            ;;
    esac


    # ---------------------------------------------------------------
    # ASK WHETHER TO CHECK MORE TEXT
    # ---------------------------------------------------------------

    read -r -p "Do you want to enter more text? (y/n): " text_choice

    # Convert the response to lowercase so that:
    #   Y, y, YES, Yes, yes
    # can be handled consistently.
    text_choice="${text_choice,,}"

    case "$text_choice" in
        y|yes)
            # continue starts the next iteration of the while-loop.
            continue
            ;;

        n|no)
            printf 'Text checking complete.\n'

            # break exits the while-loop.
            break
            ;;

        *)
            # Invalid input does not exit the script.
            # The loop asks the user again.
            printf 'Invalid option. Please enter y or n.\n'
            ;;
    esac
done


# -------------------------------------------------------------------
# COMPLETION MESSAGE
# -------------------------------------------------------------------

printf '\nCase statement demonstrations completed successfully.\n'

# exit 0 indicates successful completion.
exit 0
