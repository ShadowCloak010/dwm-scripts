#!/bin/bash


pulseaudio-ctl mute

curStatus=(`pulseaudio-ctl full-status`)
outputMuteStatus=${curStatus[1]}

case $outputMuteStatus in
    "yes") msg="mute";;
    "no") msg="unmute";;
    "*") msg="unknown output status: $outputMuteStatus";;
esac

dunstify -u low "$msg"

