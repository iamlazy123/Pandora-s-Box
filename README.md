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

# We need to execute this multiple times because
# sched_downmirate must be less than sched_upmigrate, and
# sched_upmigrate must be greater than sched_downmigrate
for _ in $(seq 2)
do

	# Migrate tasks down at this much load
	ctl $KERNEL/sched_downmigrate "80 80"
	ctl $KERNEL/sched_group_downmigrate 80
	ctl $KERNEL/sched_downmigrate_boosted "80 80"
	
	# Migrate tasks up at this much load
	ctl $KERNEL/sched_upmigrate "80 80"
	ctl $KERNEL/sched_group_upmigrate 80
	ctl $KERNEL/sched_upmigrate_boosted "80 80"
done

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

# Perform SchedTune boosting when sched_boost is triggered
ctl $KERNEL/sched_boost 1

# Improve real time latencies by reducing the scheduler migration time
ctl $KERNEL/sched_nr_migrate 8

# Decrease round-robin time slices for runtime latency
ctl $KERNEL/sched_rr_timeslice_ms 2

#  Supposedly the period over which the time spent running real-time tasks but entry is not used anyware, so disable it.
ctl $KERNEL/sched_time_avg_ms 1

# Disable compat logging
ctl $KERNEL/compat-log 0

# Disable Kernel panic/s
ctl $KERNEL/panic 0
ctl $KERNEL/softlockup_panic 0
ctl $KERNEL/panic_on_oops 0

# Reduce the maximum scheduling period for lower latency
ctl $KERNEL/sched_latency_ns "$SCHED_PERIOD" 

# Schedule 10 tasks in the guarenteed sched period
ctl $KERNEL/sched_min_granularity_ns "$((SCHED_PERIOD / SCHED_TASKS))"

# Require preeptive tasks to surpass half of a sched period in vmruntime
ctl $KERNEL/sched_wakeup_granularity_ns "$((SCHED_PERIOD / 2))"

# Reduce the frequency of task migrations
ctl $KERNEL/sched_migration_cost_ns 5000000

# Initial task load upon fork, set it to google's value which is 0.
ctl $KERNEL/sched_initial_task_util 0

# Disable asking of EAS for CPU selection
ctl $KERNEL/sched_sync_hint_enable 0

# Enable Cluster based selection 
ctl $KERNEL/sched_is_big_little 1

# The scheduler can make use of the idle state indexes in order to break the tie between potential CPU candidates.
ctl $KERNEL/sched_cstate_aware 1

# Enable CAF task placement for Big Cores.
ctl $KERNEL/sched_walt_rotate_big_tasks 1

# Balanced CPUSET for efficiency
ctl /dev/cpuset/foreground/cpus "0-6"
ctl /dev/cpuset/background/cpus "0-3"
ctl /dev/cpuset/restricted/cpus "2-3"

for i in $KERNEL/sched_domain/cpu*/domain*/
do
# Leave cache hot tasks for # tries
ctl "${i}cache_nice_tries" 3
# Maximum balance interval ms
ctl "${i}max_interval" 1
#Minimum balance interval ms
ctl "${i}min_interval" 1
# Lower CPU balancing until over watermark
ctl "${i}imbalance_pct" 36
# Set busy_factor to 1, so it will give more chance for active load balance for migration running tasks.
ctl "${i}busy_factor" 1
done

RAM=$(free -m | awk '/Mem:/{print $2}')

# The OOM killer will scan through the entire tasklist and select a task based on heuristics to kill.
ctl $VM/oom_kill_allocating_task 0

# Disable I/O debugging
ctl $VM/block_dump 0

# Require dirty memory to stay in memory for longer
ctl $VM/dirty_expire_centisecs 4500

# Run the dirty memory flusher threads less often
ctl $VM/dirty_writeback_centisecs 4500

# Makes the kernel to compact memory more.
ctl $VM/extfrag_threshold 750

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

# Grace period that the kernel grants to a process holding a file lease
ctl $FS/lease-break-time 5

# Enable file lease
ctl $FS/leases-enable 1

# Disables the dnotify interface on a system-wide basis.
ctl $FS/dir-notify-enable 0

# Compaction is allowed to examine the unevictable lru (mlocked pages) for pages to compact.
ctl $VM/compact_unevictable_allowed 1

# Start non-blocking writeback later
ctl $VM/dirty_background_ratio 5

# Start blocking writeback later
ctl $VM/dirty_ratio 20

# Allow more inodes and dentries to be cached
ctl $VM/vfs_cache_pressure 60

# Lower CPU Usage of default affinity mask that applies to all non-active IRQs.
ctl /proc/irq/default_smp_affinity 3f

# Duration of input boost
ctl "$BOOST/input_boost_ms" 132

# Perform sched boost on input
ctl "$BOOST/sched_boost_on_input" 1

# Pwrlvl of Adreno GPU (0 is max and 6 is less active)
ctl /sys/class/kgsl/kgsl-3d0/default_pwrlevel 4

# LMK and minfree for ram management
Front=$((($RAM*1/100)*1024/4))
Visible=$((($RAM*1/100)*1024/4))
Second=$((($RAM*3/100)*1024/4))
Hidden=$((($RAM*6/100)*1024/4))
content=$((($RAM*7/100)*1024/4))
empty=$((($RAM*8/100)*1024/4))

# LMK will kill task if adj and minfree's conditions are met.
ctl $LMK/adj "0,0,235,530,835,1000"
ctl $LMK/minfree "$Front,$Visible,$Second,$Hidden,$content,$empty"
	
# Free reclaimable slab objects
ctl $VM/drop_caches 3
sleep 2
# Free reclaimable slab objects 
ctl $VM/drop_caches 2
sleep 2
# Free Pagecache
ctl $VM/drop_caches 1
sleep 2 
# Reset caching
echo "0" > $VM/drop_caches
sleep 2
# Free reclaimable slab objects 
ctl $VM/drop_caches 3

# GPU TUNABLES for Adreno GPUS
ctl /sys/class/kgsl/kgsl-3d0/force_rail_on 1
ctl /sys/class/kgsl/kgsl-3d0/idle_timer 10000000
ctl /sys/class/kgsl/kgsl-3d0/force_bus_on 0
ctl /sys/class/kgsl/kgsl-3d0/devfreq/polling_interval 27
ctl /sys/class/kgsl/kgsl-3d0/force_clk_on 0
ctl /sys/class/kgsl/kgsl-3d0/force_no_nap 0
ctl /sys/class/kgsl/kgsl-3d0/bus_split 1

# Disables GPU Throttling
ctl /sys/class/kgsl/kgsl-3d0/throttling 0

# Disables snapshot crashdumper 
ctl /sys/class/kgsl/kgsl-3d0/snapshot/snapshot_crashdumper 0

# Same as reap_mem_on_sigkill 
ctl $LMK/oom_reaper 1

# Extra free memory set by system
ctl $VM/extra_free_kbytes $(($RAM * 4))

# Minimum Free memory in kbytes set by system
ctl $VM/min_free_kbytes $RAM

# Disables LMK fast run
ctl $LMK/lmk_fast_run 0

# Disables adaptive LMK 
ctl $LMK/enable_adaptive_lmk 0


# Scheduler features
if [[ -f "$DBG/sched_features" ]]
then
	# Consider scheduling tasks that are eager to run
	ctl $DBG/sched_features NEXT_BUDDY
	
	# Schedule tasks on their origin CPU if possible
	ctl $DBG/sched_features TTWU_QUEUE
	
	# EAS Power Saving mechanism
	ctl $DBG/sched_features ENERGY_AWARE
	fi
	
# Loop over each CPU in the system
for cpu in /sys/devices/system/cpu/cpu*/cpufreq
do
	# Fetch the available governors from the CPU
	avail_govs="$(cat "$cpu/scaling_available_governors")"

	# Stretch CPU bounds
	ctl "$cpu/scaling_max_freq" "$(cat "$cpu/cpuinfo_max_freq")"
	ctl "$cpu/scaling_min_freq" "$(cat "$cpu/cpuinfo_min_freq")"

	# Attempt to set the governor in this order
	for governor in schedutil interactive
	do
		# Once a matching governor is found, set it and break for this CPU
		if [[ "$avail_govs" == *"$governor"* ]]
		then
			ctl "$cpu/scaling_governor" "$governor"
			break
		fi
	done
done

# Apply governor specific tunables for schedutil
find /sys/devices/system/cpu/ -name schedutil -type d | while IFS= read -r governor
do
	# Consider changing frequencies once per scheduling period
	ctl "$governor/up_rate_limit_us" 5000
	ctl "$governor/down_rate_limit_us" 5000
	ctl "$governor/rate_limit_us" 5000

	# Jump to max frequency at 90% load
	ctl "$governor/hispeed_load" 90
	ctl "$governor/hispeed_freq" "$UINT_MAX"
done

# Apply governor specific tunables for interactive
find /sys/devices/system/cpu/ -name interactive -type d | while IFS= read -r governor
do
	# Consider changing frequencies once per scheduling period
	ctl "$governor/timer_rate" 5000
	ctl "$governor/min_sample_time" 5000

	# Jump to max frequency at 90% load
	ctl "$governor/go_hispeed_load" 90
	ctl "$governor/hispeed_freq" "$UINT_MAX"
done


for i in /sys/devices/system/cpu/cpu*/core_ctl
do
		# Tried to match this value to sched migrations
		ctl "${i}/busy_down_thres" 80
		# Tried to match this value to sched migrations
		ctl "${i}/busy_up_thres" 80
		# The time to wait for before offline cores when the number of needed CPUs goes down.
		ctl "${i}/offline_delay_ms" 50
done

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
	
	# The block layer will migrate request completions to the cpu "group" that originally submitted the request.
	ctl "${queue}rq_affinity" 1
	
	# Dont treat storage as rotational 
	ctl "${queue}rotational" 0
	
	# Reduce the maximum number of I/O requests in exchange for latency
	ctl "${queue}nr_requests" 64
	
	# Allow simple one-hit merges 
	ctl "${queue}nomerges" 1
	
	# Reduce heuristic read-ahead in exchange for I/O latency
	ctl "${queue}read_ahead_kb" 16
done

# Disable heuristic read-ahead in exchange for I/O latency on ram
for queue in /sys/block/ram*/queue/
do
	ctl "${queue}read_ahead_kb" 0
done

# Disable heuristic read-ahead in exchange for I/O latency on zram
for queue in /sys/block/zram*/queue/
do
	ctl "${queue}read_ahead_kb" 0
done

# Disable heuristic read-ahead in exchange for I/O latency on loop
for queue in /sys/block/loop*/queue/
do
	ctl "${queue}read_ahead_kb" 0
done

# Flash storages doesn't comes with any back seeking problems, so set this as low as possible for performance;
for i in /sys/block/*/queue/iosched
do
  # set maximum "distance" for backward seeking, for less bs_penalty
  ctl "$i/back_seek_max" 42582912
  
  # Lower the cost of backward seeking
  ctl "$i/back_seek_penalty" 1
  
  # Quantum Depth is 32 #16 is recommended for throughput, 4 is for latency
  ctl "$i/quantum" 4
  
  # Lower timeout of asynchronous requests for write latency
  ctl "$i/fifo_expire_async" 115
  
  # Lower timeout of asynchronous requests for read latency
  ctl "$i/fifo_expire_sync" 0
  
  # Disable group_idle for throughput
  ctl "$i/group_idle" 0
  ctl "$i/group_idle_us" 0
  
  # prefer fairness over throughput
  ctl "$i/low_latency" 1
  ctl "$i/target_latency" 100
  ctl "$i/target_latency_us" 100000
  
  # reduce time for execution of async I/O request 
  ctl "$i/slice_async" 20
  
  # limit the dispatching of asynchronous request
  ctl "$i/slice_async_rq" 2
  
  # Disable slice_idle for throughput
  ctl "$i/slice_idle" 0
  ctl "$i/slice_idle_us" 0
  
  # reduce time for execution of sync I/O request 
  ctl "$i/slice_sync" 0

done

# EXT4 TUNABLES
ext4="/sys/fs/ext4/*"
	for ext4b in $ext4
	do
			 # increase number of inode table blocks that ext4's inode table readahead algorithm will pre-read into the buffer cache
             ctl ${ext4b}/inode_readahead_blks 64
			 
			 # Disable The multiblock allocator
             ctl $ext4b/mb_group_prealloc 0
			 
			 # Disable ext4 debugging mechanism
             ctl ${ext4b}/inode_goal 0
			 
			 # Since mb allocator is disabled, disable this too.
             ctl ${ext4b}/mb_max_to_scan 0
			 
			 # Since mb allocator is disabled, disable this too.
             ctl ${ext4b}/mb_min_to_scan 0
			 
			 # Lower zeroout to prevent slowdown on high load
             ctl ${ext4b}/extent_max_zeroout_kb 3
			 
			 # Attempt to reduce preallocation pool 
             ctl ${ext4b}/mb_stream_req 0
			 
			 # Minimum Request where the buddy cache is used (as a power of 2)
             ctl ${ext4b}/mb_order2_req 1
 done
 
# increase the number of inotify events for userspace
ctl /proc/sys/fs/inotify/max_queued_events 131072
ctl /proc/sys/fs/inotify/max_user_watches 131072
ctl /proc/sys/fs/inotify/max_user_instances 1024

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
change_proc_cgroup "system_server" "top-app" "cpuset"
change_proc_cgroup "system_server" "foreground" "stune"

# exclude animations
change_thread_cgroup "system_server" "android.anim" "top-app" "stune"
change_thread_cgroup "system_server" "android.anim.lf" "top-app" "stune"
change_thread_cgroup "system_server" "android.ui" "top-app" "stune"

# treat crtc_commit as background, avoid display preemption on big
change_task_cgroup "crtc_commit" "system-background" "cpuset"

# and pin HeapTaskDaemon on LITTLE
change_thread_cgroup "system_server" "HeapTaskDaemon" "background" "cpuset"

# reduce big cluster wakeup, eg. android.hardware.sensors@1.0-service
change_task_cgroup ".hardware." "background" "cpuset"
change_task_affinity ".hardware." "0f"

# but exclude fingerprint & camera & display service for speed
change_task_cgroup ".hardware.biometrics.fingerprint" "" "cpuset"
change_task_cgroup ".hardware.camera.provider" "" "cpuset"
change_task_cgroup ".hardware.display" "" "cpuset"
change_task_affinity ".hardware.biometrics.fingerprint" "ff"
change_task_affinity ".hardware.camera.provider" "ff"
change_task_affinity ".hardware.display" "ff"

# changing priority of memory killer 
change_task_affinity "kswapd0" "7f"
change_task_affinity "oom_reaper" "7f"
change_task_nice "kswapd0" "-2"
change_task_nice "kswapd" "-2"
change_task_nice "oom_reaper" "-2"

# changing priority of system services for less aggressive google services and better services management
change_task_nice "system_server" "-6"
change_task_nice "launcher" "-6"
change_task_nice "trebuchet" "-6"
change_task_nice "inputmethod" "-3"
change_task_nice "fluid" "-9"
change_task_nice "composer" "-10"
change_task_nice "com.android.phone" "-3"
change_task_nice "ksmd" "1"
change_task_nice "msm_irqbalance" "-5"
change_task_nice "kgsl_worker" "-9"
change_task_nice "android.gms" "1"
change_task_nice "android.vending" "1"
change_task_nice "surfaceflinger" "-10"


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
#TOP-APP
ctl $ST_TOP/schedtune.boost 5
ctl $ST_TOP/schedtune.colocate 0
ctl $ST_TOP/schedtune.prefer_idle 1
ctl $ST_TOP/schedtune.sched_boost_enabled 1
ctl $ST_TOP/schedtune.sched_boost_no_override 1
#GLOBAL
ctl $ST_GLOBAL/schedtune.boost 0
ctl $ST_GLOBAL/schedtune.colocate 0
ctl $ST_GLOBAL/schedtune.prefer_idle 0
ctl $ST_GLOBAL/schedtune.sched_boost_enabled 0
ctl $ST_GLOBAL/schedtune.sched_boost_no_override 0

# Reserve 90% IO bandwith for foreground tasks
ctl /dev/blkio/blkio.weight 1000
ctl /dev/blkio/background/blkio.weight 100
ctl /dev/blkio/background/blkio.leaf_weight 100
ctl /dev/blkio/blkio.leaf_weight 1000
ctl /dev/blkio/blkio.blkio.group_idle 0
ctl /dev/blkio/background/blkio.group_idle 0

# LPM SETTINGS WHICH IS CONNECTED TO OUR HIGH MIGRATION COST
ctl $LPM/lpm_prediction Y
ctl $LPM/sleep_disabled N
ctl $LPM/bias_hyst 25


# Disable SYN cookies
ctl $NET/ipv4/tcp_syncookies 0

# Westwood is the most preferred even in linux.
ctl $NET/ipv4/tcp_congestion_control westwood

# Enable Explicit Congestion Control
ctl $NET/ipv4/tcp_ecn 1

# Enable fast socket open for receiver and sender
ctl $NET/ipv4/tcp_fastopen 3

# MISC NET TWEAKS
ctl $NET/core/netdev_max_backlog 128
ctl $NET/core/netdev_tstamp_prequeue 0
ctl $NET/ipv4/ipfrag_time 24
ctl $NET/ipv4/tcp_sack 1
ctl $NET/ipv4/tcp_fack 1
ctl $NET/ipv4/tcp_delayed_ack 0
ctl $NET/ipv4/tcp_tw_reuse 1
ctl $NET/ipv4/tcp_dsack 1
ctl $NET/ipv4/tcp_fwmark_accept 0
ctl $NET/ipv4/tcp_keepalive_intvl 320
ctl $NET/ipv4/tcp_keepalive_time 21600
ctl $NET/ipv4/tcp_no_metrics_save 1
ctl $NET/ipv4/tcp_slow_start_after_idle 0
ctl $NET/ipv6/ip6frag_time 48



# reduce bufferfloat
for i in $(find /sys/class/net -type l); do
  ctl $i/tx_queue_len 128
done

# Doze battery life profile;
pm disable --user 0 com.google.android.gms/.phenotype.service.sync.PhenotypeConfigurator;settings put secure location_providers_allowed 
global device_idle_constants inactive_to=2592000000,motion_inactive_to=2592000000,light_after_inactive_to=15000,light_pre_idle_to=30000,light_max_idle_to=86400000,light_idle_to=43200000,light_idle_maintenance_max_budget=30000,light_idle_maintenance_min_budget=10000,min_time_to_alarm=60000;
dumpsys deviceidle enable all
dumpsys deviceidle step deep doze;

# Dont log these, since they bring minimal impact, but should not provide conflicts.
# Misc values copy-pasted from scripts across xda, imo are just debug disablers, nothing more.

# Disable Vsync on mdss debug
echo "0" > /sys/kernel/debug/mdss_panel_fb0/intf0/mipi/hw_vsync_mode
echo "0" > /sys/kernel/debug/mdss_panel_fb0/intf0/mipi/vsync_enable

# Disable exception-trace kernel debugging;
echo "0" > /proc/sys/debug/exception-trace

# Disable SCSI logging;
echo "0" > /proc/sys/dev/scsi/logging_level

# Disable / prevent the possibility of autoloading ldiscs;
echo "0" > /proc/sys/dev/tty/ldisc_autoload
# Turn off excessive MSM_VIDC debugging;
echo "0" > /sys/kernel/debug/msm_vidc/fw_debug_mode

# Disable some additional excessive kernel debugging;
echo "N" > /sys/kernel/debug/debug_enabled

# Disable some excessive sched biased debugging;
echo "N" > /sys/kernel/debug/sched_debug

# Use RCU_normal instead of RCU_expedited for improved real-time latency, CPU utilization and energy efficiency;
echo "0" > /sys/kernel/rcu_expedited
echo "1" > /sys/kernel/rcu_normal

# Enable Fast Charge for slightly faster battery charging through a USB 3.1 port which can be good for the people that is often on the run or have limited access to a wall socket;
echo "1" > /sys/kernel/fast_charge/force_fast_charge

# Disable a few minor and overall pretty useless modules for slightly better battery life & system wide performance;
echo "0" > /sys/module/battery/parameters/debug_mask
echo "0" > /sys/module/binder/parameters/debug_mask
echo "0" > /sys/module/binder_alloc/parameters/debug_mask
echo "Y" > /sys/module/bluetooth/parameters/disable_ertm
echo "Y" > /sys/module/bluetooth/parameters/disable_esco
echo "0" > /sys/module/cam_debug_util/parameters/debug_mdl
echo "N" > /sys/module/cam_ois_core/parameters/ois_debug
echo "Y" > /sys/module/cryptomgr/parameters/notests
echo "0" > /sys/module/diagchar/parameters/diag_mask_clear_param
echo "0" > /sys/module/dns_resolver/parameters/debug
echo "0" > /sys/module/drm/parameters/debug
echo "N" > /sys/module/drm_kms_helper/parameters/poll
echo "0" > /sys/module/dwc3/parameters/ep_addr_rxdbg_mask
echo "0" > /sys/module/dwc3/parameters/ep_addr_txdbg_mask
echo "0" > /sys/module/edac_core/parameters/edac_mc_log_ce
echo "0" > /sys/module/edac_core/parameters/edac_mc_log_ue
echo "0" > /sys/module/event_timer/parameters/debug_mask
echo "0" > /sys/module/glink_pkt/parameters/debug_mask
echo "0" > /sys/module/hid/parameters/debug
echo "1" > /sys/module/hid/parameters/ignore_special_drivers
echo "0" > /sys/module/hid_apple/parameters/fnmode
echo "0" > /sys/module/hid_apple/parameters/iso_layout
echo "N" > /sys/module/hid_magicmouse/parameters/emulate_3button
echo "N" > /sys/module/hid_magicmouse/parameters/emulate_scroll_wheel
echo "0" > /sys/module/hid_magicmouse/parameters/scroll_speed
echo "N" > /sys/module/hid_steam/parameters/lizard_mode
echo "0" > /sys/module/icnss/parameters/dynamic_feature_mask
echo "N" > /sys/module/ip6_tunnel/parameters/log_ecn_error
echo "Y" > /sys/module/libcomposite/parameters/disable_l1_for_hs
echo "0" > /sys/module/mhi_qcom/parameters/debug_mode
echo "Y" > /sys/module/msm_drm/parameters/backlight_dimmer
echo "0" > /sys/module/msm_performance/parameters/touchboost
echo "0" > /sys/module/msm_poweroff/parameters/download_mode
echo "0" > /sys/module/msm_show_resume_irq/parameters/debug_mask
echo "N" > /sys/module/msm_vidc_ar50_dyn_gov/parameters/debug
echo "N" > /sys/module/msm_vidc_dyn_gov/parameters/debug
echo "0" > /sys/module/pci_msm/parameters/debug_mask
echo "N" > /sys/module/ppp_generic/parameters/mp_protocol_compress
echo "Y" > /sys/module/printk/parameters/console_suspend
echo "0" > /sys/module/ramoops/parameters/dump_oops
echo "0" > /sys/module/scsi_mod/parameters/scsi_logging_level
echo "0" > /sys/module/service_locator/parameters/enable
echo "N" > /sys/module/sit/parameters/log_ecn_error
echo "1" > /sys/module/subsystem_restart/parameters/disable_restart_work
echo "0" > /sys/module/suspend/parameters/pm_test_delay
echo "0" > /sys/module/usb_bam/parameters/enable_event_log
echo "Y" > /sys/module/workqueue/parameters/power_efficient

# Disable / stop system logging (logd) daemon;
stop logd

# Disables GPU debugging
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_cmd
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_ctxt
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_drv
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_mem
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_pwr

# Disables debugging across /sys
for i in $(find /sys/ -name debug_mask); do
echo "0" > $i;
done
for i in $(find /sys/ -name debug_level); do
echo "0" > $i;
done
for i in $(find /sys/ -name edac_mc_log_ce); do
echo "0" > $i;
done
for i in $(find /sys/ -name edac_mc_log_ue); do
echo "0" > $i;
done
for i in $(find /sys/ -name enable_event_log); do
echo "0" > $i;
done
for i in $(find /sys/ -name log_ecn_error); do
echo "0" > $i;
done
for i in $(find /sys/ -name snapshot_crashdumper); do
echo "0" > $i;
done

# terminologies:

# * THROUGHPUT 
simply performance, but in linux/ android throughput is the rate of production or the rate at which something is processed. throughput causes overheads the can lower runtime/latency performance.
# * LATENCY
indicates how long it takes for tasks to reach their destination, this is noticable specially on ui rendering, opening of apps and read write operations.

