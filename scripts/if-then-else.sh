#!/usr/bin/env bash

# The line above is called a "shebang".
# It tells the operating system to run this script using Bash.
# "/usr/bin/env bash" searches for Bash in the user's PATH.


# -------------------------------------------------------------------
# SYSTEM INFORMATION
# -------------------------------------------------------------------

# The hostname command displays the computer's hostname.
# Command substitution stores the command's output in a variable.
hostname_value="$(hostname)"

# ${USER:-unknown} means:
# - Use the value of USER if it exists and is not empty.
# - Otherwise, use the value "unknown".
current_user="${USER:-unknown}"

# Display system information.
printf 'Current user: %s\n' "$current_user"
printf 'Computer name: %s\n\n' "$hostname_value"


# -------------------------------------------------------------------
# INTRODUCTION
# -------------------------------------------------------------------

printf 'This script checks paths, directories, files, and permissions.\n'
printf 'The permission tests are: readable, writable, and executable.\n\n'


# -------------------------------------------------------------------
# ASKING FOR THE MAIN PATH
# -------------------------------------------------------------------

# Ask the user to enter a path.
#
# read waits for keyboard input.
# -r prevents backslashes from being treated as escape characters.
# -p displays a prompt.
# path stores the user's answer.
read -r -p "Enter the path to check: " path

# -e checks whether the path exists.
# -d checks whether the path exists and is a directory.
#
# The first condition checks whether the path is a directory.
if [[ -d "$path" ]]; then
    printf "The path '%s' exists and is a directory.\n" "$path"

# This elif condition runs only when the first if condition is false.
#
# If the path exists but is not a directory, it may be a regular file,
# symbolic link, or another type of filesystem object.
elif [[ -e "$path" ]]; then
    printf "The path '%s' exists, but it is not a directory.\n" "$path"
    printf "A directory is required for the next step.\n"
    exit 1

# The else section runs when none of the previous conditions are true.
else
    printf "The path '%s' does not exist.\n" "$path"
    exit 1
fi


# -------------------------------------------------------------------
# ASKING FOR A DIRECTORY
# -------------------------------------------------------------------

# Ask for the name of a directory inside the main path.
#
# For example, if path is:
#     /home/alice
#
# and the user enters:
#     Documents
#
# directory_path becomes:
#     /home/alice/Documents
read -r -p "Enter the directory name inside '$path': " dir

directory_path="$path/$dir"

# Check whether the requested directory exists.
if [[ -d "$directory_path" ]]; then
    printf "Directory '%s' exists.\n" "$directory_path"

# This elif demonstrates another possible situation:
# the path exists, but it is not a directory.
elif [[ -e "$directory_path" ]]; then
    printf "'%s' exists, but it is not a directory.\n" "$directory_path"
    exit 1

# This else runs when the directory does not exist at all.
else
    printf "Directory '%s' does not exist.\n" "$directory_path"
    exit 1
fi


# -------------------------------------------------------------------
# ASKING FOR A FILE
# -------------------------------------------------------------------

# Ask for the name of a file inside the selected directory.
read -r -p "Enter the filename inside '$directory_path': " file

# Construct the complete file path.
file_path="$directory_path/$file"

# -f checks whether the path is an existing regular file.
if [[ -f "$file_path" ]]; then
    printf "File '%s' exists.\n" "$file_path"

# This elif runs if something exists at that path but it is not
# a regular file. It could be a directory, symbolic link, or device.
elif [[ -e "$file_path" ]]; then
    printf "'%s' exists, but it is not a regular file.\n" "$file_path"
    exit 1

# This else runs if no filesystem object exists at that path.
else
    printf "File '%s' does not exist.\n" "$file_path"
    exit 1
fi


# -------------------------------------------------------------------
# FILE SIZE CHECK
# -------------------------------------------------------------------

# -s checks whether the file exists and has a size greater than zero.
if [[ -s "$file_path" ]]; then
    printf "The file is not empty.\n"
else
    printf "The file is empty.\n"
fi


# -------------------------------------------------------------------
# INDIVIDUAL PERMISSION CHECKS
# -------------------------------------------------------------------

# -r checks whether the file is readable by the current user.
if [[ -r "$file_path" ]]; then
    printf "Readable: yes\n"
else
    printf "Readable: no\n"
fi

# -w checks whether the file is writable by the current user.
if [[ -w "$file_path" ]]; then
    printf "Writable: yes\n"
else
    printf "Writable: no\n"
fi

# -x checks whether the file is executable by the current user.
if [[ -x "$file_path" ]]; then
    printf "Executable: yes\n"
else
    printf "Executable: no\n"
fi


# -------------------------------------------------------------------
# COMBINED PERMISSION CHECK USING IF, ELIF, AND ELSE
# -------------------------------------------------------------------

# This section demonstrates how multiple conditions can be combined.
#
# && means AND.
# Therefore, all three permissions must be present for the first
# condition to be true.
if [[ -r "$file_path" && -w "$file_path" && -x "$file_path" ]]; then
    printf "Permission status: readable, writable, and executable.\n"

# This elif checks whether the file is readable and writable, but
# not executable.
elif [[ -r "$file_path" && -w "$file_path" ]]; then
    printf "Permission status: readable and writable, but not executable.\n"

# This elif checks whether the file is readable and executable,
# but not writable.
elif [[ -r "$file_path" && -x "$file_path" ]]; then
    printf "Permission status: readable and executable, but not writable.\n"

# This elif checks whether the file is writable and executable,
# but not readable.
elif [[ -w "$file_path" && -x "$file_path" ]]; then
    printf "Permission status: writable and executable, but not readable.\n"

# This elif checks whether the file is readable only.
elif [[ -r "$file_path" ]]; then
    printf "Permission status: readable only.\n"

# This elif checks whether the file is writable only.
elif [[ -w "$file_path" ]]; then
    printf "Permission status: writable only.\n"

# This elif checks whether the file is executable only.
elif [[ -x "$file_path" ]]; then
    printf "Permission status: executable only.\n"

# The else section runs when none of the permissions are available.
else
    printf "Permission status: not readable, writable, or executable.\n"
fi


# -------------------------------------------------------------------
# FINAL MESSAGE
# -------------------------------------------------------------------

printf '\nAll checks completed successfully.\n'
