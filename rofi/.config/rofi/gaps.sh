#!/bin/bash
theme="style"
dir="$HOME/.config/rofi"

strings=("Default" "Compact" "Horizontal" "Vertical" "Classic" "One-sided" "Zoomed" "Spaced")
icons=("default.png" "compact.png" "horizontal.png" "vertical.png" "classic.png" "onesided.png" "zoomed.png" "spaced.png")
commands=("default" "compact" "horizontal" "vertical" "classic" "sided" "zoomed" "spaced")

prompt=""
length=${#strings[@]}

for (( j=0; j<${length}; j++ ));
do
  prompt="$prompt${strings[$j]}\x00icon\x1f~/.config/rofi/icons/gaps/${icons[$j]}\n";
done

result=`printf "$prompt" | rofi -no-lazy-grab -sort -sorting-method fzf -dmenu -p "GAPS" -i -theme $dir/"$theme"` 

for (( j=0; j<${length}; j++ ));
do
  [[ $result == ${strings[$j]} ]] && "$HOME/.config/i3/gaps.sh" ${commands[$j]} && break
done
