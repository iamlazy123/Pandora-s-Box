#!/system/bin/sh
ui_print "=========================================================
               [-] SETTING PERMISSIONS.."
			       
set_perm_recursive "$MODPATH/system/bin" root root 0777 0755
ui_print "=========================================================
               [-] INSTALLING LAZY TWEAKS APK"
pm install $MODPATH/lazy.apk

# Do install=time script execution
ui_print "=========================================================
               [-] REBOOT IS RECOMMENDED."
ui_print "=========================================================
               [-] LOGS ARE LOCATED @ /SDCARD/ANDROID/LAZY.LOG."
ui_print "=========================================================
               [-] DONE. ENJOY!
=================================================================="