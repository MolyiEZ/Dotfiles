#!/bin/bash

USER="MolyiEZ"
CACHE="/tmp/monkeytype_stats_$$"
INTERNET_MAX_RETRIES=30

COLOR_0="#323437"
COLOR_1="#5E552E"
COLOR_2="#8A7626"
COLOR_3="#B6961D"
COLOR_4="#E2B714"

# Cleanup on exit
trap "rm -f $CACHE" EXIT

# Check API env variable
if [ -z "$MONKEYTYPE_API_KEY" ]; then
    echo "{\"text\": \"KEY 🐵\", \"tooltip\": \"Set env var\", \"class\": \"error\"}"
    exit 0
fi

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
if ! curl -s -H "Authorization: ApeKey $MONKEYTYPE_API_KEY" \
    "https://api.monkeytype.com/users/currentTestActivity" > "$CACHE"; then
    echo "{\"text\": \"ERROR 🐵\", \"tooltip\": \"Offline or Bad Key\", \"class\": \"error\"}"
    exit 0
fi

# Verify data
if [ ! -s "$CACHE" ]; then
    echo "{\"text\": \"ERROR 🐵\", \"tooltip\": \"No Data\", \"class\": \"error\"}"
    exit 0
fi

OUTPUT=""
TOOLTIP=""

# Loop = 2 days ago -> 1 day ago -> Today
for i in 2 1 0; do
    TARGET_DATE=$(date -d "$i days ago" '+%Y-%m-%d')

    COUNT=$(jq -r --arg TARGET "$TARGET_DATE" '
        .data as $d |
        $d.testsByDays as $arr |
        ($d.lastDay / 1000) as $last_ts |

        # Iterate indices of the array
        range(0; $arr | length) |
        . as $idx |

        # Calculate date for this index
        # Date = LastDay - (ArrayLength - 1 - Index) days
        ($last_ts - (($arr|length) - 1 - $idx) * 86400) |
        strftime("%Y-%m-%d") as $date_str |

        # Select if matches target
        select($date_str == $TARGET) |
        $arr[$idx]
    ' "$CACHE")

    if [ -z "$COUNT" ] || [ "$COUNT" = "null" ]; then COUNT=0; fi

    if [ "$COUNT" -eq 0 ]; then COL=$COLOR_0
    elif [ "$COUNT" -le 5 ]; then COL=$COLOR_1
    elif [ "$COUNT" -le 10 ]; then COL=$COLOR_2
    elif [ "$COUNT" -le 20 ]; then COL=$COLOR_3
    else COL=$COLOR_4
    fi

    DATE_TOOLTIP=$(date -d "$i days ago" '+%d-%m-%Y')

    # Line for today square
    if [ "$i" -eq 0 ]; then
        OUTPUT="$OUTPUT<span color='$COL' underline='single'>■</span> "
    else
        OUTPUT="$OUTPUT<span color='$COL'>■</span> "
    fi

    TOOLTIP="${TOOLTIP}${DATE_TOOLTIP}: ${COUNT} tests\r"
done

# Remove the last \r
TOOLTIP=${TOOLTIP%\\r}

FINAL_TEXT=$(echo "$OUTPUT" | sed 's/ $//')
SAFE_TOOLTIP=$(echo "$TOOLTIP" | sed 's/"/\\"/g')

echo "{\"text\": \"$FINAL_TEXT\", \"tooltip\": \"$SAFE_TOOLTIP\"}"
