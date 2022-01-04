#!/bin/bash
for file in "$@"
do
	jpegoptim -m 40 "$file" || notify-send "Error Compressing"
done
