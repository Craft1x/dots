#!/usr/bin/env bash

APP_NAME=sxhkd

# Terminate already running bar instances
killall -q $APP_NAME

# Wait until the processes have been shut down
while pgrep -u $UID -x $APP_NAME >/dev/null
do 
	sleep 1
done

$APP_NAME -c "$HOME/.config/sxhkd/sxhkdrc" "$HOME/.other/sxhkd/sxhkdrc" & disown
