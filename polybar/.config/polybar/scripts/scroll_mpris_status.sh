#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

cmd_match="$HOME/.config/polybar/scripts/cached-player-match.sh"
cmd="$HOME/.config/polybar/scripts/cached-player-info.sh"

icon_color="${green}"
icon_color_pause="${cyan}"


# use this to debug high cpu usage:
# dbus-monitor --system

# exit 1

zscroll -l 50 --before-text "♪ " --after-text " $separator" --delay 0.15  \
  --match-command "$cmd_match" \
  --match-text "Playing" "--before-text '%{F$icon_color}%{F-} '" \
  --match-text "Paused" "--before-text '%{F$icon_color_pause}契%{F-} '" \
  --match-text "Nothing" "--before-text '' --after-text ''" \
  --update-check true "$cmd" \
  --update-interval=0.2 &

wait
