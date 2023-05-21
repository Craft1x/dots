#!/usr/bin/env bash

[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected) && playerctl -p "$PLAYER" status >/dev/null 2>&1 || rm -f /tmp/player-selected

if [[ -z $PLAYER ]]; then
  OUT=$(playerctl status 2>&1)
else
  OUT=$(playerctl -p "$PLAYER" status 2>&1)
fi


[[ $OUT == "No players found" ]] && echo "Nothing" || echo "$OUT"
