#!/usr/bin/env bash

if [[ ! -f /tmp/player-info ]]; then
  [ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected) && playerctl -p "$PLAYER" status >/dev/null 2>&1 || rm -f /tmp/player-selected

  MATCH=$($HOME/.config/polybar/scripts/get_mpris_match.sh $PLAYER)

  # echo "$MATCH"

  echo $MATCH > /tmp/player-info

  echo $MATCH

  if [ $MATCH = "Nothing" ];  then
    echo ""  >> /tmp/player-info

    echo ""
  else
    echo $MATCH > /tmp/player-info
    STATUS=$($HOME/.config/polybar/scripts/get_mpris_status.sh)
    echo $STATUS >> /tmp/player-info

    echo $STATUS
  fi

  exit 0
fi


[[ -f /tmp/player-info ]] && cat /tmp/player-info 2>/dev/null
