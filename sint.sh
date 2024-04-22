#!/bin/bash

LINE_INDEX=0
is_invert_match=0


# Default logical operator
logical_operator="-v"

# Parse command-line options
while getopts ":v" opt; do
    case $opt in
        v)
            logical_operator="-v"
            is_invert_match=1;;
            
        m)
            logical_operator="-o"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

# Check if three parameters are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory_path> <param1> <param2>"
    exit 1
fi


# Assign parameters to variables
directory_path=$1
param1=$2
param2=$3

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory '$directory_path' does not exist."
    exit 1
fi


# Iterate over each text file in the directory
for file in "$1"/*.*; do
    echo "Reading file: $file"
    # Read each line of the file
    while IFS= read -r line; do
        # Extract the value of the "app_token" field using grep and awk
        if [ "$is_invert_match" -eq 1 ]; then
        	line_log=$(echo "$line" | grep  "$param1" | grep -v '\bgps_adid\b')
        else
        	line_log=$(echo "$line" | grep  "$param1")
        fi
        
        # Check if app_token is not empty
	if [ -n "$line_log" ]; then
	((LINE_INDEX++))
	# Output the value of the "app_token" field
        echo "line $LINE_INDEX : $line_log"
	fi
	
    done < "$file"
done



