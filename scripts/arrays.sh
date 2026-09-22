#!/usr/bin/env bash

# Use Bash, not /bin/sh.
# The script uses Bash arrays and Bash-specific syntax.

set -Eeuo pipefail

# -------------------------------------------------------------------
# CREATING AN INDEXED ARRAY
# -------------------------------------------------------------------

# Indexed arrays use numeric indexes beginning at 0:
#
#   names[0] = Parimal
#   names[1] = Hemant
#   names[2] = Rohit
#
names=("Parimal" "Hemant" "Rohit")

# ${#names[@]} gives the number of assigned elements in the array.
# For this array, the size is 3.
printf 'Array created with %s elements\n' "${#names[@]}"

# "${names[*]}" expands all values as one string.
# The values are joined using the first character of IFS,
# which is normally a space.
printf 'Array values: %s\n' "${names[*]}"


# -------------------------------------------------------------------
# LOOPING THROUGH AN ARRAY USING NUMERIC INDEXES
# -------------------------------------------------------------------

# This style works well for a dense array:
#
#   index 0
#   index 1
#   index 2
#
# Inside (( ... )), variables do not need a $.
for ((i = 0; i < ${#names[@]}; i++)); do
    # "${names[i]}" retrieves the element at index i.
    #
    # The quotes preserve the complete value if it contains spaces.
    printf 'Index: %d, Name: %s\n' "$i" "${names[i]}"
done


# -------------------------------------------------------------------
# LOOPING THROUGH THE ACTUAL ARRAY INDEXES
# -------------------------------------------------------------------

# "${!names[@]}" expands to the indexes that currently exist.
#
# This is safer than a numeric loop when an array might be sparse,
# meaning that some indexes are missing.
for index in "${!names[@]}"; do
    printf 'Index %s contains %s\n' "$index" "${names[index]}"
done


printf '\n'


# -------------------------------------------------------------------
# MODIFYING AN EXISTING ARRAY ELEMENT
# -------------------------------------------------------------------

printf 'Before changing index 0: %s\n' "${names[*]}"

# Replace the value at index 0.
names[0]='Omkar'

printf 'After changing index 0:  %s\n' "${names[*]}"


printf '\n'


# -------------------------------------------------------------------
# ADDING ONE ELEMENT
# -------------------------------------------------------------------

printf 'Before adding one element: %s\n' "${names[*]}"

# += appends a new element to the end of the array.
names+=('Karunya')

printf 'After adding one element:  %s\n' "${names[*]}"


printf '\n'


# -------------------------------------------------------------------
# ADDING MULTIPLE ELEMENTS
# -------------------------------------------------------------------

printf 'Before adding two elements: %s\n' "${names[*]}"

# Append two more elements.
names+=('Shashank' 'Rohit')

printf 'After adding two elements:  %s\n' "${names[*]}"


printf '\n'


# -------------------------------------------------------------------
# REMOVING AN ARRAY ELEMENT
# -------------------------------------------------------------------

# At this point, index 3 contains Karunya.
printf 'Before removing index 3 (%s): %s\n' \
    "${names[3]}" \
    "${names[*]}"

# unset removes the element but does not automatically renumber
# the elements after it.
#
# Quoting the subscript is a good habit.
unset 'names[3]'

printf 'After removing index 3:       %s\n' "${names[*]}"


printf '\n'


# -------------------------------------------------------------------
# CLEARING THE ENTIRE ARRAY
# -------------------------------------------------------------------

# This removes the entire names array.
unset names

# Do not use ${names[@]} after this when "set -u" is enabled,
# because the variable no longer exists.


# -------------------------------------------------------------------
# SPARSE ARRAYS
# -------------------------------------------------------------------

printf 'Sparse array demonstration\n'

numbers=()

# These indexes are intentionally not consecutive.
numbers[0]=12
numbers[4]=23
numbers[8]=90
numbers[34]=54

# The array contains four assigned elements, even though the
# highest index is 34.
printf 'Number of assigned elements: %s\n' "${#numbers[@]}"
printf 'Number values: %s\n' "${numbers[*]}"

# Always quote "${!numbers[@]}".
# It expands only to indexes that actually exist:
#
#   0
#   4
#   8
#   34
#
for index in "${!numbers[@]}"; do
    printf 'Index %s contains %s\n' \
        "$index" \
        "${numbers[index]}"
done


printf '\n'


# -------------------------------------------------------------------
# ARRAY SLICING
# -------------------------------------------------------------------

letters=(a b c d e f g h)

# ${letters[@]:1:5} means:
#
#   start at index 1
#   select 5 elements
#
# That gives: b c d e f
#
# The following loop displays each selected element clearly.
printf 'Five characters starting at index 1:'

for letter in "${letters[@]:1:5}"; do
    printf ' %s' "$letter"
done

printf '\n'


printf '\n'


# -------------------------------------------------------------------
# READING USER INPUT INTO AN ARRAY
# -------------------------------------------------------------------

# -r prevents backslashes from being treated as escape characters.
# -p displays the prompt.
# -a stores the space-separated input words in an indexed array.
#
# Example input:
#
#   10 20 30 40
#
read -r -p 'Enter numbers separated by spaces: ' -a input_numbers

printf 'Values entered: %s\n' "${input_numbers[*]}"

# Loop through the indexes that actually exist.
for index in "${!input_numbers[@]}"; do
    printf 'Index %s contains %s\n' \
        "$index" \
        "${input_numbers[index]}"
done
