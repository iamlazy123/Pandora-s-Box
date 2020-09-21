#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR ${0%/*}
FRACTION=75
RAM=$(free -m | awk '/Mem:/{print $2}')
CPUS=`grep -c processor /proc/cpuinfo`
SIZE=$(((RAM * FRACTION / 100) * 1048576))
swapoff /dev/block/zram0 > /dev/null 2>&1
echo '1' > /sys/block/zram0/reset
echo '0' > /sys/block/zram0/disksize
echo $CPUS > /sys/block/zram0/max_comp_streams
echo $SIZE > /sys/block/zram0/disksize
mkswap /dev/block/zram0 > /dev/null 2>&1
swapon /dev/block/zram0 > /dev/null 2>&1
# avoid conflicts
setprop dalvik.vm.dex2oat-swap true
setprop debug.hwui.renderer skiagl
setprop debug.egl.swapinterval -60
setprop vendor.debug.egl.swapinterval -60
setprop debug.sf.latch_unsignaled 1
setprop wifi.supplicant_scan_interval 200
setprop dalvik.vm.gc.overwritefree true
setprop debug.egl.buffcount 3
setprop ADRENO_PROFILER_ENABLE_OPENCL 1
setprop ADRENO_PROFILER_ENABLE_BLOCKING 1
setprop dalvik.vm.dex2oat-filter speed
setprop dalvik.vm.image-dex2oat-filter --no-watch-dog
setprop dalvik.vm.dexopt-data-only 1
setprop dalvik.vm.verify-bytecode false
setprop dalvik.vm.execution-mode intjit
setprop dalvik.vm.stack-trace-file /data/anr/traces.txt
setprop dalvik.vm.jmiopts forcecopy
setprop dalvik.vm.check-dex-sum false
setprop dalvik.vm.deadlock-predict off
setprop dalvik.vm.dex2oat-minidebuginfo false
setprop dalvik.vm.usejit true
setprop dalvik.vm.dex2oat-flags --no-watch-dog
setprop dalvik.vm.dexopt.secondary true
setprop pm.dexopt.first-boot speed
setprop pm.dexopt.boot speed
setprop pm.dexopt.install quicken
setprop pm.dexopt.inactive speed
setprop persist.sys.dalvik.multithread true
setprop persist.sys.dalvik.hyperthreading true
setprop pm.dexopt.bg-dexopt speed
setprop pm.dexopt.shared speed
#DisableIMSdebuglogs
setprop persist.ims.disableDebugLogs 1
#Disablequalitycontrol
setprop persist.radio.oem_socket false
#Disablestatslogging&monitoring
setprop debug.atrace.tags.enableflags 0
setprop profiler.force_disable_ulog true
setprop profiler.force_disable_err_rpt true
setprop profiler.force_disable_ulog 1
setprop profiler.force_disable_err_rpt 1
setprop ro.config.nocheckin 1
setprop debugtool.anrhistory 0
setprop ro.com.google.locationfeatures 0
setprop ro.com.google.networklocation 0
setprop profiler.debugmonitor false
setprop profiler.launch false
setprop profiler.hung.dumpdobugreport false
setprop persist.service.pcsync.enable 0
setprop persist.service.lgospd.enable 0
setprop persist.sys.purgeable_assets 1
setprop ro.kernel.android.checkjni 0
setprop ro.debuggable 1
setprop setprop dalvik.vm.checkjni false
setprop profiler.hung.dumpdobugreport false
setprop trustkernel.log.state disable
setprop persist.sys.ssr.enable_ramdumps 0
setprop persist.vendor.sys.ssr.enable_ramdumps 0
setprop persist.traced.enable 0
setprop ro.lmk.log_stats 0
setprop persist.radio.ramdump 0
setprop debug.mdpcomp.logs 0
setprop logd.logpersistd.enable false
setprop persist.sys.ssr.enable_ramdumps 0
setprop persist.vendor.sys.ssr.enable_ramdumps 0
setprop persist.traced.enable 0
setprop persist.wpa_supplicant.debug false
setprop vidc.debug.level 0
setprop debug.sqlite.journalmode WAL
setprop debug.sqlite.syncmode 1
#Dozeparameters
setprop pm.sleep_mode 1
#test
setprop ro.sys.fw.bg_apps_limit 60
#hwui
setprop ro.hwui.patch_cache_size 384
setprop ro.hwui.drop_shadow_cache_size 18
setprop ro.hwui.layer_cache_size 90
setprop ro.hwui.path_cache_size 36
setprop ro.hwui.r_buffer_cache_size 18
setprop ro.hwui.texture_cache_size 183
#touch
setprop touch.pressure.scale 0.0001
setprop touch.size.calibration diameter
setprop touch.size.scale 1
setprop touch.size.bias 0
setprop touch.size.isSummed 0
setprop touch.orientation.calibration none
setprop touch.distance.calibration none
setprop touch.distance.scale 0
setprop touch.coverage.calibration box
setprop touch.gestureMode spots
#ART
setprop dalvik.vm.boot-dex2oat-threads $CPUS
setprop dalvik.vm.dex2oat-threads $(($CPUS /2))
setprop dalvik.vm.image-dex2oat-threads $(($CPUS/ 2))
setprop ro.sys.fw.dex2oat_thread_count $CPUS
#disabletouchbelow1pixels
setprop mot.proximity.distance 1
#Gametweaks
setprop debug.gr.swapinterval 0
setprop windowsmgr.max_events_per_sec 300
#Graphics
setprop debug.gr.numframebuffers 3
#SurfaceFlinger
setprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3
#fasterapplaunching
setprop persist.device_config.runtime_native.usap_pool_enabled true
setprop ro.ril.disable.power.collapse 0
setprop ro.floatingtouch.available 1
setprop ro.audio.flinger_standbytime_ms 300
setprop ro.boot.warranty_bit 0
setprop ro.warranty_bit 0

#Perf
setprop ro.vendor.gt_library libqti-gt.so
setprop ro.vendor.at_library libqti-at.so
setprop ro.vendor.extension_library libqti-perfd-client.so
setprop ro.vendor.scroll.preobtain.enable false

#Graphics
setprop debug.sf.gpu_comp_tiling 0
setprop debug.sf.recomputecrop 0
setprop debug.cpurend.vsync false
setprop debug.enabletr true
setprop debug.performance.tuning 1
setprop ro.sf.compbypass.enable 0
setprop debug.overlayui.enable 1
setprop ro.product.gpu.driver 1
setprop debug.oculus.refreshRate 60
setprop debug.oculus.textureHeight 540
setprop debug.oculus.textureWidth 1080

#SurfaceFlinger
setprop ro.surface_flinger.support_kernel_idle_timer true
setprop ro.surface_flinger.set_display_power_timer_ms 10000
setprop ro.surface_flinger.set_touch_timer_ms 5000
setprop ro.surface_flinger.set_idle_timer_ms 9000

#eglgetdefaultdisplay
setprop ro.zygote.disable_gl_preload true

#perf
setprop vendor.perf.gestureflingboost.enable true
setprop vendor.iop.enable_iop 0
setprop vendor.iop.enable_uxe 0
setprop vendor.perf.iop_v3.enable 0
setprop vendor.perf.iop_v3.enable.debug 0
setprop vendor.enable.prefetch 0
setprop vendor.iop.enable_prefetch_ofr 0
# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
