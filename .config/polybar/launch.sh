#!/usr/bin/env bash

SHOW_ON_ALL_DISPLAYS=$1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

xrandr --listactivemonitors | sed 1d | while read -r entry
do
  set -- $entry
  STATUS=$2
  X_RES=$(echo "$3"|awk -F'/' '{split($0, a, "/"); print a[1]}')
  MONITOR=$4

  [[ $STATUS =~ .*"*".* ]] && BAR="main" || BAR="secondary"
  [[ $X_RES -ge 3000 ]] && BASE="bar/hidpi" || BASE="bar/lodpi"


  if [ -z "$SHOW_ON_ALL_DISPLAYS" ]; then
    if [ "$BAR" == "main" ]; then
      BAR_MONITOR=$MONITOR BAR_BASE=$BASE polybar $BAR -c ~/.config/polybar/config &
    fi
  else
    BAR_MONITOR=$MONITOR BAR_BASE=$BASE polybar $BAR -c ~/.config/polybar/config &
  fi
done
