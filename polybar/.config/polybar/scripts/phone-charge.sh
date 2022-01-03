#!/usr/bin/env sh
DATA=`qdbus org.kde.kdeconnect /modules/kdeconnect/devices/8f54298fa462dd30/battery org.kde.kdeconnect.device.battery.charge` || ( echo ""; return 0; )

#TODO improve this	
ICON=""
COLOR="#4dd0e1"
SEPCOLOR="#3F5360"

echo "%{F$SEPCOLOR}|%{F-} %{F$COLOR}$ICON%{F-}  ${DATA}%"
