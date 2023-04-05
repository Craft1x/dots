#!/usr/bin/env bash

IP_ADRESS=`hostname -I | awk '{print $1}'`
notify-send --icon=mail-send-receive "URL: "$IP_ADRESS":9090"
woof -p 9090 "$1"  


