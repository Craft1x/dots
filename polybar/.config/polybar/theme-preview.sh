#!/bin/bash
themes=($(ls ./themes))
# Initialize the current theme variable with the first theme in the array
while true; do
    if [[ $# -eq 1 ]]; then
        choice=$1
    else
        for (( i=0; i<${#themes[@]}; i++ )); do
            echo "$((i+1)). ${themes[$i]}"
        done
        echo "0. Random"

        # Print the current theme
        echo "Current theme: $current $curnum"
        read -p "Choose a theme number: " choice
    fi

    if [[ $choice -eq 0 ]]; then
        # Pick a random theme from the array
        choice=$((RANDOM % ${#themes[@]} + 1))
    elif [[ $choice -gt ${#themes[@]} ]]; then
        echo "Invalid choice"
        continue # Skip the rest of the loop and ask again
    fi

    file=${themes[$((choice-1))]}
    echo $file
    rm -f "$PWD/colors.ini"
    cp "./themes/$file" "$PWD/colors.ini"
    ./launch.sh >/dev/null 2>&1
    # Update the current theme variable with the chosen theme
    current=$file
    curnum=$choice
done
