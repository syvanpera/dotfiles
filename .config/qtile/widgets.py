from libqtile.widget.textbox import TextBox
from libqtile.widget.image import Image
from libqtile.widget.sep import Sep

from aesthetics import Colors, Fonts

class Colon_Widgets(object):

    font = Fonts()
    color = Colors()

    def white(self):
        return TextBox(
            text = " :: "
        )

    def normal(self):
        return TextBox(
            font = self.font.bold,
            foreground = self.color.yellow,
            text = " :: "
        )

class Pipe_Widgets(object):

    font = Fonts()
    color = Colors()

    def white(self):
        return TextBox(
            text = " | "
        )

    def normal(self):
        return TextBox(
            font = self.font.bold,
            foreground = self.color.yellow,
            text = " | "
        )

class Fancy_Widgets(object):

    font = Fonts()
    color = Colors()

    def white(self):
        return TextBox(
            text = "  "
        )

    def normal(self):
        return TextBox(
            font = self.font.bold,
            foreground = self.color.yellow,
            text = "  "
        )

class Power_Widgets(object):

    def left_grey(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar01.png"
        )

    def right_grey(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar06.png"
        )

    def black_red(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar02.png"
        )

    def grey_red(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar02-b.png"
        )

    def red_magenta(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar03.png"
        )

    def magenta_green(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar04.png"
        )

    def green_blue(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar05.png"
        )

    def blue_orange(self):
        return Image(
            scale = True,
            filename = "~/.config/qtile/power/bar07.png"
        )

class Space_Widgets(object):

    def large(self):
        return Sep(
            linewidth = 0,
            padding   = 20,
        )

    def extra_large(self):
        return Sep(
            linewidth = 0,
            padding   = 40,
        )

    def small(self):
        return Sep(
            linewidth = 0,
            padding   = 10,
        )

# vim: tabstop=4 shiftwidth=4 expandtab
