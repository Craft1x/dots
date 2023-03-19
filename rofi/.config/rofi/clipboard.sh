#!/bin/bash
theme="style-noicon"
dir="$HOME/.config/rofi"

rofi -modi "clipboard:greenclip print" -theme $dir/"$theme"  -show clipboard -run-command '{cmd}'    
