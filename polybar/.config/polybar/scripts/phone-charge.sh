#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

ID="8f54298fa462dd30"

DATA=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/$ID/battery org.kde.kdeconnect.device.battery.charge) ||  (echo "" && exit 0);
ISCHARGING=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/$ID/battery org.kde.kdeconnect.device.battery.isCharging)

if [ "$DATA" -le 0 ]; then
  echo "" && exit 0; 
fi

COLOR="${green}"
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

FINDCOMMAND="qdbus org.kde.kdeconnect /modules/kdeconnect/devices/$ID/findmyphone org.kde.kdeconnect.device.findmyphone.ring"

echo $separator %{A1:$FINDCOMMAND:}%{F$COLOR}$ICON%{F-} ${DATA}%{A}
