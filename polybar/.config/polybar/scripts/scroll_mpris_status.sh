#!/bin/bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

cmd="${0%/*}/get_mpris_status.sh $1" 

# zscroll -l 900 \
#     --scroll-padding "$(printf ' %.0s' {1..8})" \
#     -d 0.5 \
#     -M "$cmd icon" \
#     -m "none"       "-b ''" \
#     -m "browser"    "-b ' '" \
#     -m "netflix"    "-b 'ﱄ '" \
#     -m "youtube"    "-b ' '" \
#     -m "prime"      "-b ' '" \
#     -m "spotify"    "-b ' '" \
#     -m "vlc"        "-b '嗢 '" \
#     -m "mpv"        "-b ' '" \
#     -m "kdeconnect" "-b ' '" \
#     -m "corridor"   "-b ' '" \
#     -U 1 -u t "$cmd" &

icon_color="${green}"
icon_color_pause="${cyan}"

zscroll -l 50 --before-text "♪ " --after-text " $separator" --delay 0.2  \
  --match-command "playerctl -p \"\" status" \
  --match-text "Playing" "--before-text '%{F$icon_color}%{F-} '" \
  --match-text "Paused" "--before-text '%{F$icon_color_pause}契%{F-} '" \
  --update-check true "$cmd" &

wait
