cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "wait a little bit"


# Error checking
if [[ ! -f "$submissions_file" ]]; then
    echo "O O the submission file is not found at $submissions_file"
    exit 1
fi
check_submissions $submissions_file
