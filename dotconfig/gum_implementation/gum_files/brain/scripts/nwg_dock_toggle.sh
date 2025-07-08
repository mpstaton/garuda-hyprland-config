#!/bin/bash
a=$(pidof nwg-dock-hyprland)
if [[ $a ]]
then
    killall -9 nwg-dock-hyprland
    notify-send "nwg-dock-hyprland"  "disabled"
else
    notify-send "nwg-dock-hyprland"  "enabled"
    nwg-dock-hyprland -x -p "left"  -i 24 -mt 10 -mb 10 -ml 5 -f
fi
