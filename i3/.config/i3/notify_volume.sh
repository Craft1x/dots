#!/usr/bin/env sh
title="Volume"
icon="audio-volume-high"
volume=$(pamixer --get-volume)

ismute=$(pamixer --get-mute)

if [ "$ismute" = "true" ]; then
	icon="audio-volume-muted"
fi

~/.config/i3/notify.sh $icon "$volume" $title

