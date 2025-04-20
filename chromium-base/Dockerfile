FROM debian:bookworm

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    --no-install-recommends --no-install-suggests \
    lxqt-core openbox kitty ca-certificates \
    ripgrep fzf zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    xorg \
    xauth \
    xinit \
    dbus-x11 \
    net-tools \
    sudo \
    wget \
    curl \
    git \
    vim \
    chromium \
    featherpad \
    # missing - cause by no-recommends 
    breeze-icon-theme \
    && update-icon-caches /usr/share/icons/* \
    && apt-get remove zutty -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/crash \
    && chmod 777 /var/crash \
    && mkdir -p /data \
    && chmod 777 /data \
    && mkdir -p /var/run/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id

# Add this before switching to vncuser
RUN mkdir -p /run/dbus && \
    chown messagebus:messagebus /run/dbus && \
    dbus-daemon --system

# Set up user environment  
RUN adduser --disabled-password --gecos '' vncuser \
    && echo 'vncuser:1' | chpasswd \
    && usermod -aG sudo vncuser \
    && usermod --shell /usr/bin/zsh vncuser \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/vncuser/.config/chromium \
    && mkdir -p /home/vncuser/.cache/chromium \
    && mkdir -p /tmp/crashpad \
    && chown -R vncuser:vncuser /home/vncuser/.config \
    && chown -R vncuser:vncuser /home/vncuser/.cache \
    && chmod -R 755 /home/vncuser/.config \
    && chmod -R 755 /home/vncuser/.cache \
    && chmod 777 /tmp/crashpad

# Switch to non-root user.
USER vncuser
WORKDIR /home/vncuser

COPY user/.config/lxqt/session.conf /home/vncuser/.config/lxqt/session.conf
COPY user/.config/qterminal.org/qterminal.ini /home/vncuser/.config/qterminal.org/qterminal.ini

# Set up Zim and Powerlevel10k
RUN mkdir -p ~/.vnc \
    && echo 'skip_global_compinit=1' > /home/vncuser/.zshenv \
    && curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh \
    && curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-lean.zsh > /home/vncuser/.p10k.zsh \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/vncuser/.powerlevel10k \
    && echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> /home/vncuser/.zshrc \
    && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> /home/vncuser/.zshrc

# Add the chromium alias in a separate command
RUN echo 'alias chromium="$CHROMIUM_WRAPPER"' >> /home/vncuser/.zshrc

# Remove the problematic RUN command since we already created the directories
RUN mkdir -p ~/.config/chromium \
    && mkdir -p ~/.cache/chromium \
    && mkdir -p /tmp/crashpad

# Add environment variable for customizable homepage (move this earlier)
ENV CHROME_STARTUP_URL=about:blank
ENV CHROMIUM_WRAPPER=/home/vncuser/chromium-wrapper.sh

# Create wrapper script and Chromium config
RUN mkdir -p ~/.config/chromium/Default && \
    echo '#!/bin/bash\n\
if pgrep -x "chromium" > /dev/null; then\n\
    echo "Chromium is already running"\n\
    exit 1\n\
fi\n\
sudo service dbus stop\n\
sudo rm -f /var/run/dbus/pid\n\
sudo dbus-daemon --system\n\
exec chromium --no-first-run --remote-debugging-port=9222 "${CHROME_STARTUP_URL}" "$@"' > /home/vncuser/chromium-wrapper.sh && \
    chmod +x /home/vncuser/chromium-wrapper.sh && \
    echo '{\
    "browser": {\
        "enabled_labs_experiments": ["enable-gpu-rasterization"],\
        "startup_urls": ["'${CHROME_STARTUP_URL}'"]\
    },\
    "crashpad": {\
        "enabled": false\
    }\
}' > ~/.config/chromium/Local\ State && \
    echo '{\
    "homepage": "'${CHROME_STARTUP_URL}'",\
    "homepage_is_newtabpage": false,\
    "session": {\
        "restore_on_startup": 4,\
        "startup_urls": ["'${CHROME_STARTUP_URL}'"],\
        "startup_urls_migration_time": "0"\
    }\
}' > ~/.config/chromium/Default/Preferences

# Add the chromium alias
RUN echo 'alias chromium="$CHROMIUM_WRAPPER"' >> /home/vncuser/.zshrc