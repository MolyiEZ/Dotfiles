#!/bin/bash

LOCK_CMD="$HOME/.config/bspwm/scripts/lock.sh -n"

# Kills all xss-lock instances and starts a new one.
killall xss-lock 2>/dev/null
xss-lock --transfer-sleep-lock -- $LOCK_CMD &

# Kills all xidlehook instances
killall xidlehook 2>/dev/null

# 600s (10m) -> Lock the screen
# +300s (total 15m) -> Screen off
xidlehook \
    --not-when-fullscreen \
    --not-when-audio \
    --timer 600 \
    "$LOCK_CMD" \
    "" \
    --timer 300 \
    "xset dpms force off" \
    "xset dpms force on" &
