from os import environ

from libqtile.config import ScratchPad, DropDown, Key
from libqtile.command import lazy
from libqtile.utils import guess_terminal

class Scratchpad(object):

    def init_scratchpad(self):

        terminal = guess_terminal()

        # Configuration
        height             = 0.5
        y_position         = 0.2
        warp_pointer       = False
        on_focus_lost_hide = True
        opacity            = 0.8

        return [
            ScratchPad("SPD",
                dropdowns = [
                    # Drop down terminal with tmux session
                    DropDown("term",
                        terminal + " -e tmux new-session -A -s 'dd'",
                        opacity            = opacity,
                        y                  = y_position,
                        height             = height,
                        on_focus_lost_hide = on_focus_lost_hide,
                        warp_pointer       = warp_pointer),

                    # Another terminal exclusively for music player
                    DropDown("music",
                        terminal + " -e ncmpcpp",
                        opacity = opacity,
                        y = y_position,
                        height = height,
                        on_focus_lost_hide = on_focus_lost_hide,
                        warp_pointer = warp_pointer),

                    # Another terminal exclusively for qshell
                    DropDown("qshell",
                        terminal + " -e qshell",
                        opacity            = opacity,
                        y                  = y_position,
                        height             = height,
                        on_focus_lost_hide = on_focus_lost_hide,
                        warp_pointer       = warp_pointer)
                ]
            ),
        ]

class DropDown_Keys(object):

    ##### DROPDOWNS KEYBINDINGS #####

    def init_dropdown_keybindings(self):

        # Key alias
        mod    = "mod1"
        modalt = "mod4"
        altgr  = "mod5"

        return [
            Key([modalt], "comma",
                lazy.group["SPD"].dropdown_toggle("term")),
            Key([modalt], "period",
                lazy.group["SPD"].dropdown_toggle("qshell")),
            Key([modalt], "m",
                lazy.group["SPD"].dropdown_toggle("music")),
        ]

# vim: tabstop=4 shiftwidth=4 expandtab
