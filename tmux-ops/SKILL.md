---
name: tmux-ops
description: >
  This skill should be used when the user asks to run commands in other panes,
  create tmux layouts, send keys to a pane, start services in a pane, interact
  with a running process in another pane, set up a dev session, or coordinate
  work across multiple tmux panes or windows. Also activates when the user
  references tmux, panes, windows, or sessions in the context of running
  commands or orchestrating their development environment.
version: 1.0.0
---

# tmux Operations

You are operating inside tmux. You can create panes, send commands to them,
read their contents, and orchestrate multi-pane workflows using your Bash tool.

## Environment

- tmux is always available
- `pane-base-index` is 0, `base-index` is 0
- The prefix key is both `C-b` and `C-a`
- If `CLAUDE_TMUX_PANE` is set, it identifies a shell pane you can target

## Pane Addressing

Panes are addressed as `session:window.pane`:

```
discord:dev-1.0  # claude pane in dev window 1
discord:dev-1.1  # shell pane in dev window 1
discord:dev-2.0  # claude pane in dev window 2
```

Use `tmux display-message -p '#S:#W.#P'` to get the current pane address.
Use `tmux list-panes -a -F '#{session_name}:#{window_name}.#{pane_index} #{pane_current_command} #{pane_width}x#{pane_height}'` to list all panes.

## Sending Commands to Panes

```bash
# Send a command and press Enter
tmux send-keys -t SESSION:WINDOW.PANE 'command here' Enter

# Send Ctrl-C to interrupt
tmux send-keys -t SESSION:WINDOW.PANE C-c

# Send literal text (no Enter)
tmux send-keys -t SESSION:WINDOW.PANE -l 'literal text'
```

Always check what's running in a pane before sending commands:

```bash
# What process is in the pane?
tmux display-message -t SESSION:WINDOW.PANE -p '#{pane_current_command}'

# Read recent pane output (last 50 lines)
tmux capture-pane -t SESSION:WINDOW.PANE -p -S -50
```

## Creating Layouts

```bash
# New session with named window
tmux new-session -d -s SESSION -n WINDOW

# Vertical split (left|right), right pane gets 35% width
tmux split-window -h -t SESSION:WINDOW -l 35%

# Horizontal split (top/bottom), bottom pane gets 30% height
tmux split-window -v -t SESSION:WINDOW.1 -l 30%

# New window in existing session
tmux new-window -t SESSION -n WINDOW_NAME

# Select a pane
tmux select-pane -t SESSION:WINDOW.PANE
```

After a horizontal split (`-h`), the new pane is to the right and gets the
next pane index. After a vertical split (`-v`), the new pane is below.

## The dev-session Layout

The `dev-session` script creates numbered dev windows in the current session:

```bash
dev-session       # creates window "dev-1"
dev-session 2     # creates window "dev-2"
dev-session 3     # creates window "dev-3"
```

Each dev window has a 50/50 split:

```
Session "discord" (or current session), Window "dev-1":
  .0 = left 50%   (claude code)
  .1 = right 50%  (shell)
```

Multiple dev windows can coexist in the same session. The env var
`CLAUDE_TMUX_PANE_N` is set for each dev window (e.g. `CLAUDE_TMUX_PANE_1`),
and the claude instance in each window has `CLAUDE_TMUX_PANE` pointing at its
paired shell pane.

If the user is in a dev-session, you can target panes directly:

```bash
# Run a build in the dev-1 shell pane
tmux send-keys -t discord:dev-1.1 'bzl build //services/api' Enter

# Run tests in dev-2's shell pane
tmux send-keys -t discord:dev-2.1 'bzl test //services/api:test' Enter
```

## Reading Pane Contents

```bash
# Capture last N lines of output from a pane
tmux capture-pane -t SESSION:WINDOW.PANE -p -S -100

# Capture the entire scrollback
tmux capture-pane -t SESSION:WINDOW.PANE -p -S -

# Check if a process is still running
tmux display-message -t SESSION:WINDOW.PANE -p '#{pane_current_command}'
```

Use `capture-pane` to check build output, test results, or service logs
in other panes without switching context.

## Inter-Pane Communication via Buffers

```bash
# Write data that another Claude instance can read
tmux set-buffer -b shared 'some message or data'

# Read a buffer
tmux show-buffer -b shared
```

## Waiting for Commands

When you send a long-running command to another pane, you can poll for
completion:

```bash
# Send the command
tmux send-keys -t discord:dev-1.1 'bzl test //services/api:test' Enter

# Wait and check output (poll with capture-pane)
sleep 5
tmux capture-pane -t discord:dev-1.1 -p -S -20
```

## Common Patterns

**Start a build and monitor it:**
```bash
tmux send-keys -t discord:dev-1.1 'bzl build //services/api 2>&1' Enter
sleep 10
tmux capture-pane -t discord:dev-1.1 -p -S -30
```

**Run tests in one pane, view results:**
```bash
tmux send-keys -t discord:dev-1.1 'bzl test //services/api:test 2>&1' Enter
# ... later ...
tmux capture-pane -t discord:dev-1.1 -p -S -50
```

**Stop whatever is running in a pane and run something new:**
```bash
tmux send-keys -t discord:dev-1.1 C-c
sleep 0.5
tmux send-keys -t discord:dev-1.1 'new command' Enter
```

**Create a temporary scratch session:**
```bash
tmux new-session -d -s scratch -n work
tmux send-keys -t scratch:work 'cd /tmp && some-command' Enter
# ... later ...
tmux kill-session -t scratch
```

## Important Notes

- Always verify the target pane exists before sending keys
- Use `C-c` before sending new commands to panes that might have a running process
- Quote arguments carefully — `send-keys` interprets certain strings as special keys
- Use `-l` flag with `send-keys` if you need to send literal text that might
  contain tmux key names (like "Enter" or "Escape" as literal strings)
- Use `$CLAUDE_TMUX_PANE` when available to target the paired shell pane
