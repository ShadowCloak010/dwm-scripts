#!/bin/bash

prefix="${HOME}/.dwm/scripts"

# system
/bin/bash ${prefix}/system.sh &

# status bar
/bin/bash ${prefix}/statusBar.sh &

# Pomodoro
/bin/bash ${prefix}/pomodoro/main.sh &

