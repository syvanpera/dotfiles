#!/bin/sh

# Get wids of windows on the current desktop
function get_windows {
  bspc query -N -d -n .window
}

# Get wid of root window
function get_root_wid {
	xwininfo -root | awk '/Window id:/{print $4}'
}

# Get children of tabbed
function get_clients {
	id=$1
	# xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).* \([0-9|x|+]\+ \+[0-9|+]\+\)$/\1 \2/p'
	xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
function get_class {
	id=$1
	xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
}

function tabify_toggle_all {
  active_wid=$(bspc query -N -d -n)
  active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
  if [ "tabbed" == "$active_class" ]; then
    clients=$(get_clients "$active_wid")
    root_wid=$(get_root_wid)

    for wid in $clients; do
		  xdotool windowreparent $wid $root_wid
    done
  else
    wids=( $(get_windows) )
    tabbed=""
    reparent=()

    for i in ${!wids[@]}; do
      # Try to find out if tabbed is running
      wm_class=$(xprop -id "${wids[i]}" WM_CLASS | cut -d" " -f4- | sed 's/"//g' )
      if [ "tabbed" == $wm_class ]; then
        tabbed=${wids[i]}
      else
        reparent+=(${wids[i]})
      fi
    done

    if [ -z "$tabbed" ]; then
      tabbed=$(tabbed -kcd)
    fi

    if [ -z "$tabbed" ]; then
      echo "Failed..."
    else
      for wid in ${reparent[@]}; do
        xdotool windowreparent "$wid" "$tabbed"
      done
    fi
  fi
}

function tabify_toggle_active {
  active_wid=$(bspc query -N -d -n)
  active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
  if [ "tabbed" == "$active_class" ]; then
    tabify_change_layout "tiled"
  else
    wids=( $(get_windows) )
    tabbed=""

    for i in ${!wids[@]}; do
      # Try to find out if tabbed is running
      wm_class=$(xprop -id "${wids[i]}" WM_CLASS | cut -d" " -f4- | sed 's/"//g' )
      if [ "tabbed" == $wm_class ]; then
        tabbed=${wids[i]}
      fi
    done

    if [ -z "$tabbed" ]; then
      tabbed=$(tabbed -kcd)
    fi

    if [ -z "$tabbed" ]; then
      echo "Failed..."
    else
      xdotool windowreparent "$active_wid" "$tabbed"
    fi
  fi
}

function tabify_close_active {
  active_wid=$(bspc query -N -d -n)
  active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
  if [ "tabbed" == "$active_class" ]; then
    # Close the tab
    xdotool key --window "$active_wid" ctrl+shift+q
  else
    # Let bspwm handle this
    bspc node -c
  fi
}

function tabify_focus {
	dir=$1

  active_wid=$(bspc query -N -d -n)
  active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
  if [ "tabbed" == "$active_class" ]; then
    clients_before=$(get_clients "$active_wid")
    # Focus the tab in the give direction
    case $dir in
      west)
        xdotool key --window "$active_wid" ctrl+shift+h
        ;;
      east)
        xdotool key --window "$active_wid" ctrl+shift+l
        ;;
    esac
    clients_after=$(get_clients "$active_wid")
    if [ "$clients_before" == "$clients_after" ]; then
      # If there was no change in focus, send the command to bspwm instead
      bspc node -f $dir
    fi
  else
    # Let bspwm handle this
    bspc node -f $dir
  fi
}

function tabify_move {
	dir=$1

  active_wid=$(bspc query -N -d -n)
  active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
  if [ "tabbed" == "$active_class" ]; then
    clients_before=$(get_clients "$active_wid")
    # Focus the tab in the give direction
    case $dir in
      west)
        xdotool key --window "$active_wid" ctrl+shift+j
        ;;
      east)
        xdotool key --window "$active_wid" ctrl+shift+k
        ;;
    esac
    clients_after=$(get_clients "$active_wid")
    if [ "$clients_before" == "$clients_after" ]; then
      # If there was no change in tab order, send the command to bspwm instead
      bspc node -s $dir --follow
    fi
  else
    # Let bspwm handle this
    bspc node -s $dir --follow
  fi
}

function tabify_change_layout {
	layout=$1

  if [ "tiled" == "$layout" ]; then
    active_wid=$(bspc query -N -d -n)
    active_class=$(xprop -id "$active_wid" WM_CLASS | cut -d" " -f4- | sed 's/"//g')
    if [ "tabbed" == "$active_class" ]; then
      active_tab=$(get_clients "$active_wid" | head -n1)
		  xdotool windowreparent $active_tab $(get_root_wid)
      echo "Need to reparent"
    fi
  fi
  bspc node -t "$layout"
}

if [ $# -gt 0 ]; then
  cmd=$1; shift

  case $cmd in
    toggle_active)
      tabify_toggle_active
      ;;
    toggle_all)
      tabify_toggle_all
      ;;
    focus)
      tabify_focus $1
      ;;
    move)
      tabify_move $1
      ;;
    close)
      tabify_close_active
      ;;
    layout)
      tabify_change_layout $1
      ;;
  esac
else
  echo "No command given"
fi

# case $cmd in
#   close)
