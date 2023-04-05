#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

ENABLED=$(head -n 1 ~/.config/sxhkd/sxhkdrc | grep -q gamemode && echo 1 || echo 0)

if [[ $ENABLED == "0" ]]; then
  echo "" 
  exit 0
fi

icon_color="${blue}"

echo "$separator%{A1:$HOME/.config/sxhkd/gamemode.sh disable:} %{F$icon_color}調 %{F-}%{A}"
