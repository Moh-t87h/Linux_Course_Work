#!/usr/bin/env bash

# Set variables
CSV_FILE="bugs.csv"
OPTIONAL_DESC=$1 # Optional parameter from the user (to be overridden)
CURRENT_BRANCH="$(git branch --show-current)" # Gets the current branch

# Check that the CSV file exists
if [[ ! -f "$CSV_FILE" ]]; then
echo "❌ ERROR: File '$CSV_FILE' not found!"
exit 1
fi

#Find a matching line by branch
LINE="$(grep ",$CURRENT_BRANCH," "$CSV_FILE" || true)"
if [[ -z "$LINE" ]]; then
echo "ERROR: There is no matching data for branch '$CURRENT_BRANCH' in $CSV_FILE."
exit 1
fi

# Parse data from CSV
IFS=',' read -r BUGID DESCRIPTION BRANCH DEV_NAME BUG_PRIORITY REPO_PATH GITHUBURL <<< "$LINE"

# Create a commit description in the correct format
CURRENT_DATETIME="$(date +%Y-%m-%d_%H-%M)"
COMMIT_MSG="$BUGID:$CURRENT_DATETIME:$BRANCH:$DEV_NAME:$BUG_PRIORITY:$DESCRIPTION"

# If the user provided an additional parameter – we will use it as an override
if [[ -n "$OPTIONAL_DESC" ]]; then
COMMIT_MSG="$COMMIT_MSG:$OPTIONAL_DESC"
fi

# Print the final commit message
echo "Commit message created:"
echo "$COMMIT_MSG"

# Perform an add, commit, and push
git add .
git commit -m "$COMMIT_MSG"
git push origin "$CURRENT_BRANCH"
echo "Uploaded successfully to GitHub!"