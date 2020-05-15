#!/bin/bash

if ps aux | rg "[o]penconnect" >&/dev/null; then
    echo "";
elif ps aux | rg "[o]penvpn" >&/dev/null; then
    echo "";
else
    echo "";
fi
