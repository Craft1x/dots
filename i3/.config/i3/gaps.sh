#!/usr/bin/env bash

CURRENT=$(i3-msg -t get_workspaces | jq ".[] | select(.focused | IN(true))")
HEIGHT=$(echo "$CURRENT" | jq  ".rect.height")

dp ()
{
  echo $(("$HEIGHT" * $1 / 100))
}

OPTION=$1
case $OPTION in
  default)
    i3-msg gaps outer current set 0, gaps inner current set 15
    ;;

  compact)
    i3-msg gaps outer current set 0, gaps inner current set 0
    ;;

  horizontal)
    i3-msg gaps horizontal current set 0, \
      gaps inner current set 10, \
      gaps vertical current set `dp 16`
          ;;

  vertical)
    i3-msg gaps vertical current set 0, \
      gaps inner current set 20, \
      gaps horizontal current set `dp 40`
          ;;

  classic)
    i3-msg gaps vertical current set 0, \
      gaps inner current set 20, \
      gaps horizontal current set `dp 24`
          ;;

  sided)
    i3-msg gaps outer current set 0, \
      gaps inner current set 20, \
      gaps right current set `dp 65` 
          ;;

  zoomed)
    i3-msg gaps outer current set `dp 17`, gaps inner current set 8
    ;;

  spaced)
    i3-msg gaps outer current set 0, gaps inner current set `dp 10`
    ;;

  *)

echo "unknown option"
exit 1
esac
