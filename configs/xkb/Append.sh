#!/bin/sh

effuid=`id -u`

if ! [ $effuid = 0 ]; then
  echo "Must be run as root"
  exit 1
fi

cat kz | tee -a /usr/share/X11/xkb/symbols/kz
cat we | tee -a /usr/share/X11/xkb/symbols/us

vi evdev.xml /usr/share/X11/xkb/rules/evdev.xml