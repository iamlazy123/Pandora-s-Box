#!/system/bin/sh

wait_until_login()
{
     # in case of /data encryption is disabled
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done

    # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
    local test_file="/sdcard/Android/.PERMISSION_TEST"
    touch "$test_file"
    while [ ! -f "$test_file" ]; do
        touch "$test_file"
        sleep 1
    done
    rm "$test_file"
}
wait_until_login
rm -rf /sdcard/android/lazy.log
rm -rf /sdcard/android/swift.log
rm -rf /sdcard/android/pandora.log
# Setup tweaks
pandora
