# Chromium VNC Container

A Docker container with Chromium browser and TigerVNC server, based on chromium-base image.

## Features
- All features from chromium-base:
  - Debian Bookworm with LXQT desktop
  - Chromium browser with GPU acceleration
  - ZSH with Zim Framework and Powerlevel10k
  - Development tools and utilities
- TigerVNC server integration:
  - Dual VNC ports (5900, 5901)
  - Custom resolution support
  - Persistent configuration
- Default VNC password: 1

## Build Instructions
```bash
# Build the image
docker build -t chromium-vnc .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-vnc .  

# Tag for Docker Hub
docker tag chromium-vnc:latest wharsojo/chromium-vnc:latest

# Push to Docker Hub (requires login)
docker push wharsojo/chromium-vnc:latest
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
  --name chromium-vnc chromium-vnc
```
### Configuration Options
- `RESOLUTION` : Set custom resolution (default: 1920x1080)
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

## Notes
- Base image: wharsojo/chromium-base:latest
- Recommended VNC clients: TigerVNC Viewer, RealVNC Viewer
- For web-based access, consider using chromium-novnc variant instead