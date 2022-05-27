#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

DATA=`cat /sys/class/power_supply/BAT0/capacity` || ( echo ""; return 0; )
ISCHARGING=`cat /sys/class/power_supply/BAT0/status | grep -q Discharging && echo false || echo true`

COLOR="${green}"
SEPCOLOR="#3F5360"
ICON=""

if [ $DATA -ge 95 ]; then
	ICON=""
elif [ $DATA -ge 85 ]; then
	ICON=""
elif [ $DATA -ge 75 ]; then 
	ICON=""
elif [ $DATA -ge 65 ]; then 
	ICON=""
elif [ $DATA -ge 55 ]; then 
	ICON=""
elif [ $DATA -ge 45 ]; then 
	ICON=""
elif [ $DATA -ge 35 ]; then 
	ICON=""
elif [ $DATA -ge 25 ]; then 
	ICON=""
elif [ $DATA -ge 15 ]; then 
	ICON=""
elif [ $DATA -ge 5 ]; then 
	ICON=""
fi

if [ $ISCHARGING = true ]; then
if [ $DATA -ge 95 ]; then
	ICON=""
elif [ $DATA -ge 80 ]; then
	ICON=""
elif [ $DATA -ge 65 ]; then 
	ICON=""
elif [ $DATA -ge 50 ]; then 
	ICON=""
elif [ $DATA -ge 35 ]; then 
	ICON=""
elif [ $DATA -ge 20 ]; then 
	ICON=""
elif [ $DATA -ge 5 ]; then 
	ICON=""
fi

fi


echo "$separator %{F$COLOR}$ICON%{F-} ${DATA}"
