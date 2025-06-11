#!/bin/bash
read -p "insert your name please:" name
dir=submission_reminder_app_$name
mkdir -p $dir
mkdir -p ./$dir/app ./$dir/modules ./$dir/config ./$dir/assets

#config.sh
cat << 'EOF' > "$dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
#functions
cat << 'EOF' > "$dir/modules/functions.sh"
#!/bin/bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)


        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
#reminder
cat << 'EOF' > "$dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions $submissions_file
EOF
#submission.txt
cat << 'EOF' > "$dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Duice, Shell Basics, not submitted
Tresor, Git, submitted
Pacifique, Shell Navigation, submitted
Megane, Shell Basics, not submitted
Jospin, Shell Navigation, submitted
Chris, Git, submitted
Floris, Shell Basics, not submitted
EOF
#startup
cat << 'EOF' > "$dir/startup.sh"
#!/bin/bash
source config/config.env
source modules/functions.sh
bash app/reminder.sh
EOF
#execute the scripts
chmod +x "$dir/startup.sh"
echo "Environment setup completed"

