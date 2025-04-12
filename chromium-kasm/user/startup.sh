#!/bin/bash
# Initialize Xauthority
touch ~/.Xauthority

# Cleanup any existing VNC instances
# vncserver -kill :1 || true
# rm -rf /tmp/.X* /tmp/.x* ~/.vnc/*.pid

# Generate VNC password
# vncpasswd -f <<< '1' > ~/.vnc/passwd
# chmod 600 ~/.vnc/passwd

# Start LXQt session
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=LXQt
export SHELL=/usr/bin/zsh

# Create xstartup for VNC
cat > ~/.vnc/xstartup << 'EOF'
#!/usr/bin/zsh
RESOLUTION=1920x1080
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export SHELL=/usr/bin/zsh
exec startlxqt
EOF
chmod +x ~/.vnc/xstartup

vncserver

# Start VNC server
# vncserver :1 \
#     -geometry ${RESOLUTION} \
#     -depth 24 \
#     -rfbport 5900 \
#     -localhost no \
#     -SecurityTypes VncAuth \
#     -alwaysshared

# Keep container running
tail -f /dev/null
