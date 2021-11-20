#!/usr/bin/env bash

MONITOR="eDP1"
BASE="bar/lodpi"
BAR="main"

launch_bar() {
	if [[ ! $(pidof polybar) ]]; then
		BAR_MONITOR=$MONITOR BAR_BASE=$BASE polybar $BAR -c ~/.config/polybar/config &
	else
		polybar-msg cmd restart
	fi
}

launch_bar
