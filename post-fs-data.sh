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
setprop dalvik.vm.dex2oat-swap true
setprop dalvik.vm.gc.overwritefree true
setprop wifi.supplicant_scan_interval 360
setprop ADRENO_PROFILER_ENABLE_OPENCL 1
setprop ro.ril.set.mtu1472=1
setprop ro.mot.eri.losalert.delay=2000
setprop persist.cust.tel.eons=1
setprop ro.config.hw_fast_dormancy=1
setprop ro.ril.gprsclass=10
setprop ro.ril.hsdpa.category=8
setprop ro.ril.hsupa.category=6
setprop ro.ril.hsxpa=2

#
setprop dalvik.vm.boot-dex2oat-threads $CPUS
setprop ro.sys.fw.dex2oat_thread_count $CPUS
setprop dalvik.vm.dexopt-flags m=y,v=n,o=v
setprop sys.use_fifo_ui 1
setprop dalvik.vm.checkjni false
setprop dalvik.vm.verify-bytecode false
setprop dalvik.vm.execution-mode int:jit
setprop dalvik.vm.lockprof.threshold 500
setprop ADRENO_PROFILER_ENABLE_BLOCKING 1
setprop dalvik.vm.dex2oat-filter speed
setprop dalvik.vm.image-dex2oat-filter --no-watch-dog
setprop dalvik.vm.dexopt-data-only 1
setprop dalvik.vm.verify-bytecode false
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
#
setprop vendor.perf.gestureflingboost.enable true
setprop vendor.iop.enable_iop 1
setprop vendor.iop.enable_uxe 1
setprop vendor.perf.iop_v3.enable 1
setprop vendor.perf.iop_v3.enable.debug 1
setprop vendor.enable.prefetch 1
setprop vendor.iop.enable_prefetch_ofr 1
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
setprop debug.cpurend.vsync false
setprop hwui.render_dirty_regions false
#
setprop dalvik.vm.heapstartsize 16m
#
mount -o remount,nosuid,nodev,noatime,nodiratime,data=writeback -t auto /;
mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /proc;
mount -o remount,nosuid,nodev,noatime,nodiratime,data=writeback -t auto /sys;
mount -o remount,nosuid,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /data;
mount -o remount,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /dev/root;
# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
