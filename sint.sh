#!/bin/bash

LINE_INDEX=0

file_list=""

is_invert_match_option=0
is_match_option=0
is_repeat_option=0

is_last_file_option=0
is_first_file_option=0
is_all_files_option=1

is_save_result_log_option=0


# Default logical operator
logical_operator="-v"

# Initialize variables
arg1=""
arg2=""
arg3=""
arg4=""
arg5=""


# Parse command line options
# Parse directory options
# -a -> All files in directory
# -f -> First file in directory
# -l -> The last file directory
while getopts ":a:f:l:v:m:r:s:" opt; do
    case ${opt} in
        a)arg1=$OPTARG 
        is_all_files_option=1
        ;;
        f)arg1=$OPTARG
        is_first_file_option=1
        ;;
        l)arg1=$OPTARG
        is_last_file_option=1
        ;;
        v)arg2=$OPTARG 
        is_invert_match_option=1
        ;;
        m)arg3=$OPTARG 
        is_match_option=1
        ;;
        r)arg4=$OPTARG
        is_all_files_option=1
        ;;
        s)arg5=$OPTARG
        is_save_result_log_option=1
        ;;
        \?) echo "Invalid option: $OPTARG" >&2
            usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2
            usage ;;
    esac
done
shift $((OPTIND -1))

# Check if all arguments are provided
if [[ -z $arg1 || -z $arg2 || -z $arg3 || -z $arg4 || -z $arg5 ]]; then
    echo "Error: All arguments (-v, -m, -r) are required."
fi


# Print the values of the arguments
echo "Argument 1: $arg1"
echo "Argument 2: $arg2"
echo "Argument 3: $arg3"
echo "Argument 4: $arg4"
echo "Argument 4: $arg5"
echo "Argument 4: $arg6"



# Check if the directory exists
if [ ! -d "$arg1" ]; then
    echo "Error: Directory '$arg1' does not exist."
    exit 1
fi


if [ "$is_last_file_option" -eq 1 ]; then
file_list=$(ls  "$arg1"/*.txt)
fi

if [ "$is_first_file_option" -eq 1 ]; then
file_list=$(ls -r "$arg1"/*.txt)
fi


# Iterate over each text file in the directory
for file in "$arg1"/*.*; do
    echo "Reading file: $file"
    # Read each line of the file
    while IFS= read -r line; do
        # Extract the value of the "app_token" field using grep and awk
        if [ "$is_invert_match_option" -eq 1 ]; then
        	line_log=$(echo "$line" | grep  "$arg3" | grep -v "\b$arg2\b")
        else
        	line_log=$(echo "$line" | grep  "$arg3")
        fi
        
        # Check if app_token is not empty
	if [ -n "$line_log" ]; then
		((LINE_INDEX++))
		
		# Output the value of the "app_token" field
		echo "line $LINE_INDEX : $line_log"
	fi
	
    done < "$file"
    
    
   
    if [ "$is_first_file_option" -eq 1 ]; then
     	# Exit the loop after processing the first file or last file
    	break
    fi
    
    if [ "$is_last_file_option" -eq 1 ]; then
    	break
    fi
done



