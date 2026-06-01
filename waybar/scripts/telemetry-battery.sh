#!/bin/bash
bat_path=""
for p in /sys/class/power_supply/BAT0 /sys/class/power_supply/BAT1 /sys/class/power_supply/BAT2; do
    if [ -f "$p/capacity" ]; then
        bat_path="$p"
        break
    fi
done

if [ -z "$bat_path" ]; then
    echo "CORE ██████████ AC"
    exit 0
fi

capacity=$(cat "$bat_path/capacity")
if [ "$capacity" -gt 100 ]; then capacity=100; fi

filled=$((capacity / 10))
empty=$((10 - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

printf "|CORE| %s %2d%%\n" "$bar" "$capacity"
