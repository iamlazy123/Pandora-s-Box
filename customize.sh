#!/system/bin/sh
# Written by Draco (tytydraco @ GitHub)

ui_print "[*] Setting executable permissions..."
set_perm_recursive "$MODPATH/system/bin" root root 0777 0755
set_perm_recursive "$MODPATH/system/vendor" root root 0777 0644

# Do install-time script execution
ui_print "DONT FORGET TO INSTALL BUSYBOX! :)"
ui_print "Reboot is needed. PLS READ LAZY.LOG AFTER REBOOT."
ui_print "[i] NOTICE: PLEASE WAIT FOR 2-3 MINUTES BEFORE APPLYING TO AVOID LAZY BEING OVERWRITTEN
[*] YOU CAN CHANGE MODE WHILE WAITING BY CHANGING MODE.TXT AT /SDCARD/mode.txt
    ------------------------------------------------------------------------------
MODES:
0-LAZY -(balanced 1-3 profiles)
1-GAMING -(maximum settings for gaming)
2-MULTITASKING-(maximum settings for multitasking)
3-POWER SAVE-(battery loving mode with little care to performance)
    ------------------------------------------------------------------------------
PLS AVOID USING OTHER MODULES AS MUCH AS POSSIBLE. "
