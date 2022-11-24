#!/bin/bash
theme="style-noicon"
dir="$HOME/.config/rofi"

rofi -no-lazy-grab  -no-show-match -theme $dir/"$theme" -show calc -modi calc -calc-command "echo -n '{result}' | xclip -i -selection clipboard"
