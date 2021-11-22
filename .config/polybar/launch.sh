#!/usr/bin/env bash

PRIMARY=$(xrandr --listactivemonitors | grep '\+\*' | sed 's/.*\+\*\([^ ]*\).*/\1/g')

BASE="bar/lodpi"
BAR="main"

launch_bar() {
	if [[ ! $(pidof polybar) ]]; then
		BAR_MONITOR=$PRIMARY BAR_BASE=$BASE polybar $BAR -c ~/.config/polybar/config &
	else
		polybar-msg cmd restart
	fi
}

launch_bar
