#!/usr/bin/env bash
source "$HOME/.config/polybar/scripts/source-colors.sh" 

if [ -z "$LATITUDE" ] || [ -z "$LONGITUDE" ] ; then
  (echo "UNSET VARIABLES"; exit 0)
fi

DATA=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LATITUDE&longitude=$LONGITUDE&current_weather=true") || (echo ""; exit 0)
TEMPERATURE=$(echo "$DATA" | jq '.current_weather.temperature')
# WIND=`echo $DATAj| jq '.current_weather.windspeed'`

ICON=""
COLOR="${white}"

echo $separator "%{F$COLOR}$ICON%{F-}  ${TEMPERATURE}"
