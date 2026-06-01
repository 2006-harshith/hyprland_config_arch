#!/bin/bash
vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [ -z "$vol_info" ]; then
    echo "COMMS ░░░░░░░░░░ --"
    exit 0
fi

if echo "$vol_info" | grep -q "MUTED"; then
    echo "COMMS ░░░░░░░░░░ MT"
    exit 0
fi

volume=$(echo "$vol_info" | awk '{printf "%d", $2 * 100}')
if [ "$volume" -gt 100 ]; then volume=100; fi

filled=$((volume / 10))
empty=$((10 - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

printf "COMMS %s %2d%%\n" "$bar" "$volume"
