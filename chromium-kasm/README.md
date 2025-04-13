password:password
```bash
docker build -t chromium-kasm .
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-kasm .  

docker tag chromium-kasm:latest wharsojo/chromium-kasm:latest

docker run -it \
  -p 8444:8444 \
  -v $(pwd)/user:/home/vncuser/user \
  -v $(pwd)/user/.zim:/home/vncuser/.zim \
  -v $(pwd)/user/.config/lxqt:/home/vncuser/.config/lxqt \
  -v $(pwd)/user/etc/xdg/menus:/etc/xdg/menus \
  chromium-kasm 
```
Access: https://localhost:8444/