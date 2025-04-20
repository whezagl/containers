# Lubuntu VNC Container

A Docker container with Lubuntu desktop and TigerVNC server.

## Features
- Lubuntu desktop environment:
  - Lightweight and fast
  - Based on LXQT desktop
  - Minimal installation
- TigerVNC server integration:
  - Dual VNC ports (5900, 5901)
  - Custom resolution support
  - Persistent configuration

## Prerequisites
- Docker installed and running
- At least 1GB of free RAM
- VNC client installed (e.g., RealVNC, TigerVNC)

## Build Instructions
```bash
# Build the image
docker build -t lubuntu-vnc .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t lubuntu-vnc .  

# Tag for Docker Hub
docker tag lubuntu-vnc:latest wharsojo/lubuntu-vnc:latest

# Push to Docker Hub (requires login)
docker push wharsojo/lubuntu-vnc:latest
```
## Usage
```bash
docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -e RESOLUTION=1920x1080 \
  lubuntu-vnc
```
### Configuration Options
- RESOLUTION : Set custom resolution (default: 1920x1080)
- VNC_PASSWORD : Set custom VNC password (default: 1)
## Connecting
- Use any VNC client (e.g., RealVNC, TigerVNC)
- Connect to:
  - localhost:5900 or
  - localhost:5901
- Enter password: 1
## Notes
- Minimal Lubuntu installation
- Recommended VNC clients: TigerVNC Viewer, RealVNC Viewer
### Security Note
The default VNC password is set to '1' for demonstration purposes. For production use:

- Change the VNC password using the VNC_PASSWORD environment variable:
  ```bash
  -e VNC_PASSWORD=your_secure_password
  ```