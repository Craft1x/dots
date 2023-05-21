#!/usr/bin/env bash

# remove cached info
pactl subscribe | while read -r event; do
  rm -f /tmp/player-info
done
