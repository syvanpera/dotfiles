#!/bin/env bash

ACTIVE_MON_IDX=$(xrandr --listactivemonitors | grep '\+\*' | sed 's/ *\([^:]*\).*/\1/g')

# If the process doesn't exists, start one in background
run() {
  if ! pgrep $1 ; then
    $@ &
  fi
}

# Just as the above, but if the process exists, restart it
run-or-restart() {
  if ! pgrep $1 ; then
    $@ &
  else
    pkill $1
    while pgrep -u $UID -x $1 >/dev/null; do sleep 1; done
    $@ &
  fi
}

run picom --config ~/.config/picom.conf
run clipmenud

pkill trayer ; trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor $ACTIVE_MON_IDX --transparent true --alpha 0 --tint 0x0f111b  --height 24 &

# pkill sxhkd ; sxhkd -c $HOME/.config/sxhkd/sxhkdrc &

# ~/.config/polybar/launch.sh 1

~/.fehbg &
