#!/bin/bash

### Config ###

# User
USER="MolyiDev"

# Colors
COLOR_LINE="#ffffff"
COLOR_0="#2d333b"
COLOR_1="#033a16"
COLOR_2="#196c2e"
COLOR_3="#2ea043"
COLOR_4="#56d364"

### Internal ###
CACHE="/tmp/github_streak_${USER}_$$"
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

# Get data
if ! curl -sf -m 10 "https://github.com/users/$USER/contributions" >"$CACHE"; then
    echo "%{F#ff0000}ERROR %{F-}"
    exit 0
fi

# Verify data
if [ ! -s "$CACHE" ]; then
    echo "%{F#ff0000}ERROR %{F-}"
    exit 0
fi

OUTPUT=""

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

    if [ "$i" -eq 0 ]; then
        OUTPUT="${OUTPUT}%{u$COLOR_LINE}%{+u}%{F$COL}■%{F-}%{-u} "
    else
        OUTPUT="${OUTPUT}%{F$COL}■%{F-} "
    fi
done

echo "${OUTPUT% }"
