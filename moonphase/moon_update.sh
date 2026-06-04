#!/usr/bin/env bash

set -e

MOON_DIR="$HOME/.config/moonphase"
CACHE="$MOON_DIR/cache"

mkdir -p "$CACHE"

CURRENT=$(lua "$MOON_DIR/frame_calc.lua")

PREV=$((CURRENT - 1))
NEXT=$((CURRENT + 1))

BASE_URL="https://svs.gsfc.nasa.gov/vis/a000000/a005500/a005587/frames/1920x1080_16x9_30p/plain"

download_frame() {

    FRAME="$1"

    PNG="$CACHE/${FRAME}.png"

    if [ -f "$PNG" ]; then
        echo "Frame $FRAME already cached"
        return
    fi

    PADDED=$(printf "%04d" "$FRAME")

    TIFF="$CACHE/${FRAME}.tif"

    URL="$BASE_URL/moon.${PADDED}.tif"

    echo "Downloading frame $FRAME"

    wget -q -O "$TIFF" "$URL"

    magick "$TIFF" "$PNG"

    rm "$TIFF"
}

# Ensure prev/current/next exist

download_frame "$PREV"
download_frame "$CURRENT"
download_frame "$NEXT"

# Delete everything except prev/current/next

for FILE in "$CACHE"/*.png
do
    [ -e "$FILE" ] || continue

    FRAME=$(basename "$FILE" .png)

    if [ "$FRAME" != "$PREV" ] &&
       [ "$FRAME" != "$CURRENT" ] &&
       [ "$FRAME" != "$NEXT" ]
    then
        echo "Deleting $FRAME"
        rm -f "$FILE"
    fi
done

# Set wallpaper

CURRENT_WALLPAPER="$CACHE/${CURRENT}.png"

echo "Setting wallpaper -> $CURRENT"

hyprctl hyprpaper wallpaper ",$CURRENT_WALLPAPER"

echo "Done"