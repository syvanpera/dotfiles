#!/bin/bash
_getHeader "$name" "$author"
setsid $HOME/dotfiles/.config/hypr/scripts/wallpaper.sh select 1>/dev/null 2>&1 &
_goBack
