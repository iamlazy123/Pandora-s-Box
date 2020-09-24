# Lazy tweaks
`Another Optimzer`. Transparent, No BS, carefully picked from Redhat, Github, Suse, Linux documentations and Android researches, Adjusted and tested to Android, HAS 4 MODES: GAMING - MULTITASKING - LAZY - POWERSAVER.

# FEATURES
`ALL IN ONE KERNEL OPTIMIZATIONS` - FROM TOP TO BOTTOM.

# WHAT'S DIFFERENT THIS TIME?
tired of copy pasted `tweaks? placebo? `
lazy tweaks is different from other tweaks, we read documentations, google stuff and use logic to synergize every written code on lazy, we dont just copy-paste, we test, we adjust and repeat. Everything written inside lazy is tested and carefully picked. we try be atleast 90% non-placebo and produce realtime quality experience for everyone.

# Credits
* tytydraco (for his background fork script and his knowledge)

# What does it modifies?

# * proc/sys/kernel
How kernel works internally.

# proc/sys/vm
Mostly, how dirty pages works, how pdflush kicks dirty caches to ram, amount of dirty caches/pages to be allowed to be written by the system a/synchronously.

# * sys/module/
how kernel modules/features work.

# * sys/block/*/queue 
how cfq manages work load from sda -sdx, from loop to zram0

# * sys/block/*/queue/iosched
how cfq io sched works, controls time slices of async and sync task, target latency, quantum and group_idle

# * task process affinity, renice, nice
reorders task priority, task effort and task cpu usage.

# for qcom devices: kgsl/gpu driver
how adreno gpu works

# * hwui.renderer (skiagl)
new pipeline from google, introduced at oreo, mostly used at web browsers like mozilla, may offer better ui rendering.

# * /sys/fs/*
how file system works- ext4,kernel supported

# terminologies:

# * THROUGHPUT 
simply performance, but in linux/ android throughput is the rate of production or the rate at which something is processed. throughput causes overheads the can lower runtime/latency performance.
# * LATENCY
indicates how long it takes for tasks to reach their destination, this is noticable specially on ui rendering, opening of apps and read write operations.

