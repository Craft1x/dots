#!/usr/bin/env sh
eval "$(sed "/^[;,\[]/d"  "$HOME/.config/polybar/colors.ini"  | tr -d " "| tr "-" "_")"
sepchar="⏽"
separator="%{F$sep}""$sepchar""%{F-}"
