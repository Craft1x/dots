#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh"
COLOR="${yellow}"
ICON=""

while true; do
DATA=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')

if [ $DATA -ge 85 ]; then
  ICON=""
elif [ $DATA -ge 68 ]; then
  ICON=""
elif [ $DATA -ge 51 ]; then
  ICON=""
elif [ $DATA -ge 34 ]; then
  ICON=""
elif [ $DATA -ge 17 ]; then
  ICON=""
fi

echo "%{A1:kitty btop:} %{F$COLOR}$ICON%{F-} $DATA"%{A}
sleep 1
done
