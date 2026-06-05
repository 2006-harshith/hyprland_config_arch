#!/usr/bin/env bash

STATUS=$(playerctl status 2>/dev/null)

TITLE=$(playerctl metadata --format "{{title}}" 2>/dev/null)

ARTIST=$(playerctl metadata --format "{{artist}}" 2>/dev/null)

echo "STATUS=$STATUS"
echo "TITLE=$TITLE"
echo "ARTIST=$ARTIST"