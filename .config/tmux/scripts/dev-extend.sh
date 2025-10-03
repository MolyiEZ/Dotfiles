#!/usr/bin/env bash
set -u

# Figure out session + current pane's cwd
SESSION="$(tmux display-message -p -F '#S' 2>/dev/null || true)"
[ -z "${SESSION:-}" ] && SESSION="$(tmux list-clients -F '#{client_session}' 2>/dev/null | head -n1)"
[ -z "${SESSION:-}" ] && { echo "No tmux session found."; exit 1; }

CWD="$(tmux display-message -p -F '#{pane_current_path}' 2>/dev/null || pwd)"
[ -d "$CWD" ] || CWD="$HOME"

# Run a command in a login shell so PATH/rc files are loaded
run_login() {
  # Use the user's default shell (falls back to zsh)
  local SHELL_PATH="${SHELL:-/bin/zsh}"
  "$SHELL_PATH" -lc "$*"
}


ensure_window () {
  local name="$1"; shift
  local cmd="$*"
  local shell="${SHELL:-/bin/zsh}"

  if ! tmux list-windows -t "${SESSION}:" -F '#W' 2>/dev/null | grep -qx "$name"; then
    tmux new-window -t "${SESSION}:" -n "$name" -c "$CWD" "$shell -il" \; \
         send-keys  -t "$SESSION:$name" "$cmd" C-m
  else
    tmux send-keys -t "$SESSION:$name" C-c "cd -- $(printf %q "$CWD") && $cmd" C-m
  fi
}

# Create/refresh the three windows
ensure_window WATCHER "npx rbxtsc -w"
ensure_window ROJO    "rojo serve"
ensure_window TREE    "npx io-serve"

exit 0

