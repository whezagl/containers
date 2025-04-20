# Chromium NoVNC Container

A Docker container with Chromium browser, TigerVNC, and NoVNC web interface, based on chromium-vnc image.

## Features
- All features from chromium-vnc:
  - Debian Bookworm with LXQT desktop
  - Chromium browser with GPU acceleration
  - ZSH with Zim Framework and Powerlevel10k
  - Development tools and utilities
  - Dual VNC ports (5900, 5901)
  - Custom resolution support
- NoVNC additions:
  - Web-based VNC access (port 6080)
  - HTML5 VNC client
  - No VNC client installation needed

## Prerequisites
- Docker installed and running
- At least 2GB of free RAM
- Modern web browser for NoVNC access

## Build Instructions
```bash
# Build the image
docker build -t chromium-novnc .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-novnc .  

# Tag for Docker Hub
docker tag chromium-novnc:latest wharsojo/chromium-novnc:latest

# Push to Docker Hub (requires login)
docker push wharsojo/chromium-novnc:latest
```
## Usage
```bash
docker run -dit \
  -p 6080:6080 \
  -e RESOLUTION=1910x965 \
  -e VNC_PASSWORD=your_secure_password \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  --name chromium-novnc chromium-novnc

docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -p 6080:6080 \
  -e RESOLUTION=1910x965 \
  -e VNC_PASSWORD=your_secure_password \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  --name chromium-novnc chromium-novnc
```
### Configuration Options
- `RESOLUTION` : Set custom resolution (default: 1920x1080)
- `VNC_PASSWORD` : Set custom VNC password (default: 1)
- Volume mounts:
  - `/home/vncuser/user` : User data directory
  - `/etc/xdg/menus` : Application menu configuration
  - `/home/vncuser/.config/lxqt` : LXQT desktop settings

## Connecting
- Web Browser (Recommended):
  - Open http://localhost:6080
  - Enter password: 1
- VNC Client (Alternative):
  - Connect to localhost:5900 or localhost:5901
  - Enter password: 1

### Security Note
The default VNC password is set to '1' for demonstration purposes. For production use:
- Change the VNC password using the `VNC_PASSWORD` environment variable:
  ```bash
  -e VNC_PASSWORD=your_secure_password
  ```