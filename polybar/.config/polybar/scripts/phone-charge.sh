#!/usr/bin/env sh
DATA=`qdbus org.kde.kdeconnect /modules/kdeconnect/devices/8f54298fa462dd30/battery org.kde.kdeconnect.device.battery.charge` || ( echo ""; return 0; )
ISCHARGING=`qdbus org.kde.kdeconnect /modules/kdeconnect/devices/8f54298fa462dd30/battery org.kde.kdeconnect.device.battery.isCharging`

COLOR="#60BAEC"
SEPCOLOR="#3F5360"
ICON=""

if [ $DATA -ge 95 ]; then
	ICON=""
elif [ $DATA -ge 80 ]; then
	ICON=""
elif [ $DATA -ge 60 ]; then 
	ICON=""
elif [ $DATA -ge 40 ]; then 
	ICON=""
elif [ $DATA -ge 20 ]; then 
	ICON=""
fi

if [ $ISCHARGING = true ]; then
	COLOR="#FFCB6B"
fi


echo "%{F$SEPCOLOR}|%{F-} %{F$COLOR}$ICON%{F-}  ${DATA}%"
