#!/bin/bash

USER="Molyi"
CACHE="/tmp/leetcode_streak_${USER}_$$"
INTERNET_MAX_RETRIES=30

COLOR_0="#2d333b"
COLOR_1="#033a16"
COLOR_2="#196c2e"
COLOR_3="#2ea043"
COLOR_4="#56d364"

# Cleanup on exit
trap "rm -f $CACHE" EXIT

RETRIES=0

# Wait for internet connection
while ! ping -c 1 -W 1 8.8.8.8 &>/dev/null; do
    if [ "$RETRIES" -ge "$INTERNET_MAX_RETRIES" ]; then
        echo "{\"text\": \"OFFLINE\", \"tooltip\": \"Internet connection timed out (60s)\", \"class\": \"error\"}"
        exit 0
    fi

    sleep 2
    ((RETRIES++))
done

QUERY='{"query": "query getUserProfile($username: String!) { matchedUser(username: $username) { submissionCalendar } }", "variables": {"username": "'"$USER"'"}}'

# Fetch data
if ! curl -sf -X POST -H "Content-Type: application/json" -d "$QUERY" "https://leetcode.com/graphql" >"$CACHE"; then
    echo "{\"text\": \"ERROR \", \"tooltip\": \"API Error\", \"class\": \"error\"}"
    exit 0
fi

CALENDAR_JSON=$(jq -r '.data.matchedUser.submissionCalendar' "$CACHE")

# Verify data
if [ "$CALENDAR_JSON" == "null" ] || [ -z "$CALENDAR_JSON" ]; then
    echo "{\"text\": \"ERROR \", \"tooltip\": \"User not found or no data\", \"class\": \"error\"}"
    exit 0
fi

OUTPUT=""
TOOLTIP=""

# Loop = 2 days ago -> 1 day ago -> Today
for i in 2 1 0; do
    TARGET_DATE=$(date -d "$i days ago" '+%Y-%m-%d')
    TOOLTIP_DATE=$(date -d "$i days ago" '+%d-%m-%Y')

    COUNT=$(echo "$CALENDAR_JSON" | jq -r --arg date "$TARGET_DATE" '
        to_entries |
        map(select((.key | tonumber | todate | startswith($date)))) |
        map(.value) | add // 0
    ')

    if [ "$COUNT" -eq 0 ]; then
        COL=$COLOR_0
    elif [ "$COUNT" -eq 1 ]; then
        COL=$COLOR_1
    elif [ "$COUNT" -eq 2 ]; then
        COL=$COLOR_2
    elif [ "$COUNT" -le 5 ]; then
        COL=$COLOR_3
    else
        COL=$COLOR_4
    fi

    if [ "$i" -eq 0 ]; then
        OUTPUT="$OUTPUT<span color='$COL' underline='single'>■</span> "
    else
        OUTPUT="$OUTPUT<span color='$COL'>■</span> "
    fi

    TOOLTIP="${TOOLTIP}${TOOLTIP_DATE}: ${COUNT} submissions\r"
done

# Remove the last \r
TOOLTIP=${TOOLTIP%\\r}

FINAL_TEXT=$(echo "$OUTPUT" | sed 's/ $//')
SAFE_TOOLTIP=$(echo "$TOOLTIP" | sed 's/"/\\"/g')

echo "{\"text\": \"$FINAL_TEXT\", \"tooltip\": \"$SAFE_TOOLTIP\"}"
