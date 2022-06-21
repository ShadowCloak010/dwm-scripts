#!/bin/bash


# set desktop wallpaper
feh --bg-fill ~/Pictures/pop.jpg

# disable opacity for the window of input method
#xwininfo -name 'Fcitx5 Input Window' | sed -r -n -e 's/.+Window\sid:\s(.+?)\s".+/\1/p' | xargs picom-trans -o 100 -w

# mouse

## laptop
### xinput --set-prop 'Asus TouchPad' 'libinput Tapping Enabled' 1
### xinput --set-prop 'Asus TouchPad' 'libinput Accel Speed' 1
## pc
### mouse speed
xinput --set-prop 'SIGMACHIP Usb Mouse' 'libinput Accel Speed' 1

# notifications server
dunst &

# input method
fcitx5 &

# auto locking screen
#xautolock -time 15 -locker slock &

