#!/usr/bin/env bash
OUT=$($HOME/.config/polybar/scripts/cached-mpris.sh | tail -n 1)

if [[ ! -z $OUT ]]; then
  echo $OUT
fi
