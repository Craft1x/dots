#!/usr/bin/env bash
DIR=`mktemp -d`
notify-send "Processing..."

cd "$DIR"

fernflower -hes=0 -hdc=0 "$1" "$DIR" && unzip *.jar && nemo $DIR || notify-send "Fail"

# cfr "$1" --outputdir $DIR && nemo $DIR || notify-send "Fail"
