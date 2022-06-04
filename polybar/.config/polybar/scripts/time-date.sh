#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 
# label = %{T2}%{T-}%{A1:gnome-calendar:} %date% %{F#ffd88e}%time%%{F-} %{A}

ICON=""
COLOR="${pink}"
COLOR2="${foreground}"
COLOR3="${foreground}"
COLOR4="${yellow}"

DATE=`date "+%d"`
MONTH=`date "+%b"`
TIME=`date "+%I:%M %p"`
# label = %{T2}%{T-} %date% %{F#ffd88e}%time%%{F-} 

echo "$separator%{A1:gnome-calendar:} \
%{F$COLOR}$ICON%{F-} \
%{F$COLOR2}$DATE%{F-} \
%{F$COLOR3}${MONTH}%{F-} \
%{F$COLOR4}%{T1}${TIME}%{A}%{T-}%{F-}"
