FROM ubuntu:24.10

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages --no-install-recommends
RUN apt-get update && apt-get install -y --no-install-suggests \
    tigervnc-standalone-server tigervnc-common x11vnc \
    lxqt lxqt-core websockify \
    sddm \
    xorg \
    xauth \
    xinit \
    dbus-x11 \
    net-tools \
    sudo \
    wget \
    curl \
    zsh \
    git \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Set up user environment
RUN adduser --disabled-password --gecos '' vncuser && \
    adduser vncuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    cargo install sheldon && \
    mv /root/.cargo/bin/sheldon /usr/local/bin/ && \
    mkdir -p /home/vncuser/.config/sheldon && \
    chsh -s /usr/bin/zsh vncuser

# Copy configuration files
COPY startup.sh /home/vncuser/startup.sh
COPY plugins.toml /home/vncuser/.config/sheldon/plugins.toml
RUN chown vncuser:vncuser /home/vncuser/startup.sh && \
    chmod +x /home/vncuser/startup.sh && \
    chown -R vncuser:vncuser /home/vncuser/.config

# Add sheldon init to zshrc
RUN echo 'eval "$(sheldon source)"' > /home/vncuser/.zshrc && \
    chown vncuser:vncuser /home/vncuser/.zshrc

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
