# Use Ubuntu 24.04 LTS
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages --no-install-recommends
RUN apt-get update && apt-get install -y --no-install-suggests \
    software-properties-common \
    tigervnc-standalone-server \
    tigervnc-common \
    x11vnc \
    lxqt \
    lxqt-core \
    sddm \
    xinit \
    xorg \
    dbus-x11 \
    xauth \
    websockify \
    net-tools \
    sudo \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up user environment
RUN adduser --disabled-password --gecos '' vncuser && \
    adduser vncuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to non-root user
USER vncuser
WORKDIR /home/vncuser

# Prepare VNC directory
RUN mkdir -p ~/.vnc

# Create startup script
RUN echo '#!/bin/bash' > ~/startup.sh && \
    echo "# Initialize Xauthority" >> ~/startup.sh && \
    echo "touch ~/.Xauthority" >> ~/startup.sh && \
    echo "# Cleanup any existing VNC instances" >> ~/startup.sh && \
    echo "vncserver -kill :1 || true" >> ~/startup.sh && \
    echo "rm -rf /tmp/.X* /tmp/.x* ~/.vnc/*.pid" >> ~/startup.sh && \
    echo "# Generate VNC password" >> ~/startup.sh && \
    echo "vncpasswd -f <<< 'your_secure_password' > ~/.vnc/passwd" >> ~/startup.sh && \
    echo "chmod 600 ~/.vnc/passwd" >> ~/startup.sh && \
    echo "# Start LXQt session" >> ~/startup.sh && \
    echo "export XDG_SESSION_TYPE=x11" >> ~/startup.sh && \
    echo "export XDG_CURRENT_DESKTOP=LXQt" >> ~/startup.sh && \
    echo "# Start VNC server" >> ~/startup.sh && \
    echo "vncserver :1 \\" >> ~/startup.sh && \
    echo "    -geometry 1920x1080 \\" >> ~/startup.sh && \
    echo "    -depth 24 \\" >> ~/startup.sh && \
    echo "    -rfbport 5900 \\" >> ~/startup.sh && \
    echo "    -localhost no \\" >> ~/startup.sh && \
    echo "    -SecurityTypes VncAuth \\" >> ~/startup.sh && \
    echo "    -alwaysshared" >> ~/startup.sh && \
    echo "# Start view-only x11vnc" >> ~/startup.sh && \
    echo "x11vnc -display :1 \\" >> ~/startup.sh && \
    echo "    -rfbport 5901 \\" >> ~/startup.sh && \
    echo "    -shared \\" >> ~/startup.sh && \
    echo "    -forever \\" >> ~/startup.sh && \
    echo "    -rfbauth ~/.vnc/passwd \\" >> ~/startup.sh && \
    echo "    -viewonly \\" >> ~/startup.sh && \
    echo "    -noxdamage \\" >> ~/startup.sh && \
    echo "    -noxkb \\" >> ~/startup.sh && \
    echo "    -cursor arrow" >> ~/startup.sh && \
    echo "# Keep container running" >> ~/startup.sh && \
    echo "tail -f /dev/null" >> ~/startup.sh && \
    chmod +x ~/startup.sh

# Expose VNC ports
EXPOSE 5900 5901

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
