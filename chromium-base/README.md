```bash
docker build -t chromium-base .
DOCKER_BUILDKIT=1 docker build --progress=plain -t chromium-base .  

docker tag chromium-base:latest wharsojo/chromium-base:latest

docker push wharsojo/chromium-base:latest
```