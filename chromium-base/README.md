password:1
```bash
docker build -t chromium-base .
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-base .  

docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -e RESOLUTION=1920x1080 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/.zim:/home/vncuser/.zim \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  chromium-base
```