#!/bin/bash
# Initialize Xauthority
touch ~/.Xauthority

# Cleanup any existing VNC instances
vncserver -kill :1 || true
rm -rf /tmp/.X* /tmp/.x* ~/.vnc/*.pid

# Generate VNC password
vncpasswd -f <<< 'your_secure_password' > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start LXQt session
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=LXQt

# Start VNC server
vncserver :1 \
    -geometry 1920x1080 \
    -depth 24 \
    -rfbport 5900 \
    -localhost no \
    -SecurityTypes VncAuth \
    -alwaysshared

# Start view-only x11vnc
x11vnc -display :1 \
    -rfbport 5901 \
    -shared \
    -forever \
    -rfbauth ~/.vnc/passwd \
    -viewonly \
    -noxdamage \
    -noxkb \
    -cursor arrow

# Keep container running
tail -f /dev/null