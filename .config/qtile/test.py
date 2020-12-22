from Xlib import X, display
from Xlib.ext import randr

d = display.Display()
s = d.screen()
r = s.root
res = r.xrandr_get_screen_resources()._data

print(res)

for output in res['outputs']:
    print(d.xrandr_get_output_info(output, res['config_timestamp'])._data)
