#!/usr/bin/env bash

# Add this script to your wm startup file.
DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=`xrandr --listmonitors`

# Launch the bar
echo $MONITORS | grep DisplayPort-0 && polybar -q main -c "$DIR"/config.ini &
echo $MONITORS | grep HDMI-A-0 && polybar -q main2 -c "$DIR"/config.ini &
echo $MONITORS | grep eDP-1 && polybar -q main3 -c "$DIR"/config.ini &

# IPC settings and test
ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-main
echo message >/tmp/ipc-main
