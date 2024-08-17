#!/usr/bin/env bash

# not working

/usr/lib/firefox-developer-edition/firefox  --class hidden_window_firefox  -private-window  -profile $FIREFOX_PROFILE &

while :
do
  xdotool search --sync --title "hidden_window_firefox" |  xargs -L1 xdotool windowunmap
done
