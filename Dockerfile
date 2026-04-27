FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    openbox \
    chromium-browser \
    firefox \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD Xvfb :1 -screen 0 1280x720x24 & \
    sleep 3 && \
    x11vnc -display :1 -nopw -forever -shared -bg -quiet && \
    sleep 2 && \
    DISPLAY=:1 openbox & \
    sleep 1 && \
    DISPLAY=:1 firefox & \
    websockify --web=/usr/share/novnc 8080 localhost:5900
