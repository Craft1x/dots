#!/usr/bin/env bash

case "$1" in
  "true")
    picom --backend glx -b
    ;;

  "false")
    pkill picom
    # rerender every window
    # WID=`xdo id` && xdo activate -d && xdo activate $WID
    ;;
esac
