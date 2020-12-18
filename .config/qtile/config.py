import os
import socket

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger

from typing import List  # noqa: F401


from Xlib import X, display
from Xlib.ext import randr

from custom_battery import CustomBattery

d = display.Display()
s = d.screen()
r = s.root
res = r.xrandr_get_screen_resources()._data

num_screens = 0
for output in res['outputs']:
    mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
    if mon['num_preferred']:
        num_screens += 1

# Load script to read colors from pywal
# import pywal_colors
# colors = pywal_colors.colors

colors = [["#0c131f", "#0c131f"], # panel background
          ["#434758", "#434758"], # background for current screen tab
          ["#e5e9f0", "#e5e9f0"], # font color for group names
          ["#51afef", "#51afef"], # border line color for current tab
          ["#68809a", "#68809a"], # border line color for other tab and odd widgets
          ["#3b84c0", "#3b84c0"], # color for the even widgets
          ["#fabd2f", "#fabd2f"],
          ["#cc6666", "#cc6666"]] # window name

# ### COLORS ###
# colors = ["003b4c",     # Background
#         "66a5ad",       # Current group
#         "ececec",       # Highlight Text
#         "999999",       # Dark Text
#         "73b8bf",       # Widget 1 Color
#         "50a5af",       # Widget 2 Color
#         "40848c",       # Widget 3 Color
#         "306369",       # Widget 4 Color
#         "204246",       # Widget 5 Color
#         "102123",       # Widget 6 Color
#         ]

mod  = "mod1"
mod4 = "mod4"
terminal = guess_terminal()

home = os.path.expanduser('~')

keys = [Key([mod, "shift"],   "r",      lazy.restart()),
        Key([mod, "control"], "q",      lazy.shutdown()),
        Key([mod],            "q",      lazy.window.kill()),
        Key([mod4],           "r",      lazy.spawncmd()),

        Key([mod],            "Return", lazy.spawn(terminal)),
        Key([mod, "shift"],   "Return", lazy.spawn(terminal + " -e tmux")),
        Key([mod4],           "e",      lazy.spawn("emacs")),

        # Launcher bindings
        Key([mod],           "space",   lazy.spawn(home + "/.config/rofi/scripts/launcher")),
        Key([mod],           "0",       lazy.spawn(home + "/.config/rofi/scripts/powermenu")),
        Key([mod, "shift"],  "w",       lazy.spawn(home + "/.config/rofi/scripts/windows")),
        Key([mod, "shift"],  "0",       lazy.spawn(home + "/.config/rofi/scripts/calc")),
        Key([mod, "shift"],  "n",       lazy.spawn(home + "/.config/rofi/scripts/networkmanager-dmenu")),
        Key([mod, "shift"],  "c",       lazy.spawn(home + "/.config/rofi/scripts/clipboard")),
        Key([mod, "shift"],  "b",       lazy.spawn(home + "/.config/rofi/scripts/bwmenu")),
        Key([mod, "shift"],  "space",   lazy.spawn(home + "/.config/rofi/scripts/filebrowser")),
        Key([mod4, "shift"], "s",       lazy.spawn("gnome-screenshot --interactive")),

        Key([mod],           "h",       lazy.layout.left()),
        Key([mod],           "l",       lazy.layout.right()),
        Key([mod],           "j",       lazy.layout.down()),
        Key([mod],           "k",       lazy.layout.up()),

        Key([mod, "control", "shift"], "l", lazy.layout.grow_right(), lazy.layout.grow()),
        Key([mod, "control", "shift"], "h", lazy.layout.grow_left(), lazy.layout.shrink()),
        Key([mod, "control", "shift"], "j", lazy.layout.grow_down(), lazy.layout.shrink()),
        Key([mod, "control", "shift"], "k", lazy.layout.grow_up(), lazy.layout.grow()),

        Key([mod],           "Tab",     lazy.layout.next()),
        Key([mod, "shift"],  "Tab",     lazy.layout.previous()),

        Key([mod4],          "n",       lazy.layout.reset()),
        Key([mod4],          "z",       lazy.layout.maximize()),

        Key([mod],            "plus",   lazy.layout.grow()),
        Key([mod],            "minus",  lazy.layout.shrink()),

        Key([mod, "shift"],   "k",      lazy.layout.shuffle_up()),
        Key([mod, "shift"],   "j",      lazy.layout.shuffle_down()),
        Key([mod, "shift"],   "h",      lazy.layout.swap_left()),
        Key([mod, "shift"],   "l",      lazy.layout.swap_right()),

        # Toggle between different layouts
        Key([mod4],          "space",   lazy.next_layout()),

        # Change to other screen(s)
        Key([mod4],          "1",       lazy.to_screen(0)),
        Key([mod4],          "2",       lazy.to_screen(2)),
        Key([mod4],          "3",       lazy.to_screen(1)),
        Key([mod4],          "h",       lazy.to_screen(0)),
        Key([mod4],          "l",       lazy.to_screen(2)),
        Key([mod4],          "j",       lazy.to_screen(1)),

        # Change the volume if our keyboard has keys
        Key([], "XF86AudioRaiseVolume",  lazy.spawn("amixer -D pulse sset Master 5%+")),
        Key([], "XF86AudioLowerVolume",  lazy.spawn("amixer -D pulse sset Master 5%-")),
        Key([], "XF86AudioMute",         lazy.spawn("amixer -c 0 -q set Master toggle")),

        # Change screen brightness
        Key([], "XF86MonBrightnessUp",   lazy.spawn("brightnessctl set 5%+")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
        ]

if num_screens > 1:
    group_names=[("term",{'layout': 'monadtall', 'spawn':'alacritty -e tmux'}),
                 ("code",{'layout': 'monadtall'}),
                 ("www", {'layout': 'max', 'spawn':'firefox'}),
                 ("misc",{'layout': 'monadtall'}),
                 ("com", {'layout': 'monadtall'}),
                 ("xxx", {'layout': 'monadtall'})]
else:
    group_names=[("term",{'layout': 'monadtall', 'spawn':'alacritty -e tmux'}),
                 ("www", {'layout': 'max', 'spawn':'firefox'}),
                 ("misc",{'layout': 'monadtall'}),
                 ("com", {'layout': 'monadtall'}),
                 ("xxx", {'layout': 'monadtall'})]


groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {"border_width": 1 if num_screens > 1 else 2,
                "margin": 5,
                "border_focus": colors[3][0],
                "border_normal": colors[1][0],
                "bg_color": colors[0][0],
                "active_bg": colors[5][0],
                "active_fg": colors[2][0],
                "fontsize": 12,
                "previous_on_rm": True}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
    layout.TreeTab(**layout_theme),

    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font='MesloLGS Nerd Font',
    fontsize=12 if num_screens > 1 else 22,
    padding=3,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()

angle_font_size = 65 if num_screens > 1 else 100

def init_widgets_list():
    task_list = widget.WindowName(
            foreground=colors[6],
            padding=0,
            for_current_screen=True,
            )
    # task_list = widget.WindowName(
    #         foreground=colors[6],
    #         padding=0,
    #         for_current_screen=True,
    #         ) if num_screens > 1 else widget.TaskList(
    #                 foreground=colors[2],
    #                 border=colors[3],
    #                 borderwidth=1,
    #                 padding_x=10,
    #                 rounded=True,
    #                 max_title_width=None,
    #                 highlight_method="border",
    #                 )
    widgets_list = [
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[2],
            padding=10,
            scale=0.7
        ),
        widget.GroupBox(
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=10,
            borderwidth=3,
            active=colors[2],
            inactive=colors[2],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[3],
            this_screen_border=colors[4],
            other_current_screen_border=colors[3],
            other_screen_border=colors[1],
            foreground=colors[2],
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=colors[2],
        ),
        widget.Prompt(
            prompt=prompt,
            padding=10,
            foreground=colors[3],
            background=colors[1]
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=colors[2],
        ),
        task_list,
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.DF(
            foreground=colors[2],
            fmt='  {}',
            format='{uf}{m}',
            partition='/',
            visible_on_warn=False,
        ),
        widget.DF(
            foreground=colors[2],
            fmt=' {}',
            format='{uf}{m}',
            partition='/home',
            visible_on_warn=False,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.CPU(
            foreground=colors[2],
            padding=5,
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(terminal + ' -e ytop')},
            fmt=' {}',
            format='{load_percent}%',
            update_interval=2.0,
        ),
        widget.ThermalSensor(
            foreground=colors[2],
            threshold=90,
            padding=5,
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(terminal + ' -e ytop')},
            fmt=' {}',
            update_interval=2.0,
        ),
        widget.Memory(
            foreground=colors[2],
            padding=5,
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(terminal + ' -e ytop')},
            fmt=' {}',
            update_interval=2.0,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.Wlan(
            foreground=colors[2],
            padding=10,
            interface='wlp60s0',
            format='  {essid} ({percent:2.0%}) '
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.Volume(
            foreground=colors[2],
            padding=5,
            fmt=' {}'
        ),
        widget.Backlight(
            foreground=colors[2],
            padding=5,
            backlight_name='intel_backlight',
            format=' {percent:2.0%}'
        ),
        CustomBattery(
            foreground=colors[2],
            low_foreground=colors[7],
            padding=5,
            format='{char} {percent:2.0%}',
            low_percentage=0.2,
            full_char='',
            empty_char='',
            ramp_cap1_char='',
            ramp_cap2_char = '',
            ramp_cap3_char = '',
            ramp_cap4_char = '',
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
        # widget.Systray(
        #     icon_size=20,
        #     padding=2,
        # ),
        # widget.Sep(
        #     linewidth=0,
        #     padding=10,
        # ),
        widget.Clock(
            foreground=colors[2],
            padding=10,
            format=" %d.%m.%Y  %H:%M"
        ),
    ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=25 if num_screens > 1 else 40))]
# return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
#         Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
#         Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    # widgets_screen1 = init_widgets_screen1()
    # widgets_screen2 = init_widgets_screen2()


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
# main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

floating_layout = layout.Floating(float_rules=[
    {"role": "EventDialog"},
    {"role": "Msgcompose"},
    {"role": "Preferences"},
    {"role": "pop-up"},
    {"role": "prefwindow"},
    {"role": "task_dialog"},
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'ssh-askpass'},
    {'wmclass': 'gcolor2'},
    {'wname': 'pinentry'},
])

floating_types = ["notification", "toolbar", "splash", "dialog",
                  "utility", "menu", "dropdown_menu", "popup_menu", "tooltip,dock",
                  ]

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for() or window.window.get_wm_type() in floating_types):
        window.floating = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
