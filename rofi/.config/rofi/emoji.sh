#!/usr/bin/env bash
theme="style-emoji"
dir="$HOME/.config/rofi"

rofi -no-lazy-grab -lines 20 -sort -sorting-method fzf -i -theme "$dir"/"$theme" -show emoji -modi emoji -p ''
