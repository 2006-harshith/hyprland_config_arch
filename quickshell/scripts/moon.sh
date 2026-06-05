#!/usr/bin/env bash

FRAME=$(lua ~/.config/moonphase/frame_calc.lua)

jq -r --argjson frame "$FRAME" '
.[ $frame ] |
"AGE=\(.age)",
"PHASE=\(.phase)",
"DISTANCE=\(.distance)",
"DIAMETER=\(.diameter)",
"RA=\(.j2000.ra)",
"DEC=\(.j2000.dec)",
"TIME=\(.time)"
' ~/.config/moonphase/mooninfo_2026.json