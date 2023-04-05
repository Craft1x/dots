#!/usr/bin/env sh
title="Brightness"
icon="gpm-brightness-lcd"
brightness=$(brillo -q)

~/.config/i3/notify.sh $icon $brightness $title

