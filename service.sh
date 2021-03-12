#!/system/bin/sh

wait_until_login()
{
    # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
    while [[ `getprop sys.boot_completed` -ne 1 ]] && [[ ! -d "/sdcard" ]]
	do
       sleep 1
	done

    local test_file="/sdcard/.PERMISSION_TEST"
    touch "$test_file"
    while [ ! -f "$test_file" ]; do
        touch "$test_file"
        sleep 1
    done
    rm "$test_file"
}
wait_until_login

echo "Please wait for 30 seconds, Pandora is waiting for your vendor scripts to finish executing." > /sdcard/android/pandora.log

rm -rf /sdcard/android/lazy.log
rm -rf /sdcard/android/swift.log

sleep 30

rm -rf /sdcard/android/pandora.log
# Setup tweaks
pandora
