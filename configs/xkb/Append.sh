#!/bin/sh

effuid=`id -u`

if ! [ $effuid = 0 ]; then
  echo "Must be run as root"
  exit 1
fi

cat DeFrKz | tee -a /usr/share/X11/xkb/symbols/kz
# cat kz | tee -a /usr/share/X11/xkb/symbols/kz
# cat de | tee -a /usr/share/X11/xkb/symbols/de

vi evdev.xml /usr/share/X11/xkb/rules/evdev.xml extra /usr/share/X11/xkb/types/extra
