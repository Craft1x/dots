#!/usr/bin/env bash

if [[ $(xrandr --verbose | grep "1.0:1.0:1.0") ]]; then
  redshift -O 3600
  hsetroot -solid "#000000"
else
  redshift -x
  ~/.config/nitrogen/set-random-wallpaper.sh
fi
