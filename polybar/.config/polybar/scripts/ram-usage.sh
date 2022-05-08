#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

num=`cat  /proc/meminfo | grep MemAvailable | tr -s " " | cut -d " " -f 2`;

DATA=`awk -v n=$num 'BEGIN {printf "%.1f", (n/1000000)}'`

min=$(echo $DATA 1 | awk '{if ($1 < $2) print 1; else print 0}')

ICON="﫭"
COLOR="${green}"

if [ $min -eq 1 ]; then
	ICON=""
        COLOR="${red}"
fi


echo "$separator %{F$COLOR}$ICON%{F-} ${DATA}"
