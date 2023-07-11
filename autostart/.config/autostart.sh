#!/usr/bin/env bash

DIR="/tmp/autostart-logs"

rm -fr $DIR
mkdir -p $DIR

run ()
{
echo "$(date -u +"%H:%M:%S")" "RUN:" "$@" >> $DIR"/log"
$@ >> $DIR"/log" 2>&1 &
}

configureKeyboard() {
  #increase key speed via rate change
  xset r rate 300 50 

  # swap alt and win 
  setxkbmap -option altwin:swap_alt_win 
}

run ~/.config/i3/fade.sh

# set screen position
test -f ~/.screenlayout/layout.sh && run ~/.screenlayout/layout.sh 


run hsetroot -solid "#000000" && run ~/.config/nitrogen/set-random-wallpaper.sh 

# add picom for shadows and animtaions
run ~/.config/i3/activatecompositor.sh true


# start polkit
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 

# notification daemon
run dunst 

run warpd

# preload alacritty to save start time
# run alacritty -o "window.class=hidden_window" --hold -e xdo hide

# preload nemo to save start time
# run ~/.config/i3/preload_nemo.sh

# Start greenclip daemon
run greenclip daemon

# Hide the mouse after no movement
run unclutter 

# start applets
run nm-applet  
command -v optimus-manager-qt && run optimus-manager-qt 
# exec --no-startup-id command -v kdeconnect-indicator && kdeconnect-indicator

# conky clock widget
# command -v conky && run ~/.conky/conky-startup.sh 

#enable num lock 
run numlockx 

#hide sidebar in nemo
run gsettings set org.nemo.window-state start-with-sidebar false 

#bar
run ~/.config/polybar/launch.sh

run ~/.config/i3/alternating_layouts.py

run ~/.config/i3/alternating_layouts.py 

run ~/.config/i3/shift_watcher.py

run ~/.config/i3/layout-manager.py

run ~/.config/i3/timer.py


# local autostarts
[ -f ~/.other/autostart-local.sh ] && run ~/.other/autostart-local.sh 

sleep 2 && run configureKeyboard && pkill -USR1 -x sxhkd || run ~/.config/sxhkd/launch.sh

# just in case
sleep 5 && run configureKeyboard && pkill -USR1 -x sxhkd || run ~/.config/sxhkd/launch.sh

#usb monitor
run ~/.config/i3/usb_monitor.sh

# waiting for all to finish
wait
