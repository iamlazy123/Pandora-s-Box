#!/system/bin/sh

# Android version selection;
if [[ -f "/sys/kernel/debug/sched_features" ]]
then
w=1
ui_print " "
ui_print " - It seems like your kernel supports enabling HRTICK - "
ui_print "---------------------------------------------------"
ui_print "-                                                 -"
ui_print "-    HRTICK greatly improves latency but          -"
ui_print "-    if not supported by your device,             -"
ui_print "-           could cause problems.                 -"
ui_print "---------------------------------------------------"
ui_print "   Do you want to enable hrtick?"
ui_print "  Vol+ = Next; Vol- = Select "
ui_print " [1] YES"
ui_print " [2] NO"
ui_print "Note: HRTICK can cause freezing, lags, if your device have problems with hrtimers"

	while true; do
	ui_print "  $w"
	if $VKSEL; then
		w=$((w + 1))
	else
		break
	fi
	if [ $w -gt 2 ]; then
		w=1
	fi
done

ui_print "  Selected: [$w]"
fi

if [[ -f "/sys/devices/platform/kcal_ctrl.0/kcal_enable" ]]
then
kcal=1
if [ $kcal -ne 0 ]; then
ui_print "   "
ui_print "- Do you want to install KCAL CONFIGS?"
ui_print "---------------------------------------------------"
ui_print "-                                                 -"
ui_print "-   This changes your screen vividness 		   -"
ui_print "-        and brings different color scheme.       -"
ui_print "-                 				                -"
ui_print "---------------------------------------------------"
ui_print "  Vol+ = Next; Vol- = Select "
ui_print " [1] X Reality Engine Kcal™ - brighter,warmer, vivid"
ui_print " [2] Harley Tech Kcal™ - darker, vivid, cooler, more screen details"
ui_print " [3] Vivid Screen Retention Fix - common retention fix preset, but more vivid"
ui_print " [4] Obsanity™ - Warm Harley Tech preset"
ui_print " [5] Deep Colorful Black - Amoled like dark preset "
ui_print " [6] Triluminos Display - Sony  "
ui_print " [7] Fake AMOLED - Amoled wannabe  "
ui_print " [8] No "
ui_print " [NOTE]- you can reinstall and skip this option if problem persists. "
	while true; do
	ui_print "  $kcal"
	if $VKSEL; then
		kcal=$((kcal + 1))
	else
		break
	fi
	if [ $kcal -gt 8 ]; then
		kcal=1
	fi
done
ui_print "  Selected: [$kcal] "
fi
fi

swift=1
if [ $swift -ne 0 ]; then
ui_print "   "
ui_print "- Do you want to install Swift?"
ui_print "---------------------------------------------------"
ui_print "-                                                 -"
ui_print "-  		 Swift is a ROM Optimizer   		   -"
ui_print "-        sets android process and properties      -"
ui_print "-         for better experience.    	          -"
ui_print "---------------------------------------------------"
ui_print "  Vol+ = Next; Vol- = Select "
ui_print " [1] Yes"
ui_print " [2] No"
ui_print " [NOTE]- you can reinstall and skip this option if problem persists. "
	while true; do
	ui_print "  $swift"
	if $VKSEL; then
		swift=$((swift + 1))
	else
		break
	fi
	if [ $swift -gt 2 ]; then
		swift=1
	fi
done
ui_print "  Selected: [$swift] "
fi

lazy=1
if [ $lazy -ne 0 ]; then
ui_print "   "
ui_print "- Do you want to install lazy kernel optimizer?"
ui_print "---------------------------------------------------"
ui_print "-                                                 -"
ui_print "-  		 Lazy is a Kernel Optimizer 		   -"
ui_print "-        Provides performance, battery, latency   -"
ui_print "-         based on your preferences.	          -"
ui_print "---------------------------------------------------"
ui_print "  Vol+ = Next; Vol- = Select "
ui_print " [1] Yes"
ui_print " [2] No"
ui_print " [NOTE]- you can reinstall and skip this option if problem persists. "
	while true; do
	ui_print "  $lazy"
	if $VKSEL; then
		lazy=$((lazy + 1))
	else
		break
	fi
	if [ $lazy -gt 2 ]; then
		lazy=1
	fi
done
ui_print "  Selected: [$lazy] "
fi

if [ $lazy -eq 1 ]; then
def=1
if [ $def -ne 0 ]; then
ui_print "   "
ui_print " "
ui_print "---------------------------------------------------"
ui_print "-                                                 -"
ui_print "-  		 DEFAULT LAZY MODE SELECT   		   -"
ui_print "-        please select your default mode          -"
ui_print "-  this will be your default mode after booting.  -"
ui_print "---------------------------------------------------"
ui_print "  Vol+ = Next; Vol- = Select "
ui_print " [1] Auto "
ui_print " [2] Conservative"
ui_print " [3] Balanced"
ui_print " [4] Latency"
ui_print " [5] Throughput"
ui_print " [6] Skip"
ui_print " [NOTE]- you can reinstall and skip this option if problem persists. "
	while true; do
	ui_print "  $def"
	if $VKSEL; then
		def=$((def + 1))
	else
		break
	fi
	if [ $def -gt 6 ]; then
		def=1
	fi
done
ui_print "  Selected: [$def] "
fi
fi
#

case $w in
	1 ) sed -i "87i ctl /sys/kernel/debug/sched_features HRTICK" /data/adb/modules_update/toolbox8/scripts/lazy;;
	2 ) ui_print " skipped";;
esac

case $kcal in
	1 ) echo "echo '252 227 228' > /sys/devices/platform/kcal_ctrl.0/kcal
echo '1' > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '271' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '1536' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '264' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '260' > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	2 ) echo "echo '236 240 255' > /sys/devices/platform/kcal_ctrl.0/kcal
echo '1' > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '271' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '0' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '240' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '270 ' > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	3 ) echo "echo '240 240 225' > /sys/devices/platform/kcal_ctrl.0/kcal
echo '1' > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '255' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '1520' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '262' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '251 ' > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	4 ) echo "echo '245 245 256' > /sys/devices/platform/kcal_ctrl.0/kcal
echo '1' > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '273' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '0' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '255' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '255 ' > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	5 ) echo "echo '230 232 255' > /sys/devices/platform/kcal_ctrl.0/kcal
	echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '268' > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo '274' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '0' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '247' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '35' > /sys/devices/platform/kcal_ctrl.0/kcal_min" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	6 ) echo "echo '256 250 251' > /sys/devices/platform/kcal_ctrl.0/kcal
	echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '260' > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo '255' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '1526' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '264' > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo '35' > /sys/devices/platform/kcal_ctrl.0/kcal_min" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	7 ) echo "echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo '225 225 237' > /sys/devices/platform/kcal_ctrl.0/kcal
echo '264' > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo '0' > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo '35' > /sys/devices/platform/kcal_ctrl.0/kcal_min
echo '277' > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo '250' > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /data/adb/modules_update/toolbox8/scripts/kcal; l3=$(cat $MODPATH/scripts/kcal); echo "$l3" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	8 ) rm -rf /data/adb/modules_update/toolbox8/scripts/kcal;;
esac

case $swift in
	1 ) l2=$(cat $MODPATH/scripts/swift); echo "$l2" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	2 ) rm -rf /data/adb/modules_update/toolbox8/scripts/swift;;
esac

case $def in
	1 ) sed -i "294i setprop persist.lazy.mode 1" /data/adb/modules_update/toolbox8/scripts/lazy;;
	2 ) sed -i "294i setprop persist.lazy.mode 2" /data/adb/modules_update/toolbox8/scripts/lazy;;
	3 ) sed -i "294i setprop persist.lazy.mode 3" /data/adb/modules_update/toolbox8/scripts/lazy;;
	4 ) sed -i "294i setprop persist.lazy.mode 4" /data/adb/modules_update/toolbox8/scripts/lazy;;
	5 ) sed -i "294i setprop persist.lazy.mode 5" /data/adb/modules_update/toolbox8/scripts/lazy;;
	6 ) ui_print " Why are you not installing lazy T^T "
esac

case $lazy in
	1 ) l1=$(cat $MODPATH/scripts/lazy); echo "$l1" >> /data/adb/modules_update/toolbox8/system/bin/pandora;;
	2 ) rm -rf /data/adb/modules_update/toolbox8/scripts/lazy; rm -rf /data/adb/modules_update/toolbox8/system/bin/auto; rm -rf /data/adb/modules_update/toolbox8/system/bin/lat; rm -rf /data/adb/modules_update/toolbox8/system/bin/bal; rm -rf /data/adb/modules_update/toolbox8/system/bin/through; rm -rf /data/adb/modules_update/toolbox8/system/bin/cons; rm -rf $MODPATH/base.apk; rm -rf $MODPATH/toast.apk;;
esac




