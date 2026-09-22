#!/usr/bin/env bash

# Pass the tmux pane current path as the first argument, or default to current directory
TARGET_PATH="${1:-$PWD}"

# Get the origin URL safely
URL=$(git -C "$TARGET_PATH" remote get-url origin 2>/dev/null || true)

if [ -n "$URL" ]; then
    # Strip optional .git suffix and extract repo name
    REPO_NAME=$(basename "${URL%.git}")
    echo " $REPO_NAME ·"
else
    echo ""
fi
