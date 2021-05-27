import re

from libqtile.config import Group, Match

from functions import Function
from layouts import Layouts

class Groups(object):

    ##### GROUPS #####

    def init_groups(self):

        layout = Layouts()

        if Function.screen_count() > 1:
            return [
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                        layout.tabbed()
                    ],
                    screen_affinity=0,
                    spawn="alacritty -e tmux"
                    ),
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                    ],
                    screen_affinity=0,
                    matches = [
                        Match(wm_class = [
                            "emacs",
                        ])
                    ]
                    ),
                Group("",
                    layouts = [
                        layout.max(),
                        layout.monadTall(),
                    ],
                    screen_affinity=2,
                    matches = [
                        Match(wm_class = [
                            "firefox",
                        ])
                    ],
                    spawn="firefox"
                    ),
                Group("",
                    layouts = [
                        layout.max(),
                        layout.monadTall(),
                    ],
                    screen_affinity=2,
                    matches = [
                        Match(wm_class = [
                            "chromium",
                        ])
                    ]
                    ),
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                    ],
                    screen_affinity=1
                    ),
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                    ],
                    screen_affinity=1
                    ),
            ]
        else:
            return [
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.tabbed()
                    ],
                    screen_affinity=0,
                    spawn="alacritty -e tmux"
                    ),
                Group("",
                    layouts = [
                        layout.max(),
                        layout.monadTall(),
                    ],
                    screen_affinity=0,
                    matches = [
                        Match(wm_class = [
                            "firefox",
                        ])
                    ],
                    spawn="firefox"
                    ),
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                    ],
                    screen_affinity=0
                    ),
                Group("",
                    layouts = [
                        layout.monadTall(),
                        layout.monadWide(),
                    ],
                    screen_affinity=0
                    ),
                Group("",
                    layouts = [
                        layout.max(),
                        layout.monadTall(),
                    ],
                    screen_affinity=0,
                    matches = [
                        Match(wm_class = [
                            "chromium",
                        ])
                    ]
                    ),
            ]

# vim: tabstop=4 shiftwidth=4 expandtab
