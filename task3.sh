#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Get current date and time
now=$(date +"%Y-%m-%d %H:%M:%S")

# Get system load and append it to the system-load log file
load=$(uptime)
echo "$now - $load" >> /var/log/system-load
