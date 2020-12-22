import re

from libqtile.config import Match, Rule

class Rules(object):

    ##### RULES #####

    def init_rules(self):
        return [
            # Floating types
            Rule(
                Match(wm_type = [
                    "confirm",
                    "download",
                    "notification",
                    "toolbar",
                    "splash",
                    "dialog",
                    "error",
                    "file_progress",
                    "confirmreset",
                    "pinentry",
                    "sshaskpass",
                ]),
                float = True
            ),

            # Floating classes
            Rule(
                Match(wm_class = [
                    "Gcolor2",
                    "Gcolor3",
                    "balena-etcher-electron",
                    "Virt-manager",
                    re.compile("VirtualBox")
                ]),
                float = True,
                break_on_match = False
            ),

            # Floating names
            Rule(
                Match(title = [
                ]),
                float = True
            )
        ]

# vim: tabstop=4 shiftwidth=4 expandtab
