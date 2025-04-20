# Chromium NodeVNC Container

A Docker container with Chromium browser, TigerVNC, and Node.js, based on chromium-vnc image.

## Features
- All features from chromium-vnc:
  - Debian Bookworm with LXQT desktop
  - Chromium browser with GPU acceleration
  - ZSH with Zim Framework and Powerlevel10k
  - Development tools and utilities
  - Dual VNC ports (5900, 5901)
  - Custom resolution support
- Node.js additions:
  - Node.js 22.x LTS
  - NPM package manager
  - Ready for Node.js development

## Prerequisites
- Docker installed and running
- At least 2GB of free RAM
- VNC client installed (e.g., RealVNC, TigerVNC)

## Build Instructions
```bash
# Build the image
docker build -t chromium-nodevnc .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-nodevnc .  

# Tag for Docker Hub
docker tag chromium-nodevnc:latest wharsojo/chromium-nodevnc:latest

# Push to Docker Hub (requires login)
docker push wharsojo/chromium-nodevnc:latest
```
## Usage
```bash
docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -e RESOLUTION=1920x1080 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  --name chromium-nodevnc chromium-nodevnc
```
### Configuration Options
- `RESOLUTION` : Set custom resolution (default: 1920x1080)
- `VNC_PASSWORD` : Set custom VNC password (default: 1)
- Volume mounts:
  - `/home/vncuser/user` : User data directory
  - `/etc/xdg/menus` : Application menu configuration
  - `/home/vncuser/.config/lxqt` : LXQT desktop settings

## Connecting
- Use any VNC client (e.g., RealVNC, TigerVNC)
- Connect to:
  - localhost:5900 or
  - localhost:5901
- Enter password: 1

## Security Note
The default VNC password is set to '1' for demonstration purposes. For production use:
- Change the VNC password using the `VNC_PASSWORD` environment variable:
  ```bash
  -e VNC_PASSWORD=your_secure_password
  ```