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
echo $(($CPUS - 2 )) > /sys/block/zram0/max_comp_streams
echo $SIZE > /sys/block/zram0/disksize
mkswap /dev/block/zram0 > /dev/null 2>&1
swapon /dev/block/zram0 > /dev/null 2>&1
# avoid conflicts
setprop sys.use_fifo_ui 1
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
setprop dalvik.vm.boot-dex2oat-threads $(($CPUS - 2 ))
setprop dalvik.vm.dex2oat-threads $(($CPUS - 2))
setprop dalvik.vm.image-dex2oat-threads $(($CPUS - 2))
setprop ro.sys.fw.dex2oat_thread_count $(($CPUS - 2 ))
#Dozeparameters
setprop pm.sleep_mode 1
#test
setprop ro.sys.fw.bg_apps_limit 128
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

#Gametweaks
setprop debug.gr.swapinterval 0
setprop windowsmgr.max_events_per_sec 300
#Graphics
setprop debug.gr.numframebuffers 3
#SurfaceFlinger
setprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3
#fasterapplaunching
setprop persist.device_config.runtime_native.usap_pool_enabled true

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
setprop debug.composition.type dyn
setprop debug.egl.hw 1
setprop debug.enabletr true
setprop debug.hwui.render_dirty_regions false
setprop debug.sf.disable_backpressure 1
setprop persist.sys.composition.type dyn
setprop libc.debug.malloc 0
setprop hwui.disable_vsync true
setprop hwui.render_dirty_regions false

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
