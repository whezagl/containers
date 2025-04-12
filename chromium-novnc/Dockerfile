FROM wharsojo/chromium-vnc:latest

USER root
# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for novnc
RUN apt-get update && apt-get install -y \
    python3-numpy websockify novnc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY user/startup.sh /home/vncuser/startup.sh
RUN chmod +x /home/vncuser/startup.sh && \
    chown vncuser:vncuser /home/vncuser/startup.sh

USER vncuser

# Expose VNC ports
EXPOSE 5900 5901 6080

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
