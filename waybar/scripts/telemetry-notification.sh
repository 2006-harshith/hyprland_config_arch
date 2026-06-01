#!/bin/bash
count=$(swaync-client -c 2>/dev/null)

if [ -z "$count" ] || ! [[ "$count" =~ ^[0-9]+$ ]]; then
    count=0
fi

dnd=$(swaync-client -D 2>/dev/null)

if [ "$dnd" = "true" ]; then
    class="dnd"
else
    if [ "$count" -gt 0 ]; then
        class="notification"
    else
        class="none"
    fi
fi

printf '{"text": "MSG[%d]", "alt": "%s", "tooltip": "%d notification(s)", "class": "%s"}\n' "$count" "$class" "$count" "$class"
