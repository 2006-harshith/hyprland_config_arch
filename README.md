This repo contains all the dotfiles of my custom hyprland look in arch linux. 

# Wallpaper 

I built a custom dynamic wallpaper that showcases the Moon's current appearance. It reflects the Moon's real-time phase, libration, illumination, orientation, and visible surface features based on the current time.
In simple words, it will show the Moon's real-world appearance. 

```
moonphase/
├── cache/                 
│   ├── 3591.png           
│   ├── 3592.png           
│   └── 3593.png           
│
├── frame_calc.py          
├── moon_update.sh         
├── mooninfo_2026.json     
└── setup_timer.sh         
```

## How it works:
Pipeline of the process: 
- **Frame collection** <br>
*frame_calc.py*  will  calculate the frame number using the current utc timestamp (year, month, day, date, hour). 

- **image retrieval** <br>
using the frame number generated using frame_calc.py, we can determine and download the exact Image from the NASA Scientific Visualization Studio. 
*moon_update.sh* script will use frame_calc, get the frame number, download the .tif file for next frame , convert it to png using magick tool to convert tif file to png file, use hyprpaper to change the wallpaper. 

- **Cache management** 

A rolling cache is maintained containing:

    -   Previous frame (`frame - 1`)
    -   Current frame (`frame`)
    -   Next frame (`frame + 1`)

Missing frames are downloaded automatically.
Outdated frames are removed to keep the cache lightweight <br>

- **systemd service and systemd timer**

A systemd user timer runs `moon_update.sh` automatically:

On login/startup
At the beginning of every hour
Because the current frame is always recalculated from UTC time, the system automatically recovers from Reboots, Shutdowns, Sleep/Suspend states, Missed update intervals

No manual synchronization is required.



