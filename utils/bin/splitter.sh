#!/usr/bin/env bash
# Usage: ./up.sh
set -euo pipefail
SESSION_ID="${SESSION_ID:-splittersh}"
LEFT_CMD="${LEFT_CMD:-yes 'set_LEFT_CMD plz'}"
RIGHT_CMD="${RIGHT_CMD:-yes 'set RIGHT_CMD plz'}"

tmux kill-session -t "$SESSION_ID" || true
tmux new-session -d -s "$SESSION_ID" "$LEFT_CMD"
tmux split-window -v -t "$SESSION_ID" "$RIGHT_CMD"
tmux select-pane -t "$SESSION_ID":0.0
tmux attach -t "$SESSION_ID"