#!/usr/bin/env sh
DATA=`curl -s http://192.168.1.47:1337/getData`
P30=`echo $DATA | cut -d " " -f3`
P100=`echo $DATA | cut -d " " -f6`

ICON=""
COLOR="#61C766"

if [ $P100 -ge 3200 ] || [ $P30 -ge 3300 ]; then
	ICON=""
	COLOR="#EC7875"
elif [ $P100 -ge 200 ] && [ $P30 -ge $P100 ]; then
	COLOR="#61C766"
elif [ $P100 -ge 200 ]; then
	COLOR="#FFCB6B"
fi


echo "%{F$COLOR}$ICON%{F-} ${P30}W"
