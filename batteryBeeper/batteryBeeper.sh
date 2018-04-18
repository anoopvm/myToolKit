#!/bin/bash

ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)

BATTERY_STATUS=`cat /sys/class/power_supply/BAT1/capacity`
echo $BATTERY_STATUS
if [ $BATTERY_STATUS -lt 20 ]
then
   echo $ac_adapter
   if [ "$ac_adapter" = "off" ]
   then
       notify-send "Low Battery!!"
       while [ "$ac_adapter" = "off" ]
       do
           echo $ac_adapter
           play -n synth 0.1 sine 800 vol 0.5
           ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
       done
       notify-send "Charging..."
   fi
   #paplay /usr/share/sounds/ubuntu/ringtones/Alarm*ck.ogg -vvv & 
fi
