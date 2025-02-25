#!/bin/bash

# Get session name from argument or use default
SESSION_NAME=${1:-default}

# Check for an existing tmux session
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Attaching to existing tmux session: $SESSION_NAME"
    tmux attach-session -t "$SESSION_NAME"
else
    echo "No active tmux session found. Creating a new session."
    tmux new-session -s "$SESSION_NAME"
fi

exit 0
