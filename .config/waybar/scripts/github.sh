#!/bin/bash

USER="MolyiEZ"
CACHE="/tmp/github_streak_${USER}_$$"
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
while ! ping -c 1 -W 1 8.8.8.8 &> /dev/null; do
    if [ "$RETRIES" -ge "$INTERNET_MAX_RETRIES" ]; then
        echo "{\"text\": \"OFFLINE\", \"tooltip\": \"Internet connection timed out (60s)\", \"class\": \"error\"}"
        exit 0
    fi

    sleep 2
    ((RETRIES++))
done

# Get data
if ! curl -sf -m 10 "https://github.com/users/$USER/contributions" > "$CACHE"; then
    echo "{\"text\": \"ERROR \", \"tooltip\": \"Offline\", \"class\": \"error\"}"
    exit 0
fi

# Verify data
if [ ! -s "$CACHE" ]; then
    echo "{\"text\": \"ERROR \", \"tooltip\": \"No Data\", \"class\": \"error\"}"
    exit 0
fi

OUTPUT=""
TOOLTIP=""

# Loop = 2 days ago -> 1 day ago -> Today
for i in 2 1 0; do
    # Github uses YYYY-MM-DD
    DATE=$(date -d "$i days ago" '+%Y-%m-%d')

    BLOCK=$(grep -A 2 "data-date=\"$DATE\"" "$CACHE")

    LEVEL=$(echo "$BLOCK" | grep -o 'data-level="[0-9]"' | head -n1 | grep -o '[0-9]')

    if [ -z "$LEVEL" ]; then LEVEL=0; fi

    case "$LEVEL" in
        0) COL=$COLOR_0 ;;
        1) COL=$COLOR_1 ;;
        2) COL=$COLOR_2 ;;
        3) COL=$COLOR_3 ;;
        4) COL=$COLOR_4 ;;
        *) COL=$COLOR_0 ;;
    esac

    if echo "$BLOCK" | grep -q "No contributions"; then
        COUNT=0
    else
        COUNT=$(echo "$BLOCK" | grep -o '[0-9]* contribution' | head -n1 | grep -o '[0-9]*')
        if [ -z "$COUNT" ]; then COUNT=0; fi
    fi

    DATE_TOOLTIP=$(date -d "$i days ago" '+%d-%m-%Y')

    # Line for today square
    if [ "$i" -eq 0 ]; then
        OUTPUT="$OUTPUT<span color='$COL' underline='single'>■</span> "
    else
        OUTPUT="$OUTPUT<span color='$COL'>■</span> "
    fi

    TOOLTIP="${TOOLTIP}${DATE_TOOLTIP}: ${COUNT} commits\r"
done

# Remove the last \r
TOOLTIP=${TOOLTIP%\\r}

FINAL_TEXT=$(echo "$OUTPUT" | sed 's/ $//')
SAFE_TOOLTIP=$(echo "$TOOLTIP" | sed 's/"/\\"/g')

echo "{\"text\": \"$FINAL_TEXT\", \"tooltip\": \"$SAFE_TOOLTIP\"}"
