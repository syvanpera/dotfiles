from libqtile.config import Screen
from libqtile.bar import Bar

from widgets_list_sep import Widgets_List
# from widgets_list_power import Widgets_List

class Bars(object):

    widget_list = Widgets_List()

    ##### BARS #####

    def init_top_main(self, hidpi = False):
        return Bar(
            widgets=self.widget_list.init_top_main(hidpi),
            opacity=0.92,
            size=25 if not hidpi else 50
        )

    def init_top_secondary(self, hidpi = False):
        return Bar(
            widgets=self.widget_list.init_top_secondary(hidpi),
            opacity=0.92,
            size=25 if not hidpi else 50
        )

class Screens(object):

    bars = Bars()

    ##### SCREENS #####

    # Mono

    def init_mono_screen(self):
        return [
            Screen(
                top=self.bars.init_top_main(hidpi=True)
            ),
        ]

    # Multi

    def init_multi_screen(self):
        return [
            Screen(
                top=self.bars.init_top_main()
            ),
            Screen(
                top=self.bars.init_top_secondary(hidpi=True)
            ),
            Screen(
                top=self.bars.init_top_secondary()
            ),
        ]

# vim: tabstop=4 shiftwidth=4 expandtab
