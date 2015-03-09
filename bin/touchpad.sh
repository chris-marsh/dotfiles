#!/bin/bash

# id=$(xinput --list --id-only 'AlpsPS/2 ALPS GlidePoint')
id=$(xinput --list --id-only 'AlpsPS/2 ALPS DualPoint TouchPad')
devEnabled=$(xinput --list-props $id | awk '/Device Enabled/{print !$NF}')
xinput --set-prop $id 'Device Enabled' $devEnabled
notify-send --icon computer 'TouchPad' "Device Enabled = $devEnabled"
