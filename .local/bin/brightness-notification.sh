#!/bin/bash

# Get the brightness percentage:
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness);
BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness);
PCT=$(echo $BRIGHTNESS $MAX_BRIGHTNESS  | awk '{printf "%4.0f\n",($1/$2)*100}' | tr -d '[:space:]')

# Round the brightness percentage:
LC_ALL=C

PROGRESS=$(~/.local/bin/getprogressstring.sh 10 "█" "░" $PCT)

# Send the notification with the icon:
~/.local/bin/notify-send.sh "Brightness ${PCT}%" \
    --replace=101 \
    -t 2000 \
    --icon ~/.local/share/icons/brightness-icon.png \
    -h int:value:${PCT} \
    -h string:synchronous:brightness-change
