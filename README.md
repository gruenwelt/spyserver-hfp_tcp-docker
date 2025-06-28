# Combined spyserver and hfp_tcp server docker container

A Dockerized build and runtime environment for libairspyhf driver for sypserver, spyserver itself and hfp_tcp server and runs both servers in a container.

This setup runs efficiently even on compact ARM64 single-board computers such as the Raspberry Pi, ensuring broader accessibility and ease of use for common DIY and SDR projects. Thanks to Docker-based isolation, it is also portable and can be deployed on a broad range of systems, including desktops and standard Linux servers.

---

## 📌 Version

**v1.0.0** — Initial release with Docker  
**Tested on**: Orange Pi Zero 2W (4GB RAM) and Banana Pi W4 Zero (2GB RAM) + Airspy Discovery HF+; and connected from client softwares SDR Receiver and SDR++ 2

---

## 📦 Requirements

- Linux-based host system
- Docker installed on the host
- Airspy hardware (e.g., Airspy HF+ Discovery)
- Client software (e.g., SDR++ 2, SDR Receiver)
- spyserver*.tar for Linux  
  👉 Downloaded from [Airspy.com](https://airspy.com/download)

---

## 🏗️ Build Instructions

1. Clone this repository:

   ```bash
   git clone https://github.com/gruenwelt/spyserver-hfp_tcp-docker
   cd spyserver-hfp_tcp-docker
   ```

2. Download the `spyserver*.tar` file and place it in the root of this repo.

3. Build and run the container:

   ```bash
   docker compose up -d
   ```

---

👉 Notes

- While both servers (Spyserver or hfp_tcp) are running parallely and waiting for connection, connection is possible to only one server at a time as the hardware is locked by either server upon connection.
- Port `5555` is for Spyserver and port `1234` is for hfp_tcp server. Both must be open and mapped for clients to connect.

---
