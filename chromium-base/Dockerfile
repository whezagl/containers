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
    && rm -rf /var/lib/apt/lists/*

# Set up user environment  
RUN adduser --disabled-password --gecos '' vncuser \
    && echo 'vncuser:1' | chpasswd \
    && usermod -aG sudo vncuser \
    && usermod --shell /usr/bin/zsh vncuser \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to non-root user.
USER vncuser
WORKDIR /home/vncuser

COPY user/.config/lxqt/session.conf /home/vncuser/.config/lxqt/session.conf
COPY user/.config/qterminal.org/qterminal.ini /home/vncuser/.config/qterminal.org/qterminal.ini

RUN mkdir -p ~/.vnc \
    && echo 'skip_global_compinit=1' > /home/vncuser/.zshenv \
    && curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh \
    && curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-lean.zsh > /home/vncuser/.p10k.zsh \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/vncuser/.powerlevel10k \
    && echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> /home/vncuser/.zshrc \
    && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> /home/vncuser/.zshrc