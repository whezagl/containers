# Chromium Kasm Container

A Docker container with Chromium browser and Kasm Workspace, based on chromium-base image.

## Features
- All features from chromium-base:
  - Debian Bookworm with LXQT desktop
  - Chromium browser with GPU acceleration
  - ZSH with Zim Framework and Powerlevel10k
  - Development tools and utilities
- Kasm Workspace features:
  - Secure web-based access (port 8444)
  - SSL/TLS encryption
  - Interactive setup for security
  - Modern HTML5 interface

## Prerequisites
- Docker installed and running
- At least 2GB of free RAM
- Modern web browser with SSL support

## Build Instructions
```bash
# Build the image
docker build -t chromium-kasm .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-kasm .  

# Tag for Docker Hub
docker tag chromium-kasm:latest wharsojo/chromium-kasm:latest

# Push to Docker Hub (requires login)
docker push wharsojo/chromium-kasm:latest
```
## Usage
```bash
docker run -it \
  -p 8444:8444 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/.zim:/home/vncuser/.zim \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  --name chromium-kasm chromium-kasm 
```
### Volume Mounts
- /home/vncuser/user : User data directory
- /home/vncuser/.zim : ZSH framework configuration
- /home/vncuser/.config/lxqt : LXQT desktop settings
- /etc/xdg/menus : Application menu configuration
## Initial Setup
1. Run the container in interactive mode
2. Follow the prompts to:
   - Set up admin credentials
   - Configure workspace settings
   - Set security options
## Connecting
1. Open your web browser
2. Navigate to: https://localhost:8444
3. Log in with credentials set during initial setup
## Notes
- Base image: wharsojo/chromium-base:latest
- Interactive setup required for security
- Secure HTTPS connection required
- Supports all modern browsers
