# Combined spyserver and hfp_tcp server docker container
A Dockerfile that builds and installs the required libairspyhf driver for sypserver and hfp_tcp server and runs both in a container.

Tested to run on Orange Pi Zero 2W and Airspy Discovery HF+ and remote connected from a Mac with SDR++ 2 software and from an iPhone with the SDR Receiver app. Should be able to run on other arm64 single-board computers like Raspberry Pi or other linux computers.

---

## 📦 Prerequisites
- Repo cloned locally
  ```bash
  git clone https://github.com/gruenwelt/spyserver-hfp_tcp-docker
  ```
- The spyserver file spyserver*.tar downloaded from [Airspy.com](https://airspy.com/download) and saved in the root of the repo

---

## 🏗️ Build the Docker image
```bash
docker build -t spyserver-hfp_tcp-server .
```

---

## 🚀 Run the Container
```bash
docker run -d \
  --name spyserver-hfp_tcp_server-container \
  --device /dev/bus/usb \
  --restart unless-stopped \
  -p 5555:5555 \
  -p 1234:1234 \
  spyserver-hfp_tcp-server
```

---

👉 Notes

- You must manually download and provide the spyserver*.tar file.
- The first port listed in the docker run is for Spyserver (5555) and second is for hfp_tcp server (1234).
