#!/usr/bin/env sh
PLAYER=`playerctl --list-all`
[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected)

title=`playerctl -p $PLAYER metadata title`
icon="pithos-tray-icon"
length=`playerctl -p $PLAYER metadata mpris:length`
position=`playerctl -p $PLAYER position`
percentage=`awk "BEGIN { print $position * 100000000 / $length }"`


~/.config/i3/notify.sh $icon $percentage "$title"
