#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  exit 1
fi

TARGET="$1"

if tmux list-windows -F "#{window_index}" | grep -qx "$TARGET"; then
  tmux swap-window -d -t "$TARGET"
else
  tmux move-window -t "$TARGET"
fi
