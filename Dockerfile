FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    openbox \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD Xvfb :1 -screen 0 1280x720x24 & \
    sleep 2 && \
    openbox & \
    sleep 1 && \
    DISPLAY=:1 chromium-browser --no-sandbox & \
    sleep 2 && \
    websockify --web=/usr/share/novnc 8080 localhost:5900
