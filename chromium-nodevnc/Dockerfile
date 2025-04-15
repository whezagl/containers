FROM wharsojo/chromium-vnc:latest

USER root
# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for vnc
RUN apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY user/startup.sh /home/vncuser/startup.sh
RUN chmod +x /home/vncuser/startup.sh && \
    chown vncuser:vncuser /home/vncuser/startup.sh

USER vncuser

# Expose VNC ports
EXPOSE 5900 5901

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
