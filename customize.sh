#!/system/bin/sh
ui_print "[*] Setting executable permissions..."
set_perm_recursive "$MODPATH/system/bin" root root 0777 0755
set_perm_recursive "$MODPATH/system/vendor" root root 0777 0644

# Do install-time script execution
ui_print "Reboot is recommended.for universal, use download terminal app and 
use su -c lazy command since some roms doesnt support autorun scripts"
ui_print "[i] NOTICE: TO SEE LOGS TYPE su -c lazy > /sdcard/lazy.log
    ------------------------------------------------------------------------------"
