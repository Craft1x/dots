#!/bin/bash

LOCATION="$HOME/.cache/file_history"

FILE=`basename "$1"`

rm -fr $LOCATION
mkdir -p $LOCATION

find /.snapshots -mindepth 1 -maxdepth 1 -printf "%A@ %f\0" | 
  sort -rnz | 
  sed -z 's/^[0-9.]\+ //' |
  while IFS= read -r -d '' filename
  do 
    NEWFILE="/.snapshots/""$filename""$1"

    echo $NEWFILE

    if [ -f "$NEWFILE" ] || [ -d "$NEWFILE" ]; then
      mkdir "$LOCATION/""$filename"
      ln  -s "$NEWFILE" "$LOCATION"'/'"$filename"'/'"$FILE"
    fi
  done

nemo "$LOCATION"
