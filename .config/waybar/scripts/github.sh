#!/bin/bash

USER="MolyiEZ"
CACHE="/tmp/github_streak_${USER}_$$"
INTERNET_MAX_RETRIES=30

COLOR_0="#2d333b" 
COLOR_1="#0e4429"
COLOR_2="#006d32"
COLOR_3="#26a641"
COLOR_4="#39d353"

# Cleanup on exit
trap "rm -f $CACHE" EXIT

RETRIES=0

# Wait for internet connection
while ! ping -c 1 -W 1 8.8.8.8 &> /dev/null; do
    # Check if we have waited too long
    if [ "$RETRIES" -ge "$INTERNET_MAX_RETRIES" ]; then
        # TIMEOUT REACHED: Die silently (or you can echo an error icon)
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
    DATE=$(date -d "$i days ago" '+%d-%m-%Y')
    
    COUNT=$(grep "data-date=\"$DATE\"" "$CACHE" 2>/dev/null | \
            grep -o 'data-count="[0-9]*"' | \
            grep -o '[0-9]*')

    if [ -z "$COUNT" ]; then COUNT=0; fi

    if [ "$COUNT" -eq 0 ]; then COL=$COLOR_0
    elif [ "$COUNT" -le 3 ]; then COL=$COLOR_1
    elif [ "$COUNT" -le 6 ]; then COL=$COLOR_2
    elif [ "$COUNT" -le 9 ]; then COL=$COLOR_3
    else COL=$COLOR_4
    fi

    OUTPUT="$OUTPUT<span color='$COL'>■</span> "
    TOOLTIP="${TOOLTIP}${DATE}: ${COUNT} commits\r"
done

FINAL_TEXT=$(echo "$OUTPUT" | sed 's/ $//')
SAFE_TOOLTIP=$(echo "$TOOLTIP" | sed 's/"/\\"/g')
echo "{\"text\": \"$FINAL_TEXT\", \"tooltip\": \"$SAFE_TOOLTIP\"}"
