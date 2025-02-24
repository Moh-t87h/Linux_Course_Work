#!/bin/bash 

#Getting the name of the active branch
BRANCH_NAME=$(git branch --show-current)
#Search for the branch in the bugs.csv file
BUG_INFO=$(grep ",$BRANCH_NAME," bugs.csv)

if [[ -z "$BUG_INFO" ]]; then
    echo "No matching bug found for branch $BRANCH_NAME in bugs.csv"
    exit 1
fi

BUG_ID=$(echo "$BUG_INFO" | cut -d',' -f1)
DESCRIPTION=$(echo "$BUG_INFO" | cut -d',' -f2)
DEVELOPER_NAME=$(echo "$BUG_INFO" | cut -d',' -f3)
PRIORITY=$(echo "$BUG_INFO" | cut -d',' -f4)

CURRENT_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

DEV_DESCRIPTION="$1" 

if [[ -z "$DEV_DESCRIPTION" ]]; then
    COMMIT_MSG="BugID:$BUG_ID | DateTime:$CURRENT_DATETIME | Branch:$BRANCH_NAME | Dev:$DEVELOPER_NAME | Priority:$PRIORITY | Desc:$DESCRIPTION"
else
    COMMIT_MSG="BugID:$BUG_ID | DateTime:$CURRENT_DATETIME | Branch:$BRANCH_NAME | Dev:$DEVELOPER_NAME | Priority:$PRIORITY | Desc:$DESCRIPTION | Dev Description:$DEV_DESCRIPTION"
fi

git add .
git commit -m "$COMMIT_MSG"