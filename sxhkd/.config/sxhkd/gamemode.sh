#!/usr/bin/env bash

CONFIG="$HOME/.config/sxhkd"

ENABLED=$(head -n 1 ~/.config/sxhkd/sxhkdrc | grep -q gamemode && echo 1 || echo 0)

enable() {
  notify-send -r 69360 -i "$HOME/.config/sxhkd/icons/games.svg" "Game mode : on"
  mv "$CONFIG/sxhkdrc" "$CONFIG/sxhkdrc-normal"
  cp "$CONFIG/sxhkdrc-game" "$CONFIG/sxhkdrc"
  bash ~/.config/sxhkd/launch.sh
  pgrep picom && ~/.config/i3/activatecompositor.sh false
}

disable() {
  notify-send -r 69360 -i "$HOME/.config/sxhkd/icons/games.svg" "Game mode : off"
  mv "$CONFIG/sxhkdrc-normal" "$CONFIG/sxhkdrc"
  bash ~/.config/sxhkd/launch.sh

  pgrep picom || ~/.config/i3/activatecompositor.sh true
}

toggle() {
  echo "$ENABLED"
  [[ $ENABLED == "1" ]] && disable || enable
}


[[ "$1" == "toggle" ]] && toggle

[[ "$1" == "enable" ]] && enable

[[ "$1" == "disable" ]] && disable

