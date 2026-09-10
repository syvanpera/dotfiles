#!/bin/bash

# Open a herdr session in the default terminal: attach to it when it already
# exists, create it when it does not — `herdr --session` covers both. A
# terminal already attached to that session is focused instead of spawning a
# duplicate, since herdr sessions are persistent and a second client is
# rarely what you want.

set -euo pipefail

session=${1:?usage: open.sh <session-name>}
app_id="org.omarchy.herdr-$session"

address=$(hyprctl clients -j 2>/dev/null |
  jq -r --arg id "$app_id" 'first(.[] | select(.class == $id) | .address) // empty')

if [[ -n $address ]]; then
  hyprctl dispatch "hl.dsp.focus({ window = \"address:$address\" })" >/dev/null 2>&1 ||
    hyprctl dispatch focuswindow "address:$address"
  exit 0
fi

# herdr takes no cwd flag, so the terminal's directory decides where a new
# session's panes start. Inherit the active terminal's, the way
# omarchy-launch-terminal does. Moot when attaching an existing session.
args=(--app-id="$app_id")
if dir=$(omarchy-cmd-terminal-cwd 2>/dev/null) && [[ -d $dir ]]; then
  args+=(--dir="$dir")
fi

exec setsid uwsm-app -- xdg-terminal-exec "${args[@]}" -e herdr --session "$session"
