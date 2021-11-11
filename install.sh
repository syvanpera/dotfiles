#!/bin/env bash
set -e

echo "Welcome!" && sleep 2

#Default vars
HELPER="paru"

# does full system update
echo "Doing a system update, cause stuff may break if it's not the latest version..."
sudo pacman --noconfirm -Syu

echo "###########################################################################"
echo "Will do stuff, get ready"
echo "###########################################################################"

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

sudo pacman -S --noconfirm --needed rofi tint2 feh xmonad

$HELPER -S candy-icons-git   \
	   wmctrl            \
	   alacritty         \
	   playerctl         \
	   dunst             \
	   xmonad-contrib    \
	   jq                \
	   xclip             \
	   maim              \
	   rofi-greenclip    \
	   xautolock         \
	   betterlockscreen
