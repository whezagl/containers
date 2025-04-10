FROM ubuntu:24.10

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

# Copy and set up startup script
COPY startup.sh /home/vncuser/startup.sh
RUN chown vncuser:vncuser /home/vncuser/startup.sh && \
    chmod +x /home/vncuser/startup.sh

# Switch to non-root user
USER vncuser
WORKDIR /home/vncuser

# Prepare VNC directory
RUN mkdir -p ~/.vnc

# Expose VNC ports
EXPOSE 5900 5901

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
