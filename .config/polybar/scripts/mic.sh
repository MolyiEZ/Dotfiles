#!/bin/sh

get_icon() {
    mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
    if [ "$mute" = "yes" ]; then
        echo "%{F#ff0000}󰍭%{F-}"
    else
        echo "󰍬"
    fi
}

get_icon

pactl subscribe | grep --line-buffered "source" | while read -r _; do
    get_icon
done
