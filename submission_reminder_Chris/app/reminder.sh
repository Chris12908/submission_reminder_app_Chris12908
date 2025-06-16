#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

# the shortcut to submissions file
submissions_file="./assets/submissions.txt"

# Print remaining days 
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
