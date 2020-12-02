#!/usr/bin/env python3

import subprocess
import Xlib
import Xlib.display

disp = Xlib.display.Display()
hosts = disp.list_hosts()
root = disp.screen().root

print(hosts)

output = subprocess.getoutput("bspc query -N -d -n .window")
print(output.splitlines())
# wids=subprocess.run(['bspc', 'query', '-N', '-d', '-n', '.window'], stdout=subprocess.PIPE).stdout.decode('utf-8')

# for wid in wids:
#     print(wid)
