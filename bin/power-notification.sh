#!/bin/bash                                                          

# Battery level warning script

local batt_dir="/sys/class/power_supply/BAT"

if [ -d $batt_dir"0" ]; then
    batt_dir=$batt_dir"0"
elif [ -d $batt_dir"1" ]; then
    batt_dir=$batt_dir1""
else
    return 1
fi

local cap="$(<"$batt_dir/capacity")"
local status="$(<"$batt_dir/status")"

if [ "$Status" == "Discharging" ]; then

    if [[ $cap -le 20 && $battery_level -gt 12 ]]; then
        notify-send -u critical \
            "Battery Very Low" \
            "Battery level is ${cap}%"
    elif [[ $cap -le 12 ]]; then
        notify-send -u critical \
            "Battery Critical" \
            "Battery level is ${cap}% \nSystem will shutdown soon"
    fi

fi

# battery_level=`acpi -b | grep -oP '[0-9]+(?=%)'`

# if [[ $battery_level -le 20 && $battery_level -gt 12 ]]; then
#     notify-send -u critical \
#         "Battery Very Low" \
#         "Battery level is ${battery_level}%"
# elif [[ $battery_level -le 12 ]]; then
#     notify-send -u critical \
#         "Battery Critical" \
#         "Battery level is ${battery_level}% \nSystem will shutdown soon"
# fi

