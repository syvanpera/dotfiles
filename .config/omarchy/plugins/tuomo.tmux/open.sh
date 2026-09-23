#!/bin/bash

# Open a tmux session in the default terminal, via sesh.
#
# Usage: open.sh <kind> <target>
#   kind    tmux   — target is a live tmux session name
#           config — target is the name of a session defined in sesh's config
#           path   — target is a directory to open as a session
#           create — target is text the user typed, either a path or a name
#
# A terminal already attached to that session is focused instead of spawning a
# duplicate: a second client on one session forces both to the smaller window's
# size, which is rarely what the user meant by picking it again.

set -euo pipefail

kind=${1:?usage: open.sh <kind> <target>}
target=${2:?usage: open.sh <kind> <target>}

# Typed text is a directory whenever one exists at that path — sesh takes it
# from there. Otherwise it is a bare session name, which sesh refuses, so tmux
# has to create the session itself.
if [[ $kind == create ]]; then
  expanded=${target/#\~/$HOME}
  if [[ -d $expanded ]]; then
    kind=path
    target=$expanded
  fi
fi

# The window is tagged with the row that opened it rather than with the session
# name, because a directory's session name is sesh's to decide and is not known
# until the session exists.
app_id="org.omarchy.tmux-$(printf '%s' "$target" | tr -c 'A-Za-z0-9_-' '_')"

focus() {
  hyprctl dispatch "hl.dsp.focus({ window = \"address:$1\" })" >/dev/null 2>&1 ||
    hyprctl dispatch focuswindow "address:$1"
}

# Which tmux session a directory belongs to is a question sesh answers by name,
# using a git-aware rule this script would rather not reimplement. Matching on
# the session's working directory needs no such guess.
session_for_path() {
  local wanted line path name
  wanted=$(realpath -m -- "$1" 2>/dev/null) || return 1

  while IFS= read -r line; do
    path=${line%%$'\t'*}
    name=${line#*$'\t'}
    [[ -n $name ]] || continue
    [[ $(realpath -m -- "$path" 2>/dev/null) == "$wanted" ]] || continue
    printf '%s' "$name"
    return 0
  done < <(tmux list-sessions -F '#{session_path}'$'\t''#{session_name}' 2>/dev/null)

  return 1
}

# The terminal hosting a tmux client is that client's parent process, so the
# window can be found by walking up from the client pid until a pid matches a
# Hyprland window. This finds terminals we did not spawn ourselves — a session
# attached from a plain terminal is focused rather than attached twice.
attached_window() {
  local session=$1 clients windows pid depth address
  clients=$(tmux list-clients -t "=$session" -F '#{client_pid}' 2>/dev/null) || return 1
  [[ -n $clients ]] || return 1

  windows=$(hyprctl clients -j 2>/dev/null) || return 1

  while read -r pid; do
    [[ -n $pid ]] || continue
    for ((depth = 0; depth < 8; depth++)); do
      address=$(jq -r --argjson pid "$pid" \
        'first(.[] | select(.pid == $pid) | .address) // empty' <<<"$windows")
      if [[ -n $address ]]; then
        printf '%s' "$address"
        return 0
      fi
      pid=$(awk '/^PPid:/ { print $2 }' "/proc/$pid/status" 2>/dev/null) || return 1
      [[ -n $pid && $pid != 0 ]] || break
    done
  done <<<"$clients"

  return 1
}

case $kind in
  # A configured session takes its tmux name from the config entry, so like a
  # live session it is already addressed by the name it will have.
  tmux | config) session=$target ;;
  path)          session=$(session_for_path "$target" || true) ;;
  create)        session=$target ;;
  *)
    echo "open.sh: unknown kind '$kind'" >&2
    exit 1
    ;;
esac

if [[ -n ${session:-} ]] && address=$(attached_window "$session"); then
  focus "$address"
  exit 0
fi

# Nothing is attached yet, but a terminal for this row may still be on its way
# up from an earlier pick. The app id catches that window before it has a tmux
# client to walk up from.
address=$(hyprctl clients -j 2>/dev/null |
  jq -r --arg id "$app_id" 'first(.[] | select(.class == $id) | .address) // empty')

if [[ -n $address ]]; then
  focus "$address"
  exit 0
fi

args=(--app-id="$app_id")

if [[ $kind == create ]]; then
  # A new session's panes start in the terminal's directory. Inherit the active
  # terminal's, the way omarchy-launch-terminal does. Moot for `sesh connect`,
  # which sets the directory itself from the session or path.
  if dir=$(omarchy-cmd-terminal-cwd 2>/dev/null) && [[ -d $dir ]]; then
    args+=(--dir="$dir")
  fi
  command=(tmux new-session -A -s "$target")
else
  command=(sesh connect -- "$target")
fi

# The new terminal must not look like it is inside tmux: with TMUX set in the
# environment, `sesh connect` switches the invoking client to the session
# instead of attaching in the window just opened, which leaves that window
# empty. The picker itself never has it set, but a shell inside tmux does.
exec setsid env -u TMUX -u TMUX_PANE uwsm-app -- \
  xdg-terminal-exec "${args[@]}" -e "${command[@]}"
