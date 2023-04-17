#!/usr/bin/env sh
bar=$(printf "%0.s─" $(seq 1 $((volume / 5))))
dunstify -i "$1" -r 5555 -u normal -h int:value:"$2" "$3"
