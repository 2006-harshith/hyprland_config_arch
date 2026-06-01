#!/bin/bash
mem_total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
mem_avail=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

if [ "$mem_total" -eq 0 ]; then
    echo "▱▱▱▱ [ 0%]"
    exit 0
fi

mem_used=$((mem_total - mem_avail))
mem_pct=$((mem_used * 100 / mem_total))
if [ "$mem_pct" -gt 100 ]; then mem_pct=100; fi

filled=$((mem_pct / 25))
empty=$((4 - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="▰"; done
for ((i=0; i<empty; i++)); do bar+="▱"; done

printf " %s [%2d%%]\n" "$bar" "$mem_pct"
