#!/usr/bin/env bash
INSTANCES=$(playerctl --list-all)
FILES=``

theme="style-noicon"
dir="$HOME/.config/rofi"

rofi_menu() { 
 rofi -no-lazy-grab -lines 20 -matching fuzzy -sort -sorting-method fzf -i -theme "$dir"/"$theme" -p "$TITLE" -show PLAYER -modi "PLAYER:$dir/audio-mode.sh"
}

TITLE="PLAYERS"
SELECT=$(echo "$INSTANCES" | rofi_menu)
