#!/usr/bin/env bash

case "$1" in
  "toggle")
    pgrep picom && ~/.config/i3/activatecompositor.sh false || ~/.config/i3/activatecompositor.sh true
    ;;

  "true")
    picom --backend glx -b
    ;;

  "false")
    pkill picom
    # rerender every window
    # WID=`xdo id` && xdo activate -d && xdo activate $WID
    ;;
esac
