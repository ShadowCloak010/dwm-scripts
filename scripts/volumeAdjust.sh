#!/bin/bash


if [[ -z $1 ]]; then
    echo have not got params
    exit 1
fi

getStatus(){
    curStatus=(`pulseaudio-ctl full-status`)
    curVolume=${curStatus[0]}
    outputMute=${curStatus[1]}
    inputMute=${curStatus[2]}
}

case $1 in
    "+") action="up";;
    "-") action="down";;
    *)
        dunstify -u critical "Unknown action: ${1}";exit 1;;
esac

pulseaudio-ctl $action
getStatus
dunstify -u low "${curVolume}%"
mpv ~/.dwm/scripts/pop.mp3

#echo "${curVolume}:${outputMute}:${inputMute}"

