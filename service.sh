#!/system/bin/sh
while [[ `getprop sys.boot_completed` -ne 1 ]] && [[ ! -d "/sdcard" ]]
do
       sleep 1
done
#
sleep 120
# Setup tweaks
lazy

