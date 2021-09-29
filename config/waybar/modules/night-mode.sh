#!/usr/bin/env sh

# jeez my script is disgusting
# forgive me, my future self.

# if wlsunset is active
if pgrep wlsunset > /dev/null; then
    if [ $1 != "init" ]; then
        killall -q wlsunset
        while pgrep -x wlsunset >/dev/null; do sleep 1; done
        printf '{"alt":"off"}\n'
    else
        printf '{"alt":"on"}\n'
    fi
# if it's not
else
    if [ $1 != "init" ]; then
        wlsunset -l $LATITUDE -L $LONGITUDE &> /dev/null &
        printf '{"alt":"on"}\n'
    else
        printf '{"alt":"off"}\n'
    fi
fi
