from libqtile.command import lazy

from Xlib import X, display
from Xlib.ext import randr


class Function(object):

    num_screens = None

    ##### DISPLAYS ####

    @classmethod
    def screen_count(klass):
        if klass.num_screens is None:
            klass.num_screens = 0
            d = display.Display()
            s = d.screen()
            r = s.root
            res = r.xrandr_get_screen_resources()._data

            for output in res['outputs']:
                mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
                if mon['num_preferred']:
                    klass.num_screens += 1

        return klass.num_screens


    ##### SWAP SCREENS #####

    @staticmethod
    def swap_prev_screen():
        @lazy.function
        def __inner(qtile):
            i = qtile.screens.index(qtile.current_screen)

            if qtile.current_group and i != 0:
                group = qtile.screens[i - 1].group
                qtile.group[group.name].toscreen()
        return __inner

    @staticmethod
    def swap_next_screen():
        @lazy.function
        def __inner(qtile):
            i = qtile.screens.index(qtile.current_screen)

            if qtile.current_group and i + 1 != len(qtile.screens):
                group = qtile.screens[i + 1].group
                qtile.group[group.name].toscreen()
        return __inner

    ##### MOVE WINDOW IN GROUPS #####

    @staticmethod
    def window_to_prev_group():
        @lazy.function
        def __inner(qtile):
            i = qtile.groups.index(qtile.current_group)

            if qtile.current_window and i != 0:
                group = qtile.groups[i - 1].name
                qtile.current_window.togroup(group)
        return __inner

    @staticmethod
    def window_to_next_group():
        @lazy.function
        def __inner(qtile):
            i = qtile.groups.index(qtile.current_group)

            if qtile.current_window and i != len(qtile.groups):
                group = qtile.groups[i + 1].name
                qtile.current_window.togroup(group)
        return __inner

    ##### MOVE WINDOW IN SCREENS #####

    @staticmethod
    def window_to_prev_screen():
        @lazy.function
        def __inner(qtile):
            i = qtile.screens.index(qtile.current_screen)

            if qtile.current_window and i != 0:
                group = qtile.screens[i - 1].group.name
                qtile.current_window.togroup(group)
        return __inner

    @staticmethod
    def window_to_next_screen():
        @lazy.function
        def __inner(qtile):
            i = qtile.screens.index(qtile.current_screen)

            if qtile.current_window and i + 1 != len(qtile.screens):
                group = qtile.screens[i + 1].group.name
                qtile.current_window.togroup(group)
        return __inner

    ##### KILL ALL WINDOWS #####

    @staticmethod
    def kill_all_windows():
        @lazy.function
        def __inner(qtile):
            for window in qtile.current_group.windows:
                window.kill()
        return __inner

    @staticmethod
    def kill_all_windows_minus_current():
        @lazy.function
        def __inner(qtile):
            for window in qtile.current_group.windows:
                if window != qtile.current_window:
                    window.kill()
        return __inner

# vim: tabstop=4 shiftwidth=4 expandtab
