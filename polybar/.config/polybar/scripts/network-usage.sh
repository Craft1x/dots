#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

DEVICES="wlan\|enp\|wlp"

INTERFACES=$(ip l \
  | grep $DEVICES)

if [ -z "$INTERFACES" ]
then
  exit 0
fi

TOTAL=$(ifstat --interval=1 \
  | tail +4 \
  | grep $DEVICES \
  | tr -s ' ' \
  | cut -d ' ' -f 6,8 \
  | numfmt --from "auto"   \
  | numfmt --from "auto" --field 2 \
  | awk '{ t1 += $1; t2 += $2 } END {print t1; print t2;}' \
  | numfmt --to=iec)

DOWN=$(echo "$TOTAL" | head -n 1)
UP=$(echo "$TOTAL" | tail -n 1)

icon_color1="${cyan}"
icon_color2="${brightRed}"

echo $separator "%{F$icon_color1}""""%{F-}" $DOWN "%{F$icon_color2}""""%{F-}" $UP
