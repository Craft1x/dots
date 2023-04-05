#!/usr/bin/env bash
theme="style-noicon"
dir="$HOME/.config/rofi"

RES=$(rofi -show run -theme "$dir"/"$theme" -dmenu -p "Timer" -theme-str 'listview { enabled: false;}')

[[ -n $RES ]] && "$HOME/.config/i3/timer.py" sethuman "$RES"
