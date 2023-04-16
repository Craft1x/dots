#!/usr/bin/env bash

mkdir -p /tmp/hidden_window_nemo
nemo /tmp/hidden_window_nemo  &

xdotool search --sync --name "hidden_window_nemo" | tail -n 1 | xargs -I _ xdotool windowunmap _
