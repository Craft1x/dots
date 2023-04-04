#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 
# label = %{T2}%{T-}%{A1:gnome-calendar:} %date% %{F#ffd88e}%time%%{F-} %{A}

ICON=""
COLOR="${white}"

TIME=`python3 $HOME/.config/i3/timer.py getpretty`

if [[ $TIME == "off" ]] || [[ $TIME == "no socket" ]]; then
  echo "" 
  exit 0
fi

echo "%{F$COLOR}$ICON $TIME%{F-}"
