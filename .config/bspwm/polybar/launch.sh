#!/bin/bash
# Script for running polybar.
# Author: yaelooo

# DON'T EDIT THIS FILE
# IF YOU WANT TO CHANGE THE CONFIG FILE
# USE THE SHORTCUT KEY 'CTRL + ALT + P'
# OR RUN MANUALLY '$HOME/.config/bspwm/scripts/polybar'

# Config bar to launch
config="minimal"

# Function to launch polybar
launch_polybar() {
  polybar-msg cmd quit
  sed -i "/include-file = bars\//d" $HOME/.config/bspwm/polybar/.config.ini
  echo "include-file = bars/$config.ini" >>$HOME/.config/bspwm/polybar/.config.ini
  bars=$(grep -oP '\[bar/\K[^]]*' $HOME/.config/bspwm/polybar/bars/$config.ini | tr '\n' ' ')
  for bar in $bars; do
    polybar -c $HOME/.config/bspwm/polybar/.config.ini $bar &
  done
}

# Launch polybar with the given config
launch_polybar $config

# Send notification
case $1 in
"--restart")
  notify-send "Polybar" "Polybar has been restarted"
  ;;
"--change")
  notify-send "Polybar" "Bar $config has been changed"
  ;;
*) ;;
esac
