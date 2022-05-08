#!/bin/bash
OUT=`playerctl -p "" status 2>&1`
[[ $OUT == "No players found" ]] && echo "Nothing" || echo $OUT
