#!/usr/bin/env bash
INSTANCES=$(playerctl --list-all)
[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected)

if [ "$(echo "$INSTANCES" | wc -w)" -lt 2 ]; then
  # echo "Players < 2"
  exit 0
fi

rm -f /tmp/player-info

if [[ -z $PLAYER ]]; then
  echo "Setting the player"
  PLAYER=$(echo "$INSTANCES" | head -n 1)
fi

INDEX=$(echo "$INSTANCES" | grep -n "$PLAYER" | cut -d: -f1)
INDEX=$((INDEX + 1))

if [ $INDEX -gt $(echo "$INSTANCES" | wc -l) ]; then
  INSTANCES=1
fi

NEXT_PLAYER=$(echo "$INSTANCES" | sed -n "${INDEX}p")

echo "$NEXT_PLAYER" > /tmp/player-selected
