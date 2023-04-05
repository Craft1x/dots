#!/usr/bin/env bash
INSTANCES=( $(playerctl --list-all) )

theme="style-noicon"
dir="$HOME/.config/rofi"

if [[ -n "$1" ]]; then
  ID=$(echo "$1" | cut -d " " -f1 | tr -d "[]")
  ((ID--))
  PLAYER="${INSTANCES[$ID]}"
  echo "$PLAYER" > "/tmp/player-selected"
  # notify-send "$ID" "$PLAYER"
  exit 0
fi

COUNT=0
for id in "${INSTANCES[@]}"
do : 
  ((COUNT++))
  TITLE=$(playerctl metadata -p "$id" | grep title | tr -s " " | cut -d " " -f3-99)
  PLAYER=$(playerctl metadata -p "$id" | head -n 1 | cut -d " " -f1)
  echo "[$COUNT] $PLAYER - $TITLE"
done


