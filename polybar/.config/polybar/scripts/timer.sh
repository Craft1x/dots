#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh"

ICON=""
COLOR="${white}"

TIME=$(~/.config/i3/timer.py getpretty)

if [[ $TIME == "off" ]] || [[ $TIME == "no socket" ]]; then
  echo "" 
  exit 0
fi

echo "%{F$COLOR}$ICON $TIME%{F-}"
