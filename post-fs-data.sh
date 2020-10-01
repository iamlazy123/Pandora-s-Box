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
#
setprop sys.use_fifo_ui 1
setprop windowsmgr.max_events_per_sec 300
setprop dalvik.vm.dex2oat-swap true
setprop dalvik.vm.gc.overwritefree true
setprop wifi.supplicant_scan_interval 360
setprop ADRENO_PROFILER_ENABLE_OPENCL 1
#
setprop dalvik.vm.boot-dex2oat-threads $CPUS
setprop ro.sys.fw.dex2oat_thread_count $CPUS
setprop dalvik.vm.checkjni false
setprop dalvik.vm.verify-bytecode false
setprop dalvik.vm.execution-mode int:jit
setprop dalvik.vm.lockprof.threshold 500
setprop ro.malloc.impl jemalloc
#
setprop ro.hwui.patch_cache_size 384
setprop ro.hwui.drop_shadow_cache_size 18
setprop ro.hwui.layer_cache_size 90
setprop ro.hwui.path_cache_size 36
setprop ro.hwui.r_buffer_cache_size 18
setprop ro.hwui.texture_cache_size 183
setprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3
setprop debug.gr.numframebuffers 3
setprop debug.qctwa.preservebuf 1
setprop dev.pm.dyn_samplingrate 1
setprop debug.sf.disable_backpressure 1
setprop debug.composition.type dyn
setprop persist.sys.composition.type dyn
setprop debug.egl.hw 1
setprop debug.enabletr true
setprop debug.overlayui.enable 1
setprop debug.performance.tuning 1
setprop ro.sf.compbypass.enable 0
setprop libc.debug.malloc 0
setprop debug.gr.swapinterval -60
setprop debug.hwui.renderer skiagl
setprop debug.egl.swapinterval -60
setprop vendor.debug.egl.swapinterval -60
setprop debug.sf.latch_unsignaled 1
setprop debug.egl.buffcount 4
setprop ro.sf.disable_triple_buffer 0
setprop net.tcp.2g_init_rwnd 10
setprop net.tcp.default_init_rwnd 60
setprop net.tethering.noprovisioning true
setprop hwui.disable_vsync true
setprop debug.sf.recomputecrop 0
setprop debug.force_rtl false
setprop debug.cpurend.vsync false
setprop hwui.render_dirty_regions false
#
mount -o remount,nosuid,nodev,noatime,nodiratime,data=writeback -t auto /;
mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /proc;
mount -o remount,nosuid,nodev,noatime,nodiratime,data=writeback -t auto /sys;
mount -o remount,nosuid,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /data;
mount -o remount,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /dev/root;
# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
