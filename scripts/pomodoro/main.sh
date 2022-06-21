#!/bin/bash


# props
pomodoroTime=$(( 60 * 30 ))
RelaxTime=$(( 40 ))

while [[ true ]]; do
	sleep $pomodoroTime
	dunstify -t 10000 'The pause came'
	mpv "${HOME}/.dwm/scripts/pomodoro/pause.mp3" &>/dev/null
	sleep $RelaxTime
	dunstify -t 10000 'Back to work'
	mpv "${HOME}/.dwm/scripts/pomodoro/resume.mp3" &>/dev/null
done

