#!/usr/bin/env sh
title=`playerctl metadata title`
icon="pithos-tray-icon"
length=`playerctl metadata mpris:length`
position=`playerctl position`
percentage=`awk "BEGIN { print $position * 100000000 / $length }"`


~/.config/i3/notify.sh $icon $percentage "$title"
