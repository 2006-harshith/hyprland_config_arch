#!/usr/bin/env python3

from datetime import datetime, timezone

start = datetime(2026,1,1,tzinfo=timezone.utc)
now = datetime.now(timezone.utc)
hours = int((now - start).total_seconds() // 3600)
frame = hours + 1

print(frame)

# frame_str = f"{frame:04d}"

# url = (
#     "https://svs.gsfc.nasa.gov/vis/"
#     "a000000/a005500/a005587/"
#     "frames/1920x1080_16x9_30p/plain/"
#     f"moon.{frame_str}.tif"
# )

# print(url)