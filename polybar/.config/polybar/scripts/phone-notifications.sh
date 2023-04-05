#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

DATA=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/8f54298fa462dd30/notifications org.freedesktop.DBus.Introspectable.Introspect | grep -c "<node name=") || ( echo ""; return 0; )


COLOR="${green}"
ICON="∙"

[[ $DATA == "0" ]] && echo "" || echo "%{F$COLOR}$ICON%{F-}"
