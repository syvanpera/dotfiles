#!/usr/bin/env sh

# Terminate already running mako instances
killall -q mako

# Wait until the processes have been shut down
while pgrep -x mako >/dev/null; do sleep 1; done

# Launch main
mako &
