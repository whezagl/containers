FROM wharsojo/chromium-base:latest

USER root
# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Download and install KasmVNC server and expect
RUN wget -q https://github.com/kasmtech/KasmVNC/releases/download/v1.3.3/kasmvncserver_bookworm_1.3.3_arm64.deb \
    && apt-get update \
    && apt-get install -y ./kasmvncserver_bookworm_1.3.3_arm64.deb expect \
    && rm ./kasmvncserver_*.deb

# Copy configuration files
COPY user/startup.sh /home/vncuser/startup.sh
RUN chmod +x /home/vncuser/startup.sh && \
    chown vncuser:vncuser /home/vncuser/startup.sh

USER vncuser
# Add your user to the ssl-cert group
RUN sudo adduser vncuser ssl-cert

# ports and volumes
EXPOSE 3000 3001 5900

VOLUME /config

# Set the entrypoint
ENTRYPOINT ["/home/vncuser/startup.sh"]
