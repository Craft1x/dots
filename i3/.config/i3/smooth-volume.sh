#!/usr/bin/env bash

VOLUME_MAX=130

SINK_OR_SOURCE="ink"

VOLUME_STEP=1

function getCurNode() {
    if ! pactl info &>/dev/null; then return 1; fi
    local curNodeName

    curNodeName=$(pactl info | awk "/Default S${SINK_OR_SOURCE}: / {print \$3}")
    curNode=$(pactl list s${SINK_OR_SOURCE}s | grep -B 4 -E "Name: $curNodeName\$" | sed -nE "s/^S${SINK_OR_SOURCE} #([0-9]+)$/\1/p")
}

function getCurVol() {
    VOL_LEVEL=$(pactl list s${SINK_OR_SOURCE}s | grep -A 15 -E "^S${SINK_OR_SOURCE} #$1\$" | grep 'Volume:' | grep -E -v 'Base Volume:' | awk -F : '{print $3; exit}' | grep -o -P '.{0,3}%' | sed 's/.$//' | tr -d ' ')
}

function volUp() {
    if ! getCurNode; then
        echo "PulseAudio not running"
        return 1
    fi
    getCurVol "$curNode"
    local maxLimit=$((VOLUME_MAX - VOLUME_STEP))

    STEP=$VOLUME_STEP

    if [ -f "/tmp/shift" ]; then
      STEP=5
    fi

    if [ "$VOL_LEVEL" -le "$VOLUME_MAX" ] && [ "$VOL_LEVEL" -ge "$maxLimit" ]; then
        pactl set-s${SINK_OR_SOURCE}-volume "$curNode" "$VOLUME_MAX%"
    elif [ "$VOL_LEVEL" -lt "$maxLimit" ]; then
        pactl set-s${SINK_OR_SOURCE}-volume "$curNode" "+$STEP%"
    fi
}


function volDown() {
    if ! getCurNode; then
        echo "PulseAudio not running"
        return 1
    fi

    getCurVol "$curNode"

    STEP=$VOLUME_STEP

    if [ -f "/tmp/shift" ]; then
      STEP=5
    fi

    pactl set-s${SINK_OR_SOURCE}-volume "$curNode" "-$STEP%"
  }

function volMute() {
    if ! getCurNode; then
        echo "PulseAudio not running"
        return 1
    fi

    pactl set-s${SINK_OR_SOURCE}-mute "$curNode" "toggle"
}


case "$1" in
    up)
        volUp
        ;;
    down)
        volDown
        ;;
    mute)
        volMute
        ;;
esac
