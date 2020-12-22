from os.path import expanduser

from libqtile.widget import (
    GroupBox,
    Prompt,
    WindowName,
    TextBox,
    DF,
    CPU,
    CurrentLayoutIcon,
    CheckUpdates,
    Systray,
    ThermalSensor,
    Backlight,
    Memory,
    Volume,
    Wlan,
    Clock
)

from widget.battery import Battery
from widgets import Fancy_Widgets as Separator_Widgets
# from widgets import Pipe_Widgets as Separator_Widgets
# from widgets import Colon_Widgets as Separator_Widgets
from widgets import Space_Widgets
from aesthetics import Colors, Fonts

class Widgets_List(object):

    color = Colors()
    font = Fonts()

    space = Space_Widgets()
    separator = Separator_Widgets()

    ##### WIDGETS LIST #####

    def init_top_main(self, hidpi = False):

        fontsize = 12 if not hidpi else 22

        wl  = []

        wl += [CurrentLayoutIcon(
            fontsize=fontsize,
            custom_icon_paths=[expanduser("~/.config/qtile/icons")],
            foreground=self.color.white,
            padding=10,
            scale=0.7
        )]

        wl += [GroupBox(
            fontsize=24 if not hidpi else 40,
            font=self.font.bold,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=10 if not hidpi else 20,
            borderwidth=3,
            hide_unused=True,
            active=self.color.yellow,
            inactive=self.color.lightgrey,
            urgent_text=self.color.white,
            highlight_method="line",
            urgent_alert_method="line",
            highlight_color=self.color.grey,
            urgent_border=self.color.red,
            this_current_screen_border=self.color.yellow,
            other_screen_border=self.color.magenta,
            this_screen_border=self.color.magenta,
            other_current_screen_border=self.color.yellow,
            rounded=False,
            disable_drag=True,
            use_mouse_wheel=False
        )]

        wl += [self.space.small()]

        wl += [Prompt(
            fontsize=fontsize,
            prompt="λ : ",
            padding=10,
            bell_style="visual",
            foreground=self.color.magenta,
            background=self.color.black
        )]

        wl += [self.space.small()]

        wl += [WindowName(
            fontsize=fontsize,
            padding=0,
            show_state=False,
            for_current_screen=False,
            foreground=self.color.yellow
        )]

        wl += [self.space.extra_large()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.magenta,
            text=" "
        )]
        wl += [DF(
            fontsize=fontsize,
            foreground=self.color.magenta,
            format='{uf}{m}',
            partition='/',
            visible_on_warn=False
        )]

        wl += [self.space.small()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.magenta,
            text=" "
        )]
        wl += [DF(
            fontsize=fontsize,
            foreground=self.color.magenta,
            format='{uf}{m}',
            partition='/home',
            visible_on_warn=False
        )]

        wl += [self.separator.normal()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.green,
            text=" "
        )]
        wl += [CPU(
            fontsize=fontsize,
            foreground=self.color.green,
            # TODO Remove hard coded terminal
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn("alacritty -e ytop")},
            format='{load_percent}%',
            update_interval=2.0
        )]

        wl += [self.space.small()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.green,
            text=" "
        )]
        wl += [ThermalSensor(
            fontsize=fontsize,
            foreground=self.color.green,
            threshold=90,
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn("alacritty -e ytop")},
            update_interval=2.0
        )]

        wl += [self.separator.normal()]
        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.blue,
            text=" "
        )]
        wl += [Memory(
            fontsize=fontsize,
            foreground=self.color.blue,
            mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(terminal + ' -e ytop')},
            update_interval=2.0,
        )]

        wl += [self.separator.normal()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.cyan,
            font=self.font.bold,
            text="直 "
        )]
        wl += [Wlan(
            fontsize=fontsize,
            foreground=self.color.cyan,
            interface='wlp60s0',
            format='{essid} ({percent:2.0%})'
        )]

        wl += [self.separator.normal()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.orange,
            font=self.font.bold,
            text=" "
        )]
        wl += [Volume(
            fontsize=fontsize,
            foreground=self.color.orange
        )]

        wl += [self.space.small()]

        wl += [TextBox(
            fontsize=fontsize,
            foreground=self.color.orange,
            font=self.font.bold,
            text=" "
        )]
        wl += [Backlight(
            fontsize=fontsize,
            foreground=self.color.orange,
            backlight_name='intel_backlight',
            format='{percent:2.0%}'
        )]

        wl += [self.space.small()]

        wl += [Battery(
            fontsize=fontsize,
            foreground=self.color.orange,
            low_foreground=self.color.red,
            format='{char} {percent:2.0%}',
            low_percentage=0.2,
            charge_char='',
            full_char='',
            empty_char='',
            ramp_cap0_char='',
            ramp_cap1_char='',
            ramp_cap2_char='',
            ramp_cap3_char='',
            ramp_cap4_char='',
            ramp_cap0_foreground=self.color.red[0],
            ramp_cap1_foreground=self.color.red[0],
            ramp_cap2_foreground=self.color.orange[0],
            ramp_cap3_foreground=self.color.orange[0],
            ramp_cap4_foreground=self.color.green[0],
        )]

        # wl += [self.separator.normal()]
        # wl += [TextBox(
        #     font=self.font.bold,
        #     text=" "
        # )]
        # wl += [CheckUpdates(
        #     distro="Arch_checkupdates",
        #     display_format="{updates}",
        #     update_interval=900,
        #     colour_have_updates=self.color.white,
        #     colour_no_updates=self.color.white
        # )]

        # wl += [self.separator.normal()]
        # wl += [Systray(
        #     padding=3,
        #     icon_size=19 if not hidpi else 30
        # )]

        wl += [self.separator.normal()]
        wl += [Clock(
            fontsize=fontsize,
            foreground=self.color.yellow,
            format=" %d.%m.%Y  %H:%M"
        )]
        wl += [self.space.large()]

        return wl

    def init_top_secondary(self, hidpi = False):

        fontsize = 12 if not hidpi else 22

        wl  = []

        wl += [CurrentLayoutIcon(
            fontsize=fontsize,
            custom_icon_paths=[expanduser("~/.config/qtile/icons")],
            foreground=self.color.white,
            padding=10,
            scale=0.7
        )]

        wl += [GroupBox(
            fontsize=24 if not hidpi else 50,
            font=self.font.bold,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=10 if not hidpi > 1 else 20,
            borderwidth=3,
            hide_unused=True,
            active=self.color.yellow,
            inactive=self.color.lightgrey,
            urgent_text=self.color.white,
            highlight_method="line",
            urgent_alert_method="line",
            highlight_color=self.color.grey,
            urgent_border=self.color.red,
            this_current_screen_border=self.color.yellow,
            other_screen_border=self.color.magenta,
            this_screen_border=self.color.magenta,
            other_current_screen_border=self.color.yellow,
            rounded=False,
            disable_drag=True,
            use_mouse_wheel=False
        )]

        wl += [self.space.small()]

        wl += [WindowName(
            fontsize=fontsize,
            padding=0,
            show_state=False,
            for_current_screen=False,
            foreground=self.color.yellow
        )]

        wl += [Clock(
            fontsize=fontsize,
            format=" %d.%m.%Y  %H:%M"
        )]
        wl += [self.space.large()]

        return wl

# vim: tabstop=4 shiftwidth=4 expandtab
