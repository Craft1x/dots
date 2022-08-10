#!/bin/bash

case "$1" in
  "set") 
    [ -f ~/.cache/i3-border ] && OLDVAL=`cat ~/.cache/i3-border` || OLDVAL="#ffc999"
    sed -i "s/^\(set\s*\$bg-color\s*\).*\$/\1$OLDVAL/" ~/.config/i3/config
    i3-msg reload
    ;;
  "next") 
    IMAGE=~/.cache/nitrogen/1.jpg
    convert $IMAGE -resize 50 /tmp/image.jpg
    IMAGE=/tmp/image.jpg
    area=$(magick $IMAGE -format "%[fx:w*h]" info:) 
    VAL=$(magick $IMAGE -kmeans 10 -format "%c" histogram:info:  | sed 's/://g' | awk -v area=$area '{print 100*$1/area, "%,", $3}' | sed 's/ *//g' | sort -nr -k1,1 -t "," | tail -n 1 | cut -d "," -f2)
    VAL=$(~/.config/i3/lighten_color.py $VAL)
    echo $VAL > ~/.cache/i3-border
    ;;
esac
