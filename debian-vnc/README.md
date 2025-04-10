your_secure_password
```bash
docker build -t debian-vnc .

docker run -dit \
  -p 5900:5900 \
  -p 5901:5901 \
  -e RESOLUTION=1920x1080 \
  debian-vnc
```