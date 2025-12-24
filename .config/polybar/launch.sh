#!/usr/bin/env bash

# Kill any polybar instantes that are already running.
killall -q polybar

# Wait until the instances have been killed.
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Check if we have multiple monitors and launch polybar.
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main &
    done
else
    polybar --reload main &
fi
