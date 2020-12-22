from libqtile.layout.floating import Floating

from functions import Function

class Colors(object):

    # black     = ["#0d1117", "#0d1117"]
    # grey      = ["#434758", "#434758"]
    # lightgrey = ["#8E9299", "#8E9299"]
    # white     = ["#e5e9f0", "#e5e9f0"]
    # red       = ["#cc6666", "#cc6666"]
    # magenta   = ["#b48ead", "#b48ead"]
    # green     = ["#aebe8c", "#aebe8c"]
    # darkgreen = ["#859900", "#859900"]
    # blue      = ["#51afef", "#51afef"]
    # darkblue  = ["#65737E", "#65737E"]
    # orange    = ["#da8548", "#da8548"]
    # yellow    = ["#fabd2f", "#fabd2f"]

    # Oceanic Next
    black     = ["#0d1117", "#0d1117"]
    grey      = ["#4f5b66", "#4f5b66"]
    lightgrey = ["#a7adba", "#a7adba"]
    white     = ["#d8dee9", "#d8dee9"]
    red       = ["#ec5f67", "#ec5f67"]
    magenta   = ["#c594c5", "#c594c5"]
    green     = ["#99c794", "#99c794"]
    cyan      = ["#5fb3b3", "#5fb3b3"]
    blue      = ["#6699cc", "#6699cc"]
    darkblue  = ["#65737E", "#65737E"]
    orange    = ["#f99157", "#f99157"]
    yellow    = ["#fac863", "#fac863"]

class Fonts(object):

    base = "MesloLGS Nerd Font"
    bold = "MesloLGS Nerd Font Bold"

class Layout_Aesthetics(object):

    layout_theme = {
        "margin":           0,
        "border_width":     1 if Function.screen_count() > 1 else 2,
        "border_focus":     Colors.yellow[0],
        "border_normal":    Colors.grey[0],
        "fontsize":         12 if Function.screen_count() > 1 else 22,
        "section_fontsize": 12 if Function.screen_count() > 1 else 22,
    }

    floating_layout = Floating(
        border_width  = 1 if Function.screen_count() > 1 else 2,
        border_focus  = Colors.yellow[0],
        border_normal = Colors.black[0],
    )

class Widget_Aesthetics(object):

    widget_defaults = dict(
        font       = Fonts.base,
        fontsize   = 12 if Function.screen_count() > 1 else 22,
        padding    = 0,
        foreground = Colors.white,
        background = Colors.black,
    )

class Extension_Aesthetics(object):

    extension_defaults = dict(
        font                = Fonts.base,
        fontsize            = 12,
        dmenu_ignorecase    = True,
        dmenu_prompt        = ">",
        selected_foreground = Colors.blue,
        foreground          = Colors.white,
        selected_background = Colors.grey,
        background          = Colors.black
    )

# vim: tabstop=4 shiftwidth=4 expandtab
