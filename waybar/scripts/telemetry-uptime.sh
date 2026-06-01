#!/bin/bash
uptime_sec=$(awk '{print int($1)}' /proc/uptime)
hours=$((uptime_sec / 3600))
minutes=$(( (uptime_sec % 3600) / 60 ))
printf "T+%02d:%02d\n" "$hours" "$minutes"
