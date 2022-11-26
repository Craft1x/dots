#!/bin/bash

[ -f /tmp/player-selected ] && PLAYER=$(cat /tmp/player-selected) && playerctl -p $PLAYER status || rm -f /tmp/player-selected

[ -z $PLAYER ] && OUT=`playerctl status 2>&1` || OUT=`playerctl -p $PLAYER status 2>&1`


[[ $OUT == "No players found" ]] && echo "Nothing" || echo $OUT
