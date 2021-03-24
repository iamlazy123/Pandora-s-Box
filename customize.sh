#!/system/bin/sh
ui_print ""
ui_print " Pandora's Box Installing..."
ui_print ""
ui_print " Setting executable permissions..."
set_perm_recursive "$MODPATH/system/bin" root root 0777 0755
ui_print "[-] for flexible installation, open to terminal, type su -c pan then press enter"
ui_print " Have a nice day.. "
