#!/bin/bash
DISP=$(xrandr --listmonitors | tail -n +2 | tr -s " " | cut -d " " -f5)

setBrightness ()
{
  for D in $DISP
  do
    xrandr --output $D --brightness $1
  done
}

setBrightness 0

sleep 1

setBrightness 1

#
# xrandr --output HDMI-A-0 --brightness 0
# xrandr --output DisplayPort-0 --brightness 0
# sleep 1
# for ((i=1;i<100;i+=5)); 
# do 
#   val="0.`printf '%02d' $i`"
#   xrandr --output HDMI-A-0 --brightness $val
#   xrandr --output DisplayPort-0 --brightness $val
#   sleep 0.01666
# done
#
# xrandr --output HDMI-A-0 --brightness 1
# xrandr --output DisplayPort-0 --brightness 1
