#!/usr/bin/env sh
bar=$(seq -s "─" 0 $((volume / 5)) | sed 's/[0-9]//g')
 dunstify -i "$1" -r 5555 -u normal -h int:value:"$2"  "$3"
