#!/bin/env bash
# shellcheck source=/dev/null

# Define color variables
GREEN='\e[32m'
RED='\e[31m'
RESET='\e[0m'

CheckDiskSpaceFree() {
    # Ensure both arguments are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: CheckDiskSpaceFree <directory> <required_space>[M|G]"
        echo "Example: CheckDiskSpaceFree /var/data 500M"
        echo "Example: CheckDiskSpaceFree /var/data 1.5G"
        return 1
    fi

    local target_dir="$1"
    local required_input="$2"

    # Validate that target directory exists
    if [ ! -d "$target_dir" ]; then
        echo -e "[ ${RED}ERROR${RESET} ]: Directory '$target_dir' does not exist."
        return 1
    fi

    # Extract available space in kilobytes using df -k
    local available_kb
    available_kb=$(df -k "$target_dir" | awk 'NR==2 {print $4}')

    # Parse the unit (M or G) and convert required space to Kilobytes (KB)
    # If no unit is provided, it defaults to GB
    local required_kb
    required_kb=$(awk -v input="$required_input" 'BEGIN {
        # Extract numeric value and convert to uppercase for the unit
        match(input, /[0-9.]+/);
        val = substr(input, RSTART, RLENGTH);
        unit = toupper(substr(input, RSTART + RLENGTH));
        
        # Default to GB if no unit or invalid unit is provided
        if (unit != "M" && unit != "G") {
            unit = "G";
        }
        
        # Convert to KB (1MB = 1024KB, 1GB = 1048576KB)
        if (unit == "M") {
            print int(val * 1024);
        } else {
            print int(val * 1048576);
        }
    }')

    # Format human-readable output dynamically based on requested unit size
    local available_display
    available_display=$(awk -v kb="$available_kb" -v input="$required_input" 'BEGIN {
        match(input, /[0-9.]+/);
        unit = toupper(substr(input, RSTART + RLENGTH));
        if (unit != "M" && unit != "G") unit = "G";
        
        if (unit == "M") {
            printf "%.2fMB", kb / 1024;
        } else {
            printf "%.2fGB", kb / 1048576;
        }
    }')

    # Compare available space with required space using KB integers
    if [ "$available_kb" -ge "$required_kb" ]; then
        echo -e "[ ${GREEN}OK${RESET} ]: $target_dir has ${available_display} free (Required: ${required_input})."
        return 0
    else
        echo -e "[ ${RED}ERROR${RESET} ]: $target_dir only has ${available_display} free (Required: ${required_input})."
        return 1
    fi
}

# Run Function
CheckDiskSpaceFree "$1" "$2"
