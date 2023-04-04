#!/bin/bash
theme="style"
dir="$HOME/.config/rofi"

strings=("Lock Screen" "Shut Down / Power Off" "Reboot / Restart" "Logout")
icons=("lock.png" "power-off.png" "reboot.png" "logout.png")
commands=("cinnamon-screensaver-command --lock" "poweroff" "reboot" "i3-msg exit")

prompt=""
length=${#strings[@]}

for (( j=0; j<${length}; j++ ));
do
  prompt="$prompt${strings[$j]}\x00icon\x1f~/.config/rofi/icons/power/${icons[$j]}\n";
done

result=`printf "$prompt" | rofi -no-lazy-grab -sort -sorting-method fzf -dmenu -p "" -i -theme $dir/"$theme"` 

for (( j=0; j<${length}; j++ ));
do
  [[ $result == ${strings[$j]} ]] && ${commands[$j]} && break
done
