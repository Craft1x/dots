#!/usr/bin/env bash
theme="style"
dir="$HOME/.config/rofi"

strings=('Layout' 'Calculator' 'Game Mode' 'Compositor' 'Switch Player' 'Timer' 'Settings' 'App Menu Editor')
icons=('gaps/default.png' 'menu/calculator.svg' 'menu/games.svg' 'menu/compositor.svg' 'menu/player.svg' 'menu/timer.svg' 'menu/settings.svg' 'menu/app_editor.svg')
commands=("$HOME/.config/rofi/gaps.sh" "$HOME/.config/rofi/calc.sh" "$HOME/.config/sxhkd/gamemode.sh toggle" "$HOME/.config/i3/activatecompositor.sh toggle" "$HOME/.config/rofi/audio.sh" "$HOME/.config/rofi/timer.sh" "cinnamon-settings" "cinnamon-menu-editor")

prompt=""
length=${#strings[@]}

for (( j=0; j<length; j++ ));
do
  prompt="$prompt${strings[$j]}\x00icon\x1f$HOME/.config/rofi/icons/${icons[$j]}\n";
done

result=$(printf "$prompt" | rofi -no-lazy-grab -sort -sorting-method fzf -dmenu -p "MENU" -i -theme "$dir"/"$theme")

for (( j=0; j<length; j++ ));
do
  [[ $result == "${strings[$j]}" ]] && ${commands[$j]} && break
done
