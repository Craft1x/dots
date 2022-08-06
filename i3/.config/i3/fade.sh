#!/bin/bash
xrandr --output HDMI-A-0 --brightness 0
xrandr --output DisplayPort-0 --brightness 0

sleep 1

xrandr --output HDMI-A-0 --brightness 1
xrandr --output DisplayPort-0 --brightness 1

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
