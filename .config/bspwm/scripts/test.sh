#!/bin/sh

# Get wids of windows on the current desktop
function get_windows {
  bspc query -N -d -n .window
}

# Get children of tabbed
function get_clients {
  wid=$(get_tabbed_wid)
  if [ ! -z "$wid" ]; then
    echo $(xwininfo -id $wid -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p')
  fi
}

# Get wid of tabbed window
function get_tabbed_wid {
  wids=( $(get_windows) )
  tabbed=

  for i in ${!wids[@]}; do
    # Try to find out if tabbed is running
    wm_class=$(xprop -id "${wids[i]}" WM_CLASS | cut -d" " -f4- | sed 's/"//g' )
    if [ "tabbed" == $wm_class ]; then
      tabbed=${wids[i]}
    fi
  done

  echo $tabbed
}

# Spawn new instance of tabbed if it's not running
function spawn_tabbed {
  tabbed=$(get_tabbed_wid)

  if [ -z "$tabbed" ]; then
    tabbed=$(tabbed -kcd)
  fi

  echo $tabbed
}

# echo "tabbed: $(get_tabbed_wid)"
# echo "new tabbed: $(spawn_tabbed)"
echo "clients: $(get_clients)"

# [[ $(xprop -id "$active" WM_CLASS | cut -d" " -f4- | sed 's/"//g') == "tabbed" ]] && xdotool key --window "$active" ctrl+shift+q || bspc node -c

