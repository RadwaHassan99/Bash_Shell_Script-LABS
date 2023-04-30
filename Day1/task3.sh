#!/bin/bash
#execute by using root the script every one min to monitor system load and add it to var/log/system-load.PS
##Exit Codes:
##0: Normal Terminated
##1: User isn't root

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while true
do

  #Get the System load average for the last minute
  LOAD=$(uptime)

  # Get current date and time
  NOW=$(date +"%Y-%m-%d %H:%M:%S")

  # Get system load and append it to the system-load log file
  echo "$NOW - $LOAD" >> /var/log/system-load

  #log every 60 seconds
  sleep 60
done

exit 0
