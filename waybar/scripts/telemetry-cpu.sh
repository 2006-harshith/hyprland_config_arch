#!/bin/bash
read -r _ user1 nice1 sys1 idle1 iowait1 irq1 softirq1 steal1 _ _ < /proc/stat
sleep 1
read -r _ user2 nice2 sys2 idle2 iowait2 irq2 softirq2 steal2 _ _ < /proc/stat

idle_delta=$(( (idle2 + iowait2) - (idle1 + iowait1) ))
total1=$((user1 + nice1 + sys1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
total2=$((user2 + nice2 + sys2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
total_delta=$((total2 - total1))

if [ "$total_delta" -eq 0 ]; then
    echo "▱▱▱▱ [ 0%]"
    exit 0
fi

cpu_pct=$(( (total_delta - idle_delta) * 100 / total_delta ))
if [ "$cpu_pct" -gt 100 ]; then cpu_pct=100; fi
if [ "$cpu_pct" -lt 0 ]; then cpu_pct=0; fi

filled=$((cpu_pct / 25))
empty=$((4 - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="▰"; done
for ((i=0; i<empty; i++)); do bar+="▱"; done

printf " %s [%2d%%]\n" "$bar" "$cpu_pct"
