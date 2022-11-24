#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

INTERFACES=$(ifstat --interval=1 \
  | tail +4 \
  | grep "wlan\|enp\|wlp")

if [ -z "$INTERFACES" ]
then
  exit 0
fi

TOTAL=$(ifstat --interval=1 \
  | tail +4 \
  | grep "wlan\|enp\|wlp" \
  | tr -s ' ' \
  | cut -d ' ' -f 6,8 \
  | numfmt --from "auto"   \
  | numfmt --from "auto" --field 2 \
  | awk '{ t1 += $1; t2 += $2 } END {print t1; print t2;}' \
  | numfmt --to=iec)

DOWN=`echo $TOTAL | cut -d ' ' -f1`
UP=`echo $TOTAL | cut -d ' ' -f2`

icon_color1="${cyan}"
icon_color2="${red}"

echo $separator "%{F$icon_color1}""""%{F-}" $DOWN "%{F$icon_color2}""""%{F-}" $UP
