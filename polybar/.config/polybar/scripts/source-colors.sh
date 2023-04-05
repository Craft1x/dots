#!/usr/bin/env sh
eval "$(sed "/^[;,\[]/d"  "$HOME/.config/polybar/colors.ini"  | tr -d " "| tr "-" "_")"
separator="%{F$sep}""⏽""%{F-}" 
