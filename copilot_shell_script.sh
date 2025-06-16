#!/bin/bash

read -p "Enter the assignment name now:..." assignment_name

dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

if [[ ! -d "$dir" ]]; then
	echo " we can't find the submission_reminder_directory"
	exit 1
fi

sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$assignment_name\"/" "$dir/config/config.env"
echo "new assignment is updating to \"$new_assignment\" "
echo "The reminder check is running"
bash "$dir/startup.sh"
