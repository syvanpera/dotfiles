#!/bin/sh
setxkbmap -option 'caps:ctrl_modifier' && killall xcape 2>/dev/null ; xcape -e 'Caps_Lock=Escape' &
