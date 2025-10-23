#!/usr/bin/env bash
set -euo pipefail

address="${1:-}"
button="${2:-}"

if [[ -z "$address" || -z "$button" ]]; then
  echo "Usage: FocusWindow.sh <address> <button>" >&2
  exit 2
fi

HCTL="/usr/bin/hyprctl"

case "$button" in
  1)
    "$HCTL" keyword cursor:no_warps 1
    "$HCTL" dispatch focuswindow "address:$address"
    "$HCTL" keyword cursor:no_warps 0
    ;;
  2)
    "$HCTL" dispatch closewindow "address:$address"
    ;;
esac

