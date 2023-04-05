#!/usr/bin/env bash
[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected)
playerctl -p "$PLAYER" status || rm /tmp/player-selected
playerctl -p "$PLAYER" "$@"
