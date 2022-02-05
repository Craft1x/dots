#!/usr/bin/env bash

source "$HOME/.config/polybar/scripts/source-colors.sh" 

PRICE=`curl -s http://api.coindesk.com/v1/bpi/currentprice.json | jq -r '.bpi.USD.rate' | cut -d "." -f1`|| (echo ""; exit 0)

[ -e $PRICE ] && (echo ""; exit 0)
 

icon_color="${yellow}"

echo $separator%{A1:xdg-open "https\://finance.yahoo.com/quote/BTC-USD":} "%{F$icon_color}""₿""%{F-}" $PRICE %{A-}
