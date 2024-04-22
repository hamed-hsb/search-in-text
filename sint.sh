#!/bin/bash

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
