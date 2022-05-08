#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

DATA=`echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]`
COLOR="${yellow}"

ICON=""

if [ $DATA -ge 85 ]; then
	ICON=""
elif [ $DATA -ge 68 ]; then
	ICON=""
elif [ $DATA -ge 51 ]; then 
	ICON=""
elif [ $DATA -ge 34 ]; then 
	ICON=""
elif [ $DATA -ge 17 ]; then 
	ICON=""
fi

echo "%{F$COLOR}$ICON%{F-} ${DATA}"
