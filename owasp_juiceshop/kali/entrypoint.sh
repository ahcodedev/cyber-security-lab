#!/bin/sh
set -eu

mkdir -p "$HOME/.vnc"
printf '%s\n' "$VNC_PASSWORD" | vncpasswd -f > "$HOME/.vnc/passwd"
chmod 600 "$HOME/.vnc/passwd"

# Stale locks survive a container restart and block the display.
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

tigervncserver :1 -localhost yes -geometry 1600x900 -depth 24 \
    -PasswordFile "$HOME/.vnc/passwd"

exec websockify --web=/usr/share/novnc 6080 localhost:5901
