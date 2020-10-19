# Lazy tweaks
`Another Optimzer`. Transparent, No BS, carefully picked from Redhat, Github, Suse, Linux documentations and Android researches, Adjusted and tested to Android, HAS 4 MODES: GAMING - MULTITASKING - LAZY - POWERSAVER.

# FEATURES
`ALL IN ONE KERNEL OPTIMIZATIONS` - FROM TOP TO BOTTOM.

# WHAT'S DIFFERENT THIS TIME?
tired of copy pasted `tweaks? placebo? `
lazy tweaks is different from other tweaks, we read documentations, google stuff and use logic to synergize every written code on lazy, we dont just copy-paste, we test, we adjust and repeat. Everything written inside lazy is tested and carefully picked. we try be atleast 90% non-placebo and produce realtime quality experience for everyone.

# Credits
* tytydraco (for his background fork script and ktweak)

# What does it modifies?

# Build prop tweaks
tired of build prop tweaks? non-sense build prop tweaks that doesn't override your oem values? build prop tweaks that aren't tested but just copy pasted?
its Already 2020 and most of them are placeboo, but are they placeboo? lazy hotpicked the most probably working build prop tweaks for you, searched from .cpp files , commits and xda forums, preloaded to post-fs-data to utilize magisk resetprop and provide you up to 80% real tweaks that can improve your experience, no best, no ultimate, no ultra, just real tweaks for you and you devices.

# Note: forked vaues from ktweak all credits goes to @tytydraco for his kernel tweaks.

# Limit max perf event processing time to this much CPU usage
ctl $KERNEL/perf_cpu_time_max_percent 5

# Do not group task groups automatically
ctl $KERNEL/sched_autogroup_enabled 0

# Preliminary requirement for the following values
ctl $KERNEL/sched_tunable_scaling 0

# Disable scheduler statistics to reduce overhead
ctl $KERNEL/sched_schedstats 0

# Always allow sched boosting on top-app tasks
ctl $KERNEL/sched_min_task_util_for_boost_colocation 0

# Always allow sched boosting on top-app tasks
ctl $KERNEL/sched_min_task_util_for_colocation 0

# Disable SchedTune boosting 
ctl $KERNEL/sched_boost 0

# fork child process first
ctl $KERNEL/sched_child_runs_first 1

# Improve real time latencies by reducing the scheduler migration time
ctl $KERNEL/sched_nr_migrate 8

# Decrease round-robin time slices for runtime latency
ctl $KERNEL/sched_rr_timeslice_ms 90

# Initial task load upon fork, set it to google's value which is 0.
ctl $KERNEL/sched_initial_task_util 0

# The scheduler can make use of the idle state indexes in order to break the tie between potential CPU candidates.
ctl $KERNEL/sched_cstate_aware 1

# remove real time bandwith
ctl $KERNEL/sched_rt_runtime_us -1

# EAS CPU selection
ctl $KERNEL/sched_sync_hint_enable 0

# set debug mask to small cluster
ctl /proc/irq/default_smp_affinity 0f

# Balanced CPUSET for efficiency
ctl $CSET/foreground/cpus "0-6"

ctl $CSET/background/cpus "0-3"

ctl $CSET/restricted/cpus "0-3"

#for i in $KERNEL/sched_domain/cpu*/domain*/

# Leave cache hot tasks for # tries
ctl "${i}cache_nice_tries" 0
# Maximum balance interval ms
ctl "${i}max_interval" 1
#Minimum balance interval ms
ctl "${i}min_interval" 1
# Lower CPU balancing until over watermark
ctl "${i}imbalance_pct" 0
# Set busy_factor to 0, so it will give more chance for active load balance for migration running tasks.
ctl "${i}busy_factor" 0

# The OOM killer will scan through the entire tasklist and select a task based on heuristics to kill.
ctl $VM/oom_kill_allocating_task 0

# Disable I/O debugging
ctl $VM/block_dump 0

# When we kill a task, clean its memory footprint to free up whatever amount of RAM it was consuming.
ctl $VM/reap_mem_on_sigkill 1

# Disable zram read ahead
ctl $VM/page-cluster 0

# Disable logging when a memory-hogging task is killed.
ctl $VM/oom_dump_tasks 0

# Update /proc/stat less often to reduce jitter
ctl $VM/stat_interval 10

# Disable panic on OOM situations.
ctl $VM/panic_on_oom 0

# Compaction is allowed to examine the unevictable lru (mlocked pages) for pages to compact.
ctl $VM/compact_unevictable_allowed 1

# Clear Caches amd Inodes
ctl $VM/drop_caches 3

# Disable aggressive lmk/s
ctl $LMK/lmk_fast_run 0

ctl $LMK/enable_adaptive_lmk 0

#GPU Tunables
ctl /sys/class/kgsl/kgsl-3d0/force_rail_on 0

ctl /sys/class/kgsl/kgsl-3d0/force_clk_on 0

ctl /sys/class/kgsl/kgsl-3d0/force_bus_on 0

ctl /sys/class/kgsl/kgsl-3d0/devfreq/polling_interval 0

ctl /sys/class/kgsl/kgsl-3d0/idle_timer 10000000

# Disables GPU Throttling
ctl /sys/class/kgsl/kgsl-3d0/throttling 0

# Disables snapshot crashdumper 
ctl /sys/class/kgsl/kgsl-3d0/snapshot/snapshot_crashdumper 0

# Same as reap_mem_on_sigkill 
ctl $LMK/oom_reaper 1

# Extra free memory set by system
ctl $VM/extra_free_kbytes $(($RAM * 4))

# Minimum Free memory in kbytes set by system
ctl $VM/min_free_kbytes $(($RAM * 2))

# Scheduler features
	# Consider scheduling tasks that are eager to run
	ctl $DBG/sched_features NEXT_BUDDY
	
	# Schedule tasks on their origin CPU if possible
	ctl $DBG/sched_features TTWU_QUEUE
	
	# Disable Double tick for cache locality
	ctl $DBG/sched_features NO_DOUBLE_TICK
	
#for i in /sys/devices/system/cpu/cpu*/core_ctl
#do
		# Tried to match this value to sched migrations
		ctl "${i}/busy_down_thres" 10

		# Tried to match this value to sched migrations
		ctl "${i}/busy_up_thres" 20

		# The time to wait for before offline cores when the number of needed CPUs goes down.
		ctl "${i}/offline_delay_ms" 50
#done

for queue in /sys/block/*/queue/
do
	# Choose the first governor available

	avail_scheds=`cat "${queue}scheduler"`

	for sched in cfq noop kyber bfq mq-deadline none

	do
		if [[ "$avail_scheds" == *"$sched"* ]]
		then

			ctl "${queue}scheduler" "$sched"

			break
		fi

	done

	# Disable I/O statistics accounting
	ctl "${queue}iostats" 0
	
	# Do not use I/O as a source of randomness
	ctl "${queue}add_random" 0
	
	# limit nr request for latency
	ctl "${queue}nr_requests" 32
	
        # limit heuristic read ahead for latency
	ctl "${queue}read_ahead_kb" 128

done

# Flash storages doesn't comes with any back seeking problems, so set this as low as possible for performance;

for i in /sys/block/*/queue/iosched

do
 
 # set maximum "distance" for backward seeking, for less bs_penalty
  ctl "$i/back_seek_max" 12582912
  
  # Lower the cost of backward seeking
  ctl "$i/back_seek_penalty" 1
  
  # prefer fairness over throughput
  ctl "$i/low_latency" 1
  
  # Disable slice_idle for throughput
  ctl "$i/slice_idle" 0
  
  # Disable slice_idle for throughput
  ctl "$i/group_idle" 0
  
  # increase timeout of asynchronous requests for write throughput
  ctl "$i/fifo_expire_async" 330
  
done

# EXT4 TUNABLES

ext4="/sys/fs/ext4/*"

	for ext4b in $ext4
	
          do

            # reduce number of inode table blocks that ext4's inode table readahead algorithm will pre-read into the buffer cache
             ctl ${ext4b}/inode_readahead_blks 64
             
 done
 
# cgroup

change_proc_cgroup "system_server" "top-app" "cpuset"

change_proc_cgroup "system_server" "foreground" "stune"

#

change_thread_cgroup "system_server" "android.anim" "top-app" "stune"

change_thread_cgroup "system_server" "android.anim.lf" "top-app" "stune"

change_thread_cgroup "system_server" "android.ui" "top-app" "stune"

# reduce big cluster wakeup, eg. android.hardware.sensors@1.0-service

change_task_cgroup ".hardware." "foreground" "cpuset"

change_task_affinity ".hardware." "3f"

# but exclude fingerprint&camera&display service for speed

change_task_cgroup ".hardware.biometrics.fingerprint" "" "cpuset"

change_task_cgroup ".hardware.camera.provider" "" "cpuset"

change_task_cgroup ".hardware.display" "" "cpuset"

change_task_affinity ".hardware.biometrics.fingerprint" "ff"

change_task_affinity ".hardware.camera.provider" "ff"

change_task_affinity ".hardware.display" "ff"

# reduce big cluster wakeup, eg. android.hardware.sensors@1.0-service

change_task_affinity "surfaceflinger" "ff"

change_task_affinity "servicemanager" "ff"

change_task_affinity "system_server" "ff"

change_task_ionice  "surfaceflinger" "7"

change_task_ionice  "servicemanager" "4"

change_task_ionice  "system_server" "4"

# Changing the cgroup of the following PIDs for smoother experience
change_task_cgroup "servicemanager" "top-app" "cpuset"
change_task_cgroup "servicemanager" "foreground" "stune"
change_task_cgroup "android.phone" "top-app" "cpuset"
change_task_cgroup "android.phone" "foreground" "stune"
change_task_cgroup "surfaceflinger" "top-app" "cpuset"
change_task_cgroup "surfaceflinger" "foreground" "stune"
change_task_cgroup "system_server" "top-app" "cpuset"
change_task_cgroup "system_server" "foreground" "stune"
change_task_cgroup "kswapd0" "foreground" "cpuset"
change_task_cgroup "kswapd" "foreground" "cpuset"
change_task_cgroup "oom_reaper" "foreground" "cpuset"

# treat crtc_commit as background, avoid display preemption on big
change_task_cgroup "crtc_commit" "system-background" "cpuset"

# and pin HeapTaskDaemon on LITTLE
change_thread_cgroup "system_server" "HeapTaskDaemon" "background" "cpuset"

# changing priority of memory killer 
change_task_affinity "kswapd" "7f"
change_task_affinity "kswapd0" "7f"
change_task_affinity "oom_reaper" "7f"
change_task_affinity "lmkd" "7f"

# changing priority of system services for less aggressive google services and better services management
change_task_nice "system_server" "-7"
change_task_nice "launcher" "-6"
change_task_nice "trebuchet" "-6"
change_task_nice "inputmethod" "-3"
change_task_nice "fluid" "-9"
change_task_nice "composer" "-10"
change_task_nice "com.android.phone" "-3"
change_task_nice "ksmd" "1"
change_task_nice "msm_irqbalance" "1"
change_task_nice "irq" "1"
change_task_nice "kgsl_worker" "-9"
change_task_nice "kworker" "-9"
change_task_nice "android.gms" "1"
change_task_nice "android.vending" "1"
change_task_nice "surfaceflinger" "-10"
change_task_nice ".hardware." "1"
change_task_nice "servicemanager" "-10"
change_task_nice "kswapd0" "-2"
change_task_nice "lmkd" "-2"
change_task_nice "oom_reaper" "-2"


# SCHEDTUNE SETTINGS 
#BACKGROUND
ctl $ST_BACK/schedtune.boost 0
ctl $ST_BACK/schedtune.colocate 0
ctl $ST_BACK/schedtune.prefer_idle 0
ctl $ST_BACK/schedtune.sched_boost_enabled 0
ctl $ST_BACK/schedtune.sched_boost_no_override 0
#FOREGROUND
ctl $ST_FORE/schedtune.boost 0
ctl $ST_FORE/schedtune.colocate 0
ctl $ST_FORE/schedtune.prefer_idle 0
ctl $ST_FORE/schedtune.sched_boost_enabled 0
ctl $ST_FORE/schedtune.sched_boost_no_override 1
#RT
ctl $ST_RT/schedtune.boost 0
ctl $ST_RT/schedtune.colocate 0
ctl $ST_RT/schedtune.prefer_idle 1
ctl $ST_RT/schedtune.sched_boost_enabled 1
ctl $ST_RT/schedtune.sched_boost_no_override 0
#GLOBAL
ctl $ST_GLOBAL/schedtune.boost 0
ctl $ST_GLOBAL/schedtune.colocate 0
ctl $ST_GLOBAL/schedtune.prefer_idle 0
ctl $ST_GLOBAL/schedtune.sched_boost_enabled 0
ctl $ST_GLOBAL/schedtune.sched_boost_no_override 0

# Reserve 90% IO bandwith for foreground tasks
ctl /dev/blkio/blkio.weight 1000
ctl /dev/blkio/blkio.leaf_weight 1000
ctl /dev/blkio/background/blkio.weight 100
ctl /dev/blkio/background/blkio.leaf_weight 100
ctl $LPM/lpm_prediction N
ctl $LPM/sleep_disabled N
ctl $LPM/bias_hyst 25

#lazy props is here
{
# these props are said to be working and will be hotpicked overtime
setprop sys.use_fifo_ui 1
setprop dalvik.vm.dex2oat-swap true
setprop debug.hwui.renderer skiagl
setprop debug.egl.swapinterval -60
setprop vendor.debug.egl.swapinterval -60
setprop debug.sf.latch_unsignaled 1
setprop wifi.supplicant_scan_interval 360
setprop dalvik.vm.gc.overwritefree true
setprop debug.egl.buffcount 4
setprop ADRENO_PROFILER_ENABLE_OPENCL 1
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
setprop dalvik.vm.boot-dex2oat-threads $CPUS
setprop ro.sys.fw.dex2oat_thread_count $CPUS
setprop ro.malloc.impl jemalloc
setprop dalvik.vm.dexopt-flags m=y
setprop dalvik.vm.checkjni false
setprop dalvik.vm.verify-bytecode false
setprop dalvik.vm.execution-mode int:jit
setprop dalvik.vm.lockprof.threshold 500
#Dozeparameters
setprop pm.sleep_mode 1
#hwui
setprop ro.hwui.patch_cache_size 384
setprop ro.hwui.drop_shadow_cache_size 18
setprop ro.hwui.layer_cache_size 90
setprop ro.hwui.path_cache_size 36
setprop ro.hwui.r_buffer_cache_size 18
setprop ro.hwui.texture_cache_size 183
#Gametweaks
setprop debug.gr.swapinterval -60
setprop windowsmgr.max_events_per_sec 300
#Graphics
setprop debug.gr.numframebuffers 3
#SurfaceFlinger
setprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3
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
setprop debug.sf.recomputecrop 0
setprop debug.cpurend.vsync false
setprop debug.enabletr true
setprop debug.performance.tuning 1
setprop ro.sf.compbypass.enable 0
setprop debug.overlayui.enable 1
setprop ro.product.gpu.driver 1
setprop debug.egl.hw 1
setprop debug.enabletr true
setprop debug.hwui.render_dirty_regions false
setprop debug.sf.disable_backpressure 1
setprop libc.debug.malloc 0
setprop hwui.disable_vsync true
setprop hwui.render_dirty_regions false
setprop debug.sf.hw 1
setprop debug.composition.type c2d
setprop persist.sys.composition.type c2d
setprop persist.sys.purgeable_assets 1
setprop debug.qctwa.preservebuf 1
setprop dev.pm.dyn_samplingrate 1
setprop ro.fb.mode 1
setprop persist.sys.use_16bpp_alpha 1
setprop persist.sampling_profiler 0
setprop persist.android.strictmode 0
setprop persist.sys.use_dithering 0
setprop persist.service.pcsync.enable 0
setprop persist.service.lgospd.enable 0
#network
setprop ro.ril.set.mtu1472 1
setprop ro.mot.eri.losalert.delay 2000
setprop persist.cust.tel.eons 1
setprop ro.config.hw_fast_dormancy 1
setprop ro.ril.gprsclass 10
setprop ro.ril.hsdpa.category 8
setprop ro.ril.hsupa.category 6
setprop ro.ril.hsxpa 2
setprop net.tcp.2g_init_rwnd 10
setprop net.tcp.default_init_rwnd 60
setprop net.tethering.noprovisioning true
#perf
setprop vendor.perf.gestureflingboost.enable true
setprop vendor.iop.enable_iop 0
setprop vendor.iop.enable_uxe 0
setprop vendor.perf.iop_v3.enable 0
setprop vendor.perf.iop_v3.enable.debug 0
setprop vendor.enable.prefetch 0
setprop vendor.iop.enable_prefetch_ofr 0
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
setprop ro.vendor.qti.sys.fw.bg_apps_limit 600
setprop ro.vendor.qti.sys.fw.bservice_limit 60
#Dozeparameters
setprop pm.sleep_mode 1
} &

# reduce bufferfloat
for i in $(find /sys/class/net -type l); do
  ctl $i/tx_queue_len 64
done

# These are said to be necessary when reducing perf cpu usage.
ctl $KERNEL/perf_event_paranoid 0
ctl $KERNEL/kptr_restrict 0

# TCP Congestion Control
for tcp in /proc/sys/net/ipv4/
do
tcp="$(cat "${tcp}tcp_available_congestion_control")"
for sched in bbr bbr2 cubic westwood reno
do
if [[ "$tcp" == *"$sched"* ]]
then
ctl $NET/ipv4/tcp_congestion_control $sched
break
fi
done
# Increase number of incoming connections backlog queue 
# Sets the maximum number of packets, queued on the INPUT 
# side, when the interface receives packets faster than
# kernel can process them. 
ctl $NET/core/netdev_max_backlog 64

# Enable select acknowledgments
ctl $NET/ipv4/tcp_sack 1

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks 
ctl $NET/ipv4/tcp_tw_reuse 1

# Turn on window scaling which can enlarge the transfer window:
ctl $NET/ipv4/tcp_window_scaling 1

# Do not cache metrics on closing connections 
ctl $NET/ipv4/tcp_no_metrics_save 1

# Maximum number of remembered connection requests, which did not yet
# receive an acknowledgment from connecting client.
ctl $NET/ipv4/tcp_max_syn_backlog 64
 
# tells the kernel how many TCP sockets that are not attached to any
# user file handle to maintain. In case this number is exceeded,
# orphaned connections are immediately reset and a warning is printed.
ctl $NET/ipv4/tcp_max_orphans 64

# Disable SYN cookies
ctl $NET/ipv4/tcp_syncookies 0

# Enable Explicit Congestion Control
ctl $NET/ipv4/tcp_ecn 1

# Enable fast socket open for receiver and sender
ctl $NET/ipv4/tcp_fastopen 3

# Misc
ctl $NET/ipv4/tcp_low_latency 1
ctl $NET/ipv4/tcp_fack 1
ctl $NET/ipv4/tcp_tw_reuse 1
ctl $NET/ipv4/tcp_rfc1337 1
ctl $NET/ipv4/tcp_slow_start_after_idle 0
ctl $NET/ipv4/ip_no_pmtu_disc 0
ctl $NET/ipv4/tcp_ecn 0
ctl $NET/ipv4/tcp_timestamps 0
ctl $NET/ipv4/tcp_delayed_ack 0
ctl $NET/core/netdev_tstamp_prequeue 0
ctl $NET/ipv4/ipfrag_time 8
ctl $NET/ipv4/tcp_fin_timeout 30
ctl $NET/ipv6/ip6frag_time 16
ctl $NET/ipv4/tcp_dsack 1
ctl $NET/ipv4/tcp_fwmark_accept 0
ctl $NET/ipv4/tcp_keepalive_intvl 30
ctl $NET/ipv4/tcp_keepalive_probes 8

done

# Doze battery life profile;
pm disable --user 0 com.google.android.gms/.phenotype.service.sync.PhenotypeConfigurator;settings put secure location_providers_allowed 
global device_idle_constants inactive_to=2592000000,motion_inactive_to=2592000000,light_after_inactive_to=15000,light_pre_idle_to=30000,light_max_idle_to=86400000,light_idle_to=43200000,light_idle_maintenance_max_budget=30000,light_idle_maintenance_min_budget=10000,min_time_to_alarm=60000;
dumpsys deviceidle enable all
dumpsys deviceidle step deep doze;

# Disable Analytics for reduced gms usage
pm disable com.google.android.gms/com.google.android.gms.lockbox.service.LockboxBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.cache.CacheBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.AdRequestBrokerService 
pm disable com.google.android.gms/com.google.android.gms.icing.service.IndexService
pm disable com.google.android.gms/com.google.android.gms.fitness.service.history.FitHistoryBroker
pm disable com.google.android.gms/com.google.android.gms.tron.CollectionService

# Disable collective Device administrators
pm disable com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

# Doze Setup Services
pm disable com.google.android.gms/.ads.AdRequestBrokerService
pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdService
pm disable com.google.android.gms/.ads.social.GcmSchedulerWakeupService
pm disable com.google.android.gms/.analytics.AnalyticsService
pm disable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService
pm disable com.google.android.gms/.backup.BackupTransportService
pm disable com.google.android.gms/.thunderbird.settings.ThunderbirdSettingInjectorService
pm disable com.google.android.gms/.update.SystemUpdateActivity
pm disable com.google.android.gms/.update.SystemUpdateService
pm disable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver 
pm disable com.google.android.gms/.update.SystemUpdateService$Receiver 
pm disable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
killall -9 com.google.android.gms
killall -9 com.google.android.gms.persistent
pm disable com.google.android.gsf/.update.SystemUpdateActivity
pm disable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm disable com.google.android.gsf/.update.SystemUpdateService
pm disable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm disable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver
killall -9 com.google.android.gsf
killall -9 com.google.android.gsf.persistent

# terminologies:

# * THROUGHPUT 
simply performance, but in linux/ android throughput is the rate of production or the rate at which something is processed. throughput causes overheads the can lower runtime/latency performance.
# * LATENCY
indicates how long it takes for tasks to reach their destination, this is noticable specially on ui rendering, opening of apps and read write operations.