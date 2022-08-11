#!/bin/bash
DIR=`mktemp -d`
notify-send "Processing..."
cfr "$1" --outputdir $DIR && nemo $DIR || notify-send "Fail"
