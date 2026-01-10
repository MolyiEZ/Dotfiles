#!/bin/bash

### Config ###

# User
USER="Molyi"

# Colors
COLOR_LINE="#ffffff"
COLOR_0="#2d333b"
COLOR_1="#033a16"
COLOR_2="#196c2e"
COLOR_3="#2ea043"
COLOR_4="#56d364"

### Internal ###
CACHE="/tmp/leetcode_streak_${USER}_$$"
INTERNET_MAX_RETRIES=${INTERNET_MAX_RETRIES:-30}

# Cleanup on exit
trap "rm -f $CACHE" EXIT

# Wait for internet connection
RETRIES=0

while ! ping -c 1 -W 1 8.8.8.8 &>/dev/null; do
    if [ "$RETRIES" -ge "$INTERNET_MAX_RETRIES" ]; then
        echo "%{F#ff0000}OFFLINE%{F-}"
        exit 0
    fi

    sleep 2
    ((RETRIES++))
done

# Fetch data
QUERY='{"query": "query getUserProfile($username: String!) { matchedUser(username: $username) { submissionCalendar } }", "variables": {"username": "'"$USER"'"}}'

if ! curl -sf -X POST -H "Content-Type: application/json" -d "$QUERY" "https://leetcode.com/graphql" >"$CACHE"; then
    echo "%{F#ff0000}ERROR %{F-}"
    exit 0
fi

# Verify data
CALENDAR_JSON=$(jq -r '.data.matchedUser.submissionCalendar' "$CACHE")

if [ "$CALENDAR_JSON" == "null" ] || [ -z "$CALENDAR_JSON" ]; then
    echo "%{F#ff0000}ERROR %{F-}"
    exit 0
fi

OUTPUT=""

# 2 days ago -> 1 day ago -> Today
for i in 2 1 0; do
    TARGET_DATE=$(date -u -d "$i days ago" '+%Y-%m-%d')

    COUNT=$(echo "$CALENDAR_JSON" | jq -r --arg date "$TARGET_DATE" '
        to_entries |
        map(select((.key | tonumber | todate[0:10]) == $date)) |
        map(.value) | add // 0
    ')

    if [ -z "$COUNT" ] || [ "$COUNT" = "null" ]; then COUNT=0; fi

    if [ "$COUNT" -eq 0 ]; then
        COL=$COLOR_0
    elif [ "$COUNT" -eq 1 ]; then
        COL=$COLOR_1
    elif [ "$COUNT" -eq 2 ]; then
        COL=$COLOR_2
    elif [ "$COUNT" -le 5 ]; then
        COL=$COLOR_3
else COL=$COLOR_4; fi

    if [ "$i" -eq 0 ]; then
        OUTPUT="${OUTPUT}%{u$COLOR_LINE}%{+u}%{F$COL}■%{F-}%{-u} "
    else
        OUTPUT="${OUTPUT}%{F$COL}■%{F-} "
    fi
done

echo "${OUTPUT% }"
