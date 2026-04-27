FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    openbox \
    firefox-esr \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

EXPOSE 8080

CMD bash -c "\
    Xvfb :1 -screen 0 1024x600x16 & \
    sleep 2 && \
    x11vnc -display :1 -nopw -forever -shared -bg -quiet && \
    sleep 1 && \
    DISPLAY=:1 openbox & \
    sleep 1 && \
    DISPLAY=:1 firefox-esr \
      --no-remote \
      --new-instance \
      --disable-gpu \
      --no-first-run \
      about:blank & \
    websockify --web=/usr/share/novnc 8080 localhost:5900"
