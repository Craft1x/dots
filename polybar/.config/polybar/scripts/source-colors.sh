#!/usr/bin/env sh
eval `cat "$HOME/.config/polybar/colors.ini" | sed "/^[;,\[]/d" | tr -d " "| tr "-" "_"` 
separator="%{F$sep}""⏽""%{F-}" 
