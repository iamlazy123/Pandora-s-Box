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
sleep 15
# Setup tweaks
lazy