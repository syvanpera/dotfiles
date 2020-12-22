from os.path import expanduser

from libqtile.config import Key, Drag, Click
from libqtile.command import lazy
from libqtile.utils import guess_terminal

from functions import Function

class Keys(object):

    ##### GENERAL KEYBINDINGS #####

    def init_keys(self):

        terminal = guess_terminal()

        # Key alias
        mod    = "mod1"
        modalt = "mod4"
        altgr  = "mod5"

        return [
            # On root
            Key([mod, "shift"], "r",
                lazy.restart()),                            # Restart Qtile
            Key([mod, "shift"], "q",
                lazy.shutdown()),                           # Shutdown Qtile

            # Key([modalt], "r", lazy.spawncmd()),            # Launch Qtile prompt

            # On window
            # Key([mod], "Home",
            #     lazy.window.bring_to_front()),              # Bring window to front

            # Key([mod], "End",
            #     lazy.group[""].toscreen()),                 # Go to minimized windows gruop
            # Key([mod, "shift"], "End",
            #     lazy.window.togroup("")),                   # Move to minimized windows group
            # Key([mod, "control"], "End",
            #     lazy.window.togroup(""),
            #     lazy.group[""].toscreen()),                 # Move with to minimized windows group
            # Key([mod, alt], "End",
            #     lazy.window.toggle_minimize()),           # Toogle minimize

            Key([mod], "h", lazy.layout.left()),            # Switch to window on left
            Key([mod], "l", lazy.layout.right()),           # Switch to window on right
            Key([mod], "j", lazy.layout.down()),            # Switch to window below
            Key([mod], "k", lazy.layout.up()),              # Switch to window above

            Key([mod, "shift"], "j",
                lazy.layout.shuffle_down()),                # Move windows down in current stack
            Key([mod, "shift"], "k",
                lazy.layout.shuffle_up()),                  # Move windows up in current stack
            Key([mod, "shift"], "h",
                lazy.layout.swap_left()),                   # Move window to the left
            Key([mod, "shift"], "l",
                lazy.layout.swap_right()),                  # Move window to the right

            # Key([mod, "control"], "j",
            #     lazy.layout.client_to_previous()),          # Move window to previous stack side
            # Key([mod, "control"], "k",
            #     lazy.layout.client_to_next()),              # Move window to next stack side

            Key([mod], "Tab",
                lazy.group.next_window()),                  # Switch focus to other window
            Key([mod, "shift"], "Tab",
                lazy.group.prev_window()),                  # Switch focus to other window

            # Key([mod, altgr], "Tab",
            #     lazy.group.next_window(),
            #     lazy.window.bring_to_front()),              # Switch focus to other window + front
            # Key([mod, altgr, "shift"], "Tab",
            #     lazy.group.prev_window(),
            #     lazy.window.bring_to_front()),              # Switch focus to other window + front

            Key([mod], "q",
                lazy.window.kill()),                        # Kill active window
            # Key([mod, alt], "w",
            #     lazy.spawn("xkill")),                       # Terminate program
            # Key([mod, "shift"], "w",
            #     Function.kill_all_windows_minus_current()), # Kill all windows except current
            # Key([mod, "control"], "w",
            #     Function.kill_all_windows()),               # Kill all windows

            Key([modalt], "f",
                lazy.window.toggle_floating()),             # Toggle floating
            Key([modalt, "shift"], "f",
                lazy.window.toggle_fullscreen()),           # Toggle fullscreen

            # On layout
            Key([mod], "m",
                lazy.layout.swap_main()),                   # Swap current window to main pane (Xmonad)

            # Key([mod], "m",
            #     lazy.layout.next()),                        # Move focus to another stack (Stack)

            Key([mod, "control", "shift"], "h",
                    lazy.layout.shrink()),                    # Shrink size of window (Xmonad)
            Key([mod, "control", "shift"], "l",
                    lazy.layout.grow()),                      # Grow size of window (Xmonad)

            Key([modalt], "n",
                lazy.layout.normalize()),                   # Restore all windows to default size ratios
            Key([modalt], "m",
                lazy.layout.maximize()),                    # Toggle a window between min and max sizes

            # Key([mod, "shift"], "space",
            #     lazy.layout.rotate(),                       # Swap panes of split stack (Stack)
            #     lazy.layout.flip()),                        # Switch side main pane occupies (Xmonad)

            # Key([mod, "shift"], "Return",
            #     lazy.layout.toggle_split()),                # Toggle between split and unsplit (Stack)

            Key([modalt], "space",
                lazy.prev_layout()),                          # Toggle through layouts
            Key([modalt, "shift"], "space",
                lazy.next_layout()),                          # Toggle through layouts

            # On group
            # Key([mod], "z",
            #     lazy.screen.togglegroup()),                 # Move to previous visited group
            # Key([mod, "shift"], "i",
            #     lazy.next_urgent()),                        # Move to next urgent group

            # Key([mod], "Left",
            #     lazy.screen.prev_group()),                  # Move to previous group
            # Key([mod], "Right",
            #     lazy.screen.next_group()),                  # Move to next group

            # Key([mod, "shift"], "Left",
            #     Function.window_to_prev_group()),           # Move window to previous group
            # Key([mod, "shift"], "Right",
            #     Function.window_to_next_group()),           # Move window to next group

            # Key([mod, "control"], "Left",
            #     Function.window_to_prev_group(),
            #     lazy.screen.prev_group()),                  # Move with window to previous group
            # Key([mod, "control"], "Right",
            #     Function.window_to_next_group(),
            #     lazy.screen.next_group()),                  # Move with window to next group

            # On screen
            Key([modalt], "1",
                lazy.to_screen(0)),                         # Switch to screen 0
            Key([modalt], "2",
                lazy.to_screen(2)),                         # Switch to screen 2
            Key([modalt], "3",
                lazy.to_screen(1)),                         # Switch to screen 1
            Key([modalt], "h",
                lazy.to_screen(0)),                         # Switch to screen 0
            Key([modalt], "k",
                lazy.to_screen(0)),                         # Switch to screen 0
            Key([modalt], "j",
                lazy.to_screen(1)),                         # Switch to screen 1
            Key([modalt], "l",
                lazy.to_screen(2)),                         # Switch to screen 2

            # Hardware keys
            Key([], "XF86AudioRaiseVolume",
                lazy.spawn("amixer -D pulse sset Master 5%+")),  # Volume up
            Key([], "XF86AudioLowerVolume",
                lazy.spawn("amixer -D pulse sset Master 5%-")),  # Volume down
            Key([], "XF86AudioMute",
                lazy.spawn("amixer -c 0 -q set Master toggle")), # Volume mute

            Key([], "XF86MonBrightnessUp",                       # Brightness up
                lazy.spawn("brightnessctl set 5%+")),
            Key([], "XF86MonBrightnessDown",                     # Brightness down
                lazy.spawn("brightnessctl set 5%-")),

            # Launchers
            Key([mod],              "Return", lazy.spawn(terminal)),
            Key([mod, "shift"],     "Return", lazy.spawn(terminal + " -e tmux")),
            Key([modalt,],          "r",      lazy.spawn(terminal + " -e ranger")),
            Key([modalt],           "e",      lazy.spawn("emacs")),

            Key([mod],             "space",   lazy.spawn(expanduser("~/.config/rofi/scripts/launcher"))),
            Key([mod],             "0",       lazy.spawn(expanduser("~/.config/rofi/scripts/powermenu"))),
            Key([mod, "shift"],    "w",       lazy.spawn(expanduser("~/.config/rofi/scripts/windows"))),
            Key([mod, "shift"],    "0",       lazy.spawn(expanduser("~/.config/rofi/scripts/calc"))),
            Key([mod, "shift"],    "n",       lazy.spawn(expanduser("~/.config/rofi/scripts/networkmanager-dmenu"))),
            Key([mod, "shift"],    "c",       lazy.spawn(expanduser("~/.config/rofi/scripts/clipboard"))),
            Key([mod, "shift"],    "b",       lazy.spawn(expanduser("~/.config/rofi/scripts/bwmenu"))),
            Key([mod, "shift"],    "space",   lazy.spawn(expanduser("~/.config/rofi/scripts/filebrowser"))),
            Key([modalt, "shift"], "s",     lazy.spawn("gnome-screenshot --interactive")),
        ]

    ##### GROUPS KEYBINDINGS #####

    def init_group_keybindings(self, groups):

        # Key alias
        mod    = "mod1"
        modalt = "mod4"
        altgr  = "mod5"

        group_keys  = []
        group_keys += [str(i) for i in range(1, 10)]
        group_keys += ["0", "minus", "equal"]

        keys = []

        # For all, less the group for "minimized" windows
        for i, group in enumerate(groups[0:-1]):
            # Switch to another group
            keys.append(Key([mod], group_keys[i], lazy.to_screen(group.screen_affinity), lazy.group[group.name].toscreen(screen=group.screen_affinity, toggle=False)))

            # Move current window to another group
            keys.append(Key([mod, "shift"], group_keys[i], lazy.window.togroup(group.name)))

            # Move with current window to another group
            # keys.append(Key([mod, "control"], group_keys[i],
            #     lazy.window.togroup(group.name),
            #     lazy.group[group.name].toscreen()))

        return keys

class Mouses(object):

    ##### MOUSE #####

    def init_mouse(self):

        # Key alias
        mod    = "mod1"
        modalt = "mod4"
        altgr  = "mod5"

        return [
            # Move floating windows
            Drag(
                [mod], "Button1", lazy.window.set_position_floating(),
                start = lazy.window.get_position()
            ),

            # Resize floating windows
            Drag(
                [mod], "Button3", lazy.window.set_size_floating(),
                start = lazy.window.get_size()
            ),

            # Bring to front
            Click([mod], "Button2", lazy.window.bring_to_front())
        ]

# vim: tabstop=4 shiftwidth=4 expandtab
