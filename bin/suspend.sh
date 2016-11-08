#!/bin/bash
#
# Suspend only if running off battery

if grep -xq "Discharging" "/sys/class/power_supply/BAT0/status"; then
    # Running on battery ... suspend the system
    systemctl suspend
fi
