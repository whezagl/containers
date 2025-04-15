password:1
```bash
docker build -t chromium-novnc .
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-novnc .  

docker tag chromium-novnc:latest wharsojo/chromium-novnc:latest
docker push wharsojo/chromium-novnc:latest

docker run -dit \
  -p 6080:6080 \
  -e RESOLUTION=1910x965 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  --name chromium-novnc chromium-novnc

docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -p 6080:6080 \
  -e RESOLUTION=1910x965 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  --name chromium-novnc chromium-novnc
```