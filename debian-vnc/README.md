password:1
```bash
docker build -t debian-vnc .
DOCKER_BUILDKIT=1 docker build --progress=plain -t debian-vnc .  

docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -e RESOLUTION=1920x1080 \
  debian-vnc
```