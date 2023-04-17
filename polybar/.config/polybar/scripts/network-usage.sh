#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

DEVICES="wlan\|enp\|wlp"

INTERFACES=$(ip l | grep $DEVICES)

[ -z "$INTERFACES" ] && exit 0

TOTAL=$(ifstat --interval=1 \
  | tail +4 \
  | grep $DEVICES \
  | tr -s ' ' \
  | cut -d ' ' -f 6,8 \
  | numfmt --from "auto" --field 1-2 \
  | awk '{ t1 += $1; t2 += $2 } END {print t1; print t2;}' \
  | numfmt --to=iec)

DOWN=$(echo "$TOTAL" | head -n 1)
UP=$(echo "$TOTAL" | tail -n 1)

echo $separator "%{F${cyan}}%{F-}" $DOWN "%{F${brightRed}}%{F-}" $UP
