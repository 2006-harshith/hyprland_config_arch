#!/bin/bash
strength=$(nmcli -t -f SIGNAL,ACTIVE dev wifi | awk -F: '$2=="yes"{print $1}')

if [ -z "$strength" ]; then
    echo "SIGNAL ░░░░░░░░░░ --"
    exit 0
fi

filled=$((strength / 10))
empty=$((10 - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

printf "SIGNAL %s %2d%%\n" "$bar" "$strength"
