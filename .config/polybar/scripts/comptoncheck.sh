#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x picom)" ]; then
            notify-send "picom killed"
            pkill picom
        else
            notify-send "picom started"
            picom # -cC --config ~/.config/compton/config
        fi
        ;;
    *)
        if [ "$(pgrep -x picom)" ]; then
            echo "%{F#b5bd68}%{F-}"
        else
            echo "%{F#cc6666}%{F-}"
        fi
        ;;
  esac
