# Requesting for onez username
read -p "Registered Name: " username

# Defining the root directory
dire="submission_reminder_${username}"

# Creating the tree for the program
mkdir -p "$dire/config"
mkdir -p "$dire/modules"
mkdir -p "$dire/app"
mkdir -p "$dire/assets"

# Adding content on  config
cat <<EOF > "$dire/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Adding content  on functions
cat <<'EOF' > "$dire/modules/functions.sh"
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

# Adding content on reminder
cat <<'EOF' > "$dire/app/reminder.sh"
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
EOF
#!/bin/bash
cat <<'EOF' > "$dire/startup.sh"
cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Kindly wait as the Reminder apk launches...."


# Error checking
if [[ ! -f "$submissions_file" ]]; then
    echo "ERROR***** The submission file hasnt been found at $submissions_file"
    exit 1
fi
check_submissions $submissions_file
EOF

# Populate submissions.txt 
cat <<EOF > "$dire/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
jean, Git, not submitted
Graciella, Shell Basics, submitted
Brian smith, Shell Navigation, submitted
Christophe, Git, submitted
anette, Shell Basics, not submitted
Muhire, Shell Navigation, not submitted
Miriam, Git, not submitted
John, Shell Basics, submitted
Jacques, Git, submitted
Thierry, Shell Navigation, submitted
EOF

# making all files executable
find "$dire" -type f -name "*.sh" -exec chmod +x {} \;

echo "The program has been created in $dire successfully"
