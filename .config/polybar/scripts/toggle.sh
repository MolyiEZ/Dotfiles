#!/bin/bash

if pgrep -x "polybar" >/dev/null; then
    # If running, kill it.
    CURRENT_PADDING=$(bspc config top_padding)
    pkill -KILL -x polybar
    bspc config top_padding $CURRENT_PADDING
else
    # If not running, launch it.
    ~/.config/polybar/launch.sh
fi
