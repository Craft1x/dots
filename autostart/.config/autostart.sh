#!/bin/bash

function configureKeyboard {
  #increase key speed via rate change
  xset r rate 300 50 &

  # swap alt and win 
  setxkbmap -option altwin:swap_alt_win &
}

# set screen position
test -f ~/.screenlayout/layout.sh && ~/.screenlayout/layout.sh &

hsetroot -solid "#000000" && ~/.config/nitrogen/set-random-wallpaper.sh &

# add picom for shadows and animtaions
picom -b & 

# start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# notification daemon
dunst &

# Start clipster daemon
clipster -d &
clipster -c --erase-entire-board &

# Hide the mouse after no movement
unclutter &

# start applets
nm-applet  &
command -v optimus-manager-qt && optimus-manager-qt &
# exec --no-startup-id command -v kdeconnect-indicator && kdeconnect-indicator

# conky clock widget
command -v conky &&  ~/.conky/conky-startup.sh &

#enable num lock 
numlockx &

#hide sidebar in nemo
gsettings set org.nemo.window-state start-with-sidebar false &
#bar
$HOME/.config/polybar/launch.sh &

#exec_always --no-startup-id autotiling
~/.config/i3/alternating_layouts.py &

# keybind daemon
~/.config/sxhkd/launch.sh &

# local autostarts
[ -f ~/.other/autostart-local.sh ] && ~/.other/autostart-local.sh &

configureKeyboard && sleep 2 && configureKeyboard &

# waiting for all to finish
wait
