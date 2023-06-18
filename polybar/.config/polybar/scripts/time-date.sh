#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

ICON=""
COLOR="${brightRed}"
COLOR2="${foreground}"
COLOR3="${foreground}"
COLOR4="${yellow}"

while true; do
DATE=$(date "+%d")
WEEKDAY=$(date "+%a")
MONTH=$(date "+%b")
TIME=$(date "+%I:%M %p")

echo "$separator%{A1:gnome-calendar:} \
%{F$COLOR}$ICON%{F-} \
%{F$COLOR2}$WEEKDAY%{F-} \
%{F$COLOR2}$DATE%{F-} \
%{F$COLOR3}${MONTH}%{F-} \
%{F$COLOR4}%{T1}${TIME}%{A}%{T-}%{F-}"

sleep 60
done
