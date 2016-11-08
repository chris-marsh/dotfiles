#!/bin/bash
#
# powerman.sh : power management script

new_status="Unknown"
battery_status="Unknown"
_debug_on=true
_notify_on=true

stderr() {
    if [ "$_debug_on" = true ]; then
        echo $1 1>&2
    fi
}

notify() {
    if [ "$_notify_on" = true ]; then
        notify-send "Powerman" "$1"
    fi
}

get_battery_status() {
    if grep -xq "Discharging" "/sys/class/power_supply/BAT0/status"; then
        battery_status="battery"
    else
        battery_status="ac"
    fi
}

set_xautolock() {
    if [ "$(pidof xautolock)" ]; then
        stderr "Killing existing autolock"
        xautolock -exit &
        # Wait for xautolock to exit
        sleep 1
    fi

    if [ $battery_status = "ac" ]; then
        stderr "Setting for AC"
        notify "Using power settings for AC"
        setting_time_lock=10
        setting_time_blank=2
        setting_time_suspend=0
    else
        stderr "Setting for Battery"
        notify "Using power settings for battery"
        setting_time_lock=10
        setting_time_blank=2
        setting_time_suspend=1
    fi
        
    let time_suspend=setting_time_suspend+setting_time_blank+setting_time_lock
    let time_blank=(setting_time_lock*60+setting_time_blank*60)
    if [ $setting_time_suspend != 0 ]; then
        let time_lock=(time_suspend*60-setting_time_lock*60)
    else
        let time_lock=setting_time_lock
    fi

    echo $time_lock $time_blank $time_suspend

    if [ $setting_time_lock = 0 ]; then
        if [ $setting_time_suspend != 0 ]; then
            stderr "Setting time to suspend"
            xautolock -time "$time_suspend" -locker "systemctl suspend" &
        fi
    else
        if [ $setting_time_suspend != 0 ]; then
            stderr "setting time to lock and suspend"
            xautolock -time "$time_suspend" \
                      -locker "systemctl suspend" \
                      -notify "$time_lock" -notifier "~/bin/autolock.sh" &
        else
            stderr "Setting time to lock"
            xautolock -time "$time_lock" -locker "~/bin/autolock.sh" &
        fi
    fi

    xset dpms 0 0 "$time_blank" &
    xset s off
}

while true; do
    get_battery_status
    if [ $new_status != $battery_status ]; then
        stderr "Status changed"
        set_xautolock
    fi
    new_status=$battery_status
    sleep 4
done

