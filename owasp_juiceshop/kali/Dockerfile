FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        kali-linux-default \
        kali-desktop-xfce \
        burpsuite \
        dbus-x11 \
        novnc \
        sudo \
        tigervnc-standalone-server \
        tigervnc-tools \
        websockify \
        zaproxy \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --groups sudo kali \
    && echo "kali ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kali \
    && mkdir -p /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

USER kali
ENV USER=kali
WORKDIR /home/kali

EXPOSE 6080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
