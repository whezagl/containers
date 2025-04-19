# Chromium Base Container

A base Docker container with Chromium browser running on LXQT desktop environment.

## Features
- Debian Bookworm base system
- LXQT desktop environment with Openbox window manager
- Chromium browser with GPU acceleration
- Kitty terminal emulator
- ZSH shell with:
  - Zim Framework
  - Powerlevel10k theme
  - Auto-suggestions
  - Syntax highlighting
- Development tools:
  - vim, git, curl
  - ripgrep, fzf
  - Featherpad text editor

## Default Configuration
- User: vncuser (password: 1)
- Sudo access enabled (no password required)
- Pre-configured Chromium with GPU rasterization
- Custom LXQT session settings
- Optimized terminal configuration

## Build Instructions
```bash
# Build the image
docker build -t chromium-base .

# For detailed build progress
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-base .  

# Tag for Docker Hub
docker tag chromium-base:latest wharsojo/chromium-base:latest

# Push to Docker Hub (requires login)
docker push wharsojo/chromium-base:latest
```