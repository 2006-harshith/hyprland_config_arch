#!/usr/bin/env bash

JSON=$(wayweather -g)

TEMP=$(echo "$JSON" | jq -r '.text')
TOOLTIP=$(echo "$JSON" | jq -r '.tooltip')

HUMIDITY=$(echo "$TOOLTIP" | grep "Humidity:" | sed 's/Humidity: //')
CLOUDS=$(echo "$TOOLTIP" | grep "Cloud Cover:" | sed 's/Cloud Cover: //')
WIND=$(echo "$TOOLTIP" | grep "Wind Speed:" | sed 's/Wind Speed: //')

echo TEMP=$(echo "$JSON" | jq -r '.text' | sed 's/<[^>]*>//g')
echo "HUMIDITY=$HUMIDITY"
echo "CLOUDS=$CLOUDS"
echo "WIND=$WIND"