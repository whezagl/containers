FROM debian:bookworm

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages --no-install-recommends
RUN apt-get update && apt-get install -y \
    --no-install-recommends --no-install-suggests \
    tigervnc-standalone-server tigervnc-common x11vnc \     
    # vncpasswd - cause by no-recommends 
    tigervnc-tools \
    lxqt-core openbox kitty ca-certificates \
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
    chromium \
    # missing - cause by no-recommends 
    breeze-icon-theme \
    && update-icon-caches /usr/share/icons/* \
    && apt-get remove zutty -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up user environment
RUN adduser --disabled-password --gecos '' vncuser && \
    echo 'vncuser:1' | chpasswd && \
    usermod -aG sudo vncuser && \
    usermod --shell /usr/bin/zsh vncuser && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy configuration files
COPY user/startup.sh /home/vncuser/startup.sh
COPY user/.config/lxqt/session.conf /home/vncuser/.config/lxqt/session.conf

RUN chmod +x /home/vncuser/startup.sh && \
    chown vncuser:vncuser /home/vncuser/startup.sh && \
    chown -R vncuser:vncuser /home/vncuser/.config && \
    su - vncuser -c 'curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh' && \
    echo 'skip_global_compinit=1' > /home/vncuser/.zshenv && \
    chown vncuser:vncuser /home/vncuser/.zshenv && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/vncuser/.powerlevel10k && \
    echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> /home/vncuser/.zshrc && \
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> /home/vncuser/.zshrc && \
    curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-lean.zsh > /home/vncuser/.p10k.zsh && \
    chown -R vncuser:vncuser /home/vncuser/.powerlevel10k /home/vncuser/.zshrc /home/vncuser/.p10k.zsh

# Switch to non-root user
USER vncuser
WORKDIR /home/vncuser

# Prepare VNC directory
RUN mkdir -p ~/.vnc

# Expose VNC ports
EXPOSE 5900 5901

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
