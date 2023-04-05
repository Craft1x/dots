#!/usr/bin/env bash
NOTIFIED=false
SUSPENDED=false

while true; do
  sleep 5
  DATA=$(cat /sys/class/power_supply/BAT0/capacity) || ( echo ""; return 0; )
  ISCHARGING=$(cat  | grep /sys/class/power_supply/BAT0/status -q Discharging && echo false || echo true)

  [[ "$ISCHARGING" = true ]] && continue

  if [ "$DATA" -lt 5 ]; then
    if [[ $SUSPENDED == false ]]; then
      SUSPENDED=true
      logger "Critical battery threshold"
      notify-send "Suspending" -i laptopattention
      systemctl suspend
    fi
  else
    SUSPENDED=false
  fi

  if [[ "$DATA" -lt 15 ]]; then
    if [[ $NOTIFIED == false ]]; then
      NOTIFIED=true
      notify-send "Low battery" -i laptopattention
      brillo -S 20
    fi
  else
    NOTIFIED=false
  fi

done
