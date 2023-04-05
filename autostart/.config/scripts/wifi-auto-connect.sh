#!/usr/bin/env bash

LAST_PATH="$HOME/.cache/last-network"


while true; do
  # if no network is active
  if [[ ! $(nmcli device wifi | cut -d " " -f1 | grep "\*") ]]; then

    # check if user disconnected the network manually by reading logs
    [[ $(journalctl -u NetworkManager.service -n 100 --no-pager \
      | grep " -> " \
      | tail -n 1 \
      | grep "user-requested\|config") ]] \
      && sleep 5 && continue;

    nmcli device wifi rescan

    [[ -f "$LAST_PATH" ]] && LAST=$(cat "$LAST_PATH")

    # get list of all networks in range
    SSIDS=$(nmcli -f SSID dev wifi | tail +2 | sed '1 i\'"$LAST")

    for SSID in $SSIDS
    do
      echo "Trying: $SSID"
      if [[ $(nmcli device wifi connect "$SSID") ]]; then
        echo "Success"
        echo "$SSID" > "$LAST_PATH"
        break 
      else echo "Failed"
      fi
    done
  fi

  sleep 5
done
