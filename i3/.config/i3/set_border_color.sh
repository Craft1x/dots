#!/bin/bash

IMAGE=~/.cache/nitrogen/current_bg_image.jpg
convert $IMAGE -resize 50 /tmp/image.jpg
IMAGE=/tmp/image.jpg
area=$(magick $IMAGE -format "%[fx:w*h]" info:) 
VAL=$(magick $IMAGE -kmeans 10 -format "%c" histogram:info:  | sed 's/://g' | awk -v area=$area '{print 100*$1/area, "%,", $3}' | sed 's/ *//g' | sort -nr -k1,1 -t "," | tail -n 1 | cut -d "," -f2)

VAL=$(~/.config/i3/lighten_color.py $VAL)

sed -i "s/^\(set\s*\$bg-color\s*\).*\$/\1$VAL/" ~/.config/i3/config

# echo $VAL

i3-msg reload
