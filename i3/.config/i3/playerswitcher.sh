#!/usr/bin/env bash
INSTANCES=$(playerctl --list-all)
[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected)

if [ "$(echo "$INSTANCES" | wc -w)" -lt 2 ]; then
  # echo "Players < 2"
  exit 0
fi

if [[ -z $PLAYER ]]; then
  # echo "Setting the player"
  PLAYER=$(echo "$INSTANCES" | cut -f 1 -d " ")
fi

INSTANCES_SHORT=$(echo "$INSTANCES" | sed "s/^.*$PLAYER //")

# echo $PLAYER
# echo $INSTANCES_SHORT

PLAYER=$(echo "$INSTANCES_SHORT" | cut -f 1 -d " ")

echo "$PLAYER" > /tmp/player-selected
