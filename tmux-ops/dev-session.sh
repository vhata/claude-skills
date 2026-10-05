#!/usr/bin/env bash
# dev-session — create a numbered dev window in the current tmux session
#
# Usage: dev-session [NUMBER]
#
# Creates a window named "dev-N" in the current session with two panes:
#   ┌─────────────────────┬─────────────────────┐
#   │                     │                     │
#   │    claude code      │       shell         │
#   │       (50%)         │       (50%)         │
#   │                     │                     │
#   └─────────────────────┴─────────────────────┘

set -euo pipefail

NUM="${1:-1}"
WINDOW="dev-${NUM}"

# Determine the target session: use current session if inside tmux, else "discord"
if [[ -n "${TMUX:-}" ]]; then
    SESSION="$(tmux display-message -p '#S')"
else
    SESSION="discord"
fi

# If the window already exists, just switch to it
if tmux list-windows -t "$SESSION" -F '#{window_name}' 2>/dev/null | grep -qx "$WINDOW"; then
    if [[ -n "${TMUX:-}" ]]; then
        exec tmux select-window -t "$SESSION:$WINDOW"
    else
        exec tmux attach-session -t "$SESSION:$WINDOW"
    fi
fi

# Create the window in the existing session
tmux new-window -t "$SESSION" -n "$WINDOW"

# Split 50/50 left (claude) | right (shell)
tmux split-window -h -t "$SESSION:$WINDOW" -l 50%

# Pane map:
#   .0 = left  (claude code)
#   .1 = right (shell)

# Set CLAUDE_TMUX_PANE so hooks can target the shell pane
tmux set-environment -t "$SESSION" "CLAUDE_TMUX_PANE_${NUM}" "$SESSION:$WINDOW.1"

# Launch claude in the left pane
tmux send-keys -t "$SESSION:$WINDOW.0" \
    "export CLAUDE_TMUX_PANE=\"$SESSION:$WINDOW.1\" && claude" Enter

# Focus the claude pane
tmux select-pane -t "$SESSION:$WINDOW.0"

# Switch to the new window
if [[ -n "${TMUX:-}" ]]; then
    tmux select-window -t "$SESSION:$WINDOW"
else
    exec tmux attach-session -t "$SESSION:$WINDOW"
fi
