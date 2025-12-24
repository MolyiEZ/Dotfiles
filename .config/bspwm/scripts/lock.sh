#!/bin/sh

TRANSPARENT='00000000'
INSIDE='1a1a1ab2'
RING='4d726b'
VER='e7a419'
WRONG='a80a2f'
KEYHL='5ebda7'
TEXT='b4c8be'
TEXT_VER='ffffff'
TEXT_WRONG='ffffff'

FONT="JetBrainsMono Nerd Font"

i3lock \
    --ignore-empty-password \
    --blur 8 \
    --clock \
    --indicator \
    --radius 90 \
    --ring-width 7 \
    \
    --time-str="%H:%M:%S" \
    --date-str="%a, %b/%d/%Y" \
    --time-font="$FONT" \
    --date-font="$FONT" \
    --layout-font="$FONT" \
    \
    --inside-color=$INSIDE \
    --ring-color=$RING \
    --separator-color=$TRANSPARENT \
    \
    --insidever-color=$VER \
    --ringver-color=$RING \
    \
    --insidewrong-color=$WRONG \
    --ringwrong-color=$RING \
    \
    --line-color=$TRANSPARENT \
    --keyhl-color=$KEYHL \
    --bshl-color=$KEYHL \
    \
    --time-color=$TEXT \
    --date-color=$TEXT \
    --layout-color=$TEXT \
    \
    --verif-color=$TEXT_VER \
    --wrong-color=$TEXT_WRONG \
    --verif-text="" \
    --wrong-text="" \
    --noinput-text="" \
    --lock-text="Locking..." \
    --lockfailed-text="Lock Failed" \
    "$@"
