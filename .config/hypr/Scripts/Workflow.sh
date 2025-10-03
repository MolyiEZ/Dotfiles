#!/usr/bin/env bash
set -euo pipefail

# App commands from your variables
BROWSER="zen-browser"
TERM="foot"
DISCORD="discord"
STUDIO="flatpak run --command=vinegar org.vinegarhq.Vinegar run"

# --- figure out a way to launch Studio directly via desktop entry ---
# This finds the Studio .desktop id that Wofi uses, then calls it via gtk-launch.
find_studio_desktop() {
  # common flatpak export dirs
  for d in "$HOME/.local/share/flatpak/exports/share/applications" \
           "/var/lib/flatpak/exports/share/applications" ; do
    [[ -d "$d" ]] || continue
    # look for a desktop entry that says "Roblox Studio"
    # (grep -i to be safe across locales)
    local f
    while IFS= read -r -d '' f; do
      if grep -qi "^Name=.*Roblox Studio" "$f"; then
        basename "$f"
        return 0
      fi
    done < <(find "$d" -maxdepth 1 -type f -name "*.desktop" -print0)
  done
  return 1
}

# Monitors
MON_BIG="HDMI-A-1"   # 1920x1080
MON_SMALL="VGA-1"    # 1360x768

# --- helper: build one exec string ---
hypr_exec_ws() {
  local ws="$1"; shift
  # build a single string for hyprctl
  local cmd="$*"
  hyprctl dispatch exec "[workspace $ws silent] $cmd"
}

# Pre-position workspaces on outputs BEFORE launching apps
hyprctl dispatch moveworkspacetomonitor 1 "$MON_SMALL"
hyprctl dispatch moveworkspacetomonitor 4 "$MON_BIG"

hyprctl dispatch focusmonitor "$MON_BIG"
hyprctl dispatch workspace 4
hyprctl dispatch focusmonitor "$MON_SMALL"
hyprctl dispatch workspace 1

# 1) Browser on workspace 1
hypr_exec_ws 1 "$BROWSER" &

# 2) Vinegar (Roblox Studio) on workspace 2
hypr_exec_ws 2 "$STUDIO" &

# 3) Discord on workspace 3
hypr_exec_ws 3 "$DISCORD" &

# 4) Foot with yazi on workspace 4 starting in ~/Projects:
hypr_exec_ws 4 "$TERM -D \"$HOME/Projects\" -e tmux new-session yazi" &

# 9) One terminal with tmux session "notes" (two windows: todo + done)
#    Create/refresh the tmux session first…
if ! tmux has-session -t notes 2>/dev/null; then
  tmux new-session -d -s notes -n todo "nvim ~/Vault/Notes/To-Do"
  tmux new-window  -t notes -n done "nvim ~/Vault/Notes/Things-Done"
fi
# …then attach it on ws9
hypr_exec_ws 9 "$TERM -D \"$HOME/Projects\" -e tmux attach -t notes"&

# Re-assert workspace focus per monitor (some apps steal focus while spawning)
hyprctl dispatch focusmonitor "$MON_BIG";   hyprctl dispatch workspace 4
hyprctl dispatch focusmonitor "$MON_SMALL"; hyprctl dispatch workspace 1
