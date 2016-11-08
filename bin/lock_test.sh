#!/bin/sh

xautolock -time 2 -locker "systemctl hibernate" & -notify 30 -notifier '~/bin/autolock.sh'

exec xautolock -detectsleep 
  -time 1 -locker "i3lock -d -c 000070" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
