#!/bin/sh

# Start the desktop on tty1, without affecting SSH or other terminals.
if [ "$(tty)" = /dev/tty1 ] && [ -z "${WAYLAND_DISPLAY:-}" ] && [ -z "${DISPLAY:-}" ]; then
  export XDG_SESSION_TYPE=wayland
  export XDG_CURRENT_DESKTOP=mango
  mkdir -p "$HOME/.local/state/mango"
  ulimit -c unlimited
  exec dbus-run-session -- mango -d >>"$HOME/.local/state/mango/session.log" 2>&1
fi
