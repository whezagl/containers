#!/bin/bash
# Initialize Xauthority
touch ~/.Xauthority

# Start LXQt session
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=LXQt
export SHELL=/usr/bin/zsh

# Cleanup any existing VNC instances
vncserver -kill :1 || true
rm -rf /tmp/.X* /tmp/.x* ~/.vnc/*.pid

# Generate VNC password
vncpasswd -f <<< '1' > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Create xstartup for VNC
cat > ~/.vnc/xstartup << 'EOF'
#!/usr/bin/zsh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export SHELL=/usr/bin/zsh
exec startlxqt
EOF
chmod +x ~/.vnc/xstartup

websockify --web=/usr/share/novnc/ 6080 localhost:5900 &

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
    -ncache 10 \
    -ncache_cr \
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
