# Chromium Container Collection

A collection of Docker containers for running Chromium browser in various VNC configurations.

## Container Variants

### 1. chromium-base
Base container with core dependencies:
- Debian Bookworm base
- LXQT desktop environment
- Chromium browser
- ZSH with Powerlevel10k theme
- Basic development tools (vim, git, curl)

### 2. chromium-vnc
Extends chromium-base with:
- TigerVNC server
- Basic VNC connectivity (ports 5900, 5901)
- Suitable for direct VNC client connections

### 3. chromium-novnc
Extends chromium-vnc with:
- noVNC HTML5 viewer
- Websockify for WebSocket support
- Access via web browser (port 6080)
- Traditional VNC access (ports 5900, 5901)

### 4. chromium-nodevnc
Extends chromium-vnc with:
- Node.js 22.x environment
- Traditional VNC access (ports 5900, 5901)
- Suitable for Node.js development

### 5. chromium-kasm
Extends chromium-base with:
- KasmVNC server
- Enhanced security features
- SSL/TLS encryption
- Access via HTTPS (port 8444)

## Usage

Each container has its own README.md with specific instructions for building and running.

## Important Note

The lubuntu-vnc container in this repository is not recommended for Chromium usage. Recent Ubuntu versions have moved Chromium to Snap-only installation, which is incompatible with container environments. Please use one of the Debian-based variants above instead.

## License

This project is licensed under the MIT License - see the LICENSE file for details.