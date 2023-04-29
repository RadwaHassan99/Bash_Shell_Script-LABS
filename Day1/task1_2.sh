#!/bin/bash
## Script accepts two floating-point numbers from command line as parameters, and prints out their division result
## Parameters
##	1st parameter: 1st floating-point number
##	2nd parameter: 2nd floating-point number
## Exit codes
##	0: Success
##	1: Not enough parameters
##	2: Division by zero
##	3: NUM1 is not a floating-point number
##	4: NUM2 is not a floating-point number
## Check for parameters
[ ${#} -ne 2 ] && exit 1
## Assign values to custom variables
NUM1=${1}
NUM2=${2}

## Check for floating-point values
if ! [[ "${NUM1}" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo "NUM1 is not a floating-point number"
    exit 3
fi

if ! [[ "${NUM2}" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo "NUM2 is not a floating-point number"
    exit 4
fi

## Check for division by zero
[ $(echo "${NUM2} == 0" | bc -l) -eq 1 ] && exit 2

## Perform division operation using 'bc'
RES=$(echo "${NUM1} / ${NUM2}" | bc -l)

## Prints out the result
echo "Division = ${RES}"

exit 0
