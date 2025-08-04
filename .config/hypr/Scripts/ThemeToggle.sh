#!/bin/bash
# ThemeSwitcher Script
# You can change the Key to exec this script on Configs/Keybinds.conf (Default is SUPER-SHIFT-T)
# To create a theme just create a dot conf file on hypr/Themes and config everything you want

set -euo pipefail

DOT="$HOME/.config/hypr"
THEMES_DIR="$DOT/Themes"
SYMLINK="$DOT/Configs/Theme.conf"
HYPR_CONF="$DOT/hyprland.conf"

# Get list of theme files (sorted, full path)
themes=($(find "$THEMES_DIR" -maxdepth 1 -type f -name '*.conf' | sort))

# If no themes found, exit
if [ ${#themes[@]} -eq 0 ]; then
    notify-send "Hyprland Theme Switcher" "No themes found in $THEMES_DIR"
    exit 1
fi

# Get current theme file (resolved path)
current_theme=$(readlink -f "$SYMLINK" 2>/dev/null || true)

# Find index of current theme
current_index=-1
for i in "${!themes[@]}"; do
    if [[ "${themes[$i]}" == "$current_theme" ]]; then
        current_index=$i
        break
    fi
done

# Determine next theme
next_index=$(( (current_index + 1) % ${#themes[@]} ))
next_theme="${themes[$next_index]}"

# Update symlink
ln -sf "$next_theme" "$SYMLINK"

# Update hyprland.conf source
sed -i "$(grep -n '^source =' "$HYPR_CONF" | tail -n1 | cut -d: -f1)s|^source =.*|source = $next_theme|" "$HYPR_CONF"



# Notify
theme_name=$(basename "$next_theme" .conf)
notify-send "Hyprland Theme" "Switched to: $theme_name"

# Reload
hyprctl reload


