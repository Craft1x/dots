#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=$(xrandr --listmonitors)

# Launch the bar
echo "$MONITORS" | grep DisplayPort-0 && polybar -q main -c "$DIR"/config.ini &
echo "$MONITORS" | grep HDMI-A-0 && polybar -q main2 -c "$DIR"/config.ini &
echo "$MONITORS" | grep eDP-1 && polybar -q mainLaptopIntel -c "$DIR"/config.ini &
echo "$MONITORS" | grep eDP-1-1 && polybar -q mainLaptopNvidia -c "$DIR"/config.ini &
echo "$MONITORS" | grep VNC-0 && polybar -q mainVNC -c "$DIR"/config.ini &
